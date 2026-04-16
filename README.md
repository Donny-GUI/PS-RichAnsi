# 🎨 PowerShell ANSI Color Markup

A lightweight PowerShell ANSI styling helper for readable terminal output.

This script lets you write simple rich-text markup inside `Write-Host`, but only when you explicitly opt in with `-Rich`.

Normal `Write-Host` behavior stays untouched unless `-Rich` is passed.

---

## ✨ What It Does

Instead of writing raw ANSI escape codes like this:

```powershell
Write-Host "`e[1;38;2;255;0;0mError:`e[0m Something failed"
```

You can write this:

```powershell
Write-Host -Rich "<bold red>Error:</bold> Something failed"
```

Cleaner. Safer. Easier to maintain.

---

## ✅ Why `-Rich`?

The `-Rich` switch keeps markup parsing explicit.

Without `-Rich`, this prints normally:

```powershell
Write-Host "<bold red>Error:</bold> Something failed"
```

Output:

```text
<bold red>Error:</bold> Something failed
```

With `-Rich`, markup is parsed:

```powershell
Write-Host -Rich "<bold red>Error:</bold> Something failed"
```

Output:

```text
Error: Something failed
```

With `Error:` rendered as bold red text.

This prevents accidental parsing in normal scripts, logs, templates, XML snippets, or strings that contain `<tags>`.

---

## 🚀 Quick Start

Dot-source the script:

```powershell
. .\ansi-markup.ps1
```

Use `Write-Host -Rich`:

```powershell
Write-Host -Rich "<bold green>Success:</bold> Operation completed"
Write-Host -Rich "<bold red>Error:</bold> File not found"
Write-Host -Rich "<yellow>Warning:</color> Optional config missing"
```

---

## 🧠 Basic Syntax

The script supports XML-style tags:

```powershell
Write-Host -Rich "<bold red>Error</bold>"
```

And square-bracket tags:

```powershell
Write-Host -Rich "[bold red]Error[/bold]"
```

Both work the same way.

---

## 🎨 Named Foreground Colors

Use color names directly inside a tag:

```powershell
Write-Host -Rich "<red>Red text</color>"
Write-Host -Rich "<green>Green text</color>"
Write-Host -Rich "<blue>Blue text</color>"
Write-Host -Rich "<orange>Orange text</color>"
```

Supported named colors:

```text
black
red
green
yellow
blue
magenta
cyan
white
gray
grey
darkgray
darkgrey
lightgray
lightgrey
orange
purple
pink
lime
teal
```

---

## 🧱 Background Colors

Use a `bg` prefix for background colors:

```powershell
Write-Host -Rich "<white bgblue>White text on blue</color>"
Write-Host -Rich "<black bgorange>Black text on orange</color>"
Write-Host -Rich "<yellow bgdarkgray>Yellow text on dark gray</color>"
```

Supported background forms:

```powershell
Write-Host -Rich "<bgblue>Background blue</color>"
Write-Host -Rich "<bg:blue>Background blue</color>"
Write-Host -Rich "<bg-blue>Background blue</color>"
Write-Host -Rich "<bg_blue>Background blue</color>"
```

---

## 🌈 Hex RGB Colors

Use 6-digit RGB hex values for custom colors:

```powershell
Write-Host -Rich "<#00ffaa>Mint green text</color>"
Write-Host -Rich "<bold #ff5555>Error text</bold>"
Write-Host -Rich "<#ffffff bg#202020>White on dark gray</color>"
```

Hex format:

```text
#RRGGBB
```

Examples:

```powershell
Write-Host -Rich "<#ff0000>Red</color>"
Write-Host -Rich "<#00ff00>Green</color>"
Write-Host -Rich "<#0000ff>Blue</color>"
Write-Host -Rich "<#ffaa00>Orange</color>"
```

---

## 🖋️ Font Styles

You can combine colors with font styles:

```powershell
Write-Host -Rich "<bold red>Bold red</bold>"
Write-Host -Rich "<underline green>Underlined green</underline>"
Write-Host -Rich "<italic cyan>Italic cyan</italic>"
Write-Host -Rich "<strike gray>Strikethrough gray</strike>"
```

Supported font styles:

```text
bold
dim
italic
underline
blink
reverse
hidden
strike
overline
```

Terminal support varies. `bold`, `underline`, and colors are widely supported. `italic`, `blink`, and `overline` depend on the terminal.

---

## 🧩 Combining Styles

Stack multiple styles in one tag:

```powershell
Write-Host -Rich "<bold underline red>Error:</bold> Invalid input"
```

Mix font styles, foreground colors, and background colors:

```powershell
Write-Host -Rich "<bold underline white bgred>CRITICAL</font>"
```

Use a full reset when needed:

```powershell
Write-Host -Rich "<bold red bgblack>Danger!</> Normal text"
```

---

## 🔁 Reset Tags

Reset only bold:

```powershell
Write-Host -Rich "<bold red>Bold red</bold> Still red"
```

Reset all colors:

```powershell
Write-Host -Rich "<red bgblack>Colored text</color> Normal colors"
```

Reset foreground only:

```powershell
Write-Host -Rich "<red>Red text</fg> Normal foreground"
```

Reset background only:

```powershell
Write-Host -Rich "<white bgblue>Blue background</bg> Normal background"
```

Reset font modifiers only:

```powershell
Write-Host -Rich "<bold underline green>Styled text</font> Normal font, still green if color remains"
```

Reset everything:

```powershell
Write-Host -Rich "<bold red bgblack>Styled text</> Normal text"
```

Available reset tags:

```text
</bold>       turns off bold only
</dim>        turns off dim only
</italic>     turns off italic only
</underline>  turns off underline only
</blink>      turns off blink only
</reverse>    turns off reverse video only
</hidden>     turns off hidden text only
</strike>     turns off strikethrough only
</overline>   turns off overline only

</color>      resets foreground and background colors
</fg>         resets foreground color only
</foreground> resets foreground color only
</bg>         resets background color only
</background> resets background color only

</font>       resets font styles only
</reset>      resets everything
</all>        resets everything
</>           resets everything
```

---

## 🏷️ Square-Bracket Syntax

Square-bracket syntax is also supported:

```powershell
Write-Host -Rich "[bold red]Error:[/bold] File missing"
Write-Host -Rich "[green]Success[/color]"
Write-Host -Rich "[white bgblue] INFO [/color] Server started"
```

This is useful when XML-style tags are awkward in your strings.

---

## 🧪 Examples

### ❌ Error Message

```powershell
Write-Host -Rich "<bold red>Error:</bold> Unable to connect to database"
```

### ✅ Success Message

```powershell
Write-Host -Rich "<bold green>Success:</bold> Migration completed"
```

### ⚠️ Warning Message

```powershell
Write-Host -Rich "<bold yellow>Warning:</bold> Config file is missing optional settings"
```

### ℹ️ Info Message

```powershell
Write-Host -Rich "<cyan>Info:</color> Server started on port 8080"
```

### 🧱 Badge Style

```powershell
Write-Host -Rich "<black bgorange> WARNING </color> Disk space is low"
Write-Host -Rich "<black bggreen> OK </color> Health check passed"
Write-Host -Rich "<white bgred> ERROR </color> Build failed"
```

### 🌌 Custom RGB Theme

```powershell
Write-Host -Rich "<bold #00ffaa>Aesir CLI</bold> <#999999>v1.0.0</color>"
Write-Host -Rich "<#ffffff bg#202020> Dark mode output </color>"
```

---

## 🧰 Normal `Write-Host` Still Works

Because rich parsing only happens with `-Rich`, normal `Write-Host` calls are preserved:

```powershell
Write-Host "Plain output"
Write-Host "This <tag>does not parse</tag>"
Write-Host -ForegroundColor Red "Native PowerShell color still works"
```

Use rich mode only when you want markup parsing:

```powershell
Write-Host -Rich "<bold red>This parses</bold>"
```

---

## 📌 Recommended Usage

Use `-Rich` for human-facing terminal output:

```powershell
Write-Host -Rich "<bold cyan>Build Started</bold>"
Write-Host -Rich "<green>✔ Restore completed</color>"
Write-Host -Rich "<green>✔ Compile completed</color>"
Write-Host -Rich "<yellow>⚠ Tests skipped</color>"
Write-Host -Rich "<black bggreen> DONE </color> Project built successfully"
```

Avoid `-Rich` for raw data output, logs intended for files, JSON, XML, CSV, or machine-readable output.

---

## ⚠️ Notes

This script styles terminal output using ANSI escape sequences.

It works best in modern ANSI-compatible terminals:

- Windows Terminal
- PowerShell 7+
- VS Code integrated terminal
- Most Linux terminals
- Most macOS terminals

Older consoles may not support every ANSI feature.

If output is redirected to a file, ANSI escape codes may be written into that file when `-Rich` is used.

---

## 🧼 Design Goal

The goal is simple:

> Make PowerShell terminal styling readable, expressive, and safe by requiring explicit rich output mode.

Instead of spreading raw ANSI codes through your scripts, write clean markup:

```powershell
Write-Host -Rich "<bold green>Success</bold>"
```

Readable scripts. Better terminal output. Less ANSI noise.
