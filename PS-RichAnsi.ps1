function Test-AnsiTag {
    param([string]$Tag)

    if ([string]::IsNullOrWhiteSpace($Tag)) {
        return $false
    }

    $tag = $Tag.Trim()

    if ($tag.StartsWith("/")) {
        $inner = $tag.Substring(1).Trim()

        if ([string]::IsNullOrWhiteSpace($inner)) {
            return $true
        }

        $tokens = Split-AnsiTag $inner

        foreach ($token in $tokens) {
            $t = $token.ToLower()

            if ($script:AnsiStyleMap.ContainsKey($t)) { return $true }
            if ($t -in @("color", "fg", "foreground", "bg", "background", "font", "reset", "all")) { return $true }
            if ($script:AnsiColorMap.ContainsKey($t)) { return $true }
            if ($t.StartsWith("bg")) { return $true }
        }

        return $false
    }

    $tokens = Split-AnsiTag $tag

    foreach ($token in $tokens) {
        $t = $token.ToLower()

        if ($script:AnsiStyleMap.ContainsKey($t)) { return $true }
        if ($t -in @("reset", "all", "font", "color", "fg", "foreground", "bg", "background")) { return $true }

        if ($script:AnsiColorMap.ContainsKey($t)) { return $true }

        if ($t.StartsWith("bg:") -or
            $t.StartsWith("bg-") -or
            $t.StartsWith("bg_") -or
            ($t.StartsWith("bg") -and $t.Length -gt 2)) {
            return $true
        }

        if ($t.StartsWith("fg:") -or
            $t.StartsWith("fg-") -or
            $t.StartsWith("fg_")) {
            return $true
        }

        if ($t -match '^#?[0-9a-f]{6}$') {
            return $true
        }
    }

    return $false
}

function ConvertTo-AnsiMarkup {
    param([string]$Text)

    if ($null -eq $Text) {
        return ""
    }

    $state = New-AnsiState
    $output = [System.Text.StringBuilder]::new()

    # Supports:
    # [bold underline red]
    # [/bold]
    # <bold underline red>
    # </bold>
    #
    # Unknown tags are preserved literally.
    $pattern = '(\[([^\[\]]+)\]|<([^<>]+)>)'
    $matches = [regex]::Matches($Text, $pattern)

    $lastIndex = 0
    $usedMarkup = $false

    foreach ($match in $matches) {
        if ($match.Index -gt $lastIndex) {
            [void]$output.Append($Text.Substring($lastIndex, $match.Index - $lastIndex))
        }

        $raw = $match.Value
        $tag = ""

        if ($match.Groups[2].Success) {
            # Bracket tag: [bold]
            $tag = $match.Groups[2].Value.Trim()
        }
        elseif ($match.Groups[3].Success) {
            # Angle tag: <bold>
            $tag = $match.Groups[3].Value.Trim()
        }

        if (Test-AnsiTag $tag) {
            if ($tag.StartsWith("/")) {
                [void]$output.Append((Invoke-AnsiCloseTag $state $tag))
            }
            else {
                [void]$output.Append((Invoke-AnsiOpenTag $state $tag))
            }

            $usedMarkup = $true
        }
        else {
            # Preserve normal text like <file>, <T>, <unknown>, etc.
            [void]$output.Append($raw)
        }

        $lastIndex = $match.Index + $match.Length
    }

    if ($lastIndex -lt $Text.Length) {
        [void]$output.Append($Text.Substring($lastIndex))
    }

    if ($script:AnsiAutoReset -and $usedMarkup) {
        [void]$output.Append((Reset-AnsiAll $state))
    }

    return $output.ToString()
}
