# 🎨 PowerShell ANSI Color Markup

A lightweight PowerShell ANSI styling helper that lets you write readable terminal color markup instead of raw escape codes.

Instead of writing this:

```powershell
"`e[1;38;2;255;0;0mError:`e[0m Something failed"
```

You can write this:

```powershell
Write-Host "<bold red>Error:</bold> Something failed"
```

Clean. Readable. Maintainable.

---

## ✨ Features

- 🎨 Named foreground colors
- 🧱 Background colors with `bg` prefixes
- 🌈 Hex RGB colors like `#00ffaa`
- 🖋️ Font styles like bold, dim, italic, underline, strike, reverse, hidden, and overline
- 🔁 Safe resets for color, background, font, or all styles
- 🏷️ Supports both `[tag]` and `<tag>` syntax
- 🧼 Automatically resets styles after marked-up output
- 🪟 Works well in Windows Terminal, PowerShell 7+, VS Code terminal, and most ANSI-compatible terminals

---

## 🚀 Quick Start

Dot-source the script:

```powershell
. .\ansi-markup.ps1
```

Then use markup directly inside `Write-Host`:

```powershell
Write-Host "<bold red>Error:</bold> File not found"
Write-Host "<green>Success:</green> Operation completed"
Write-Host "<yellow bgdarkgray>Warning:</color> Check your config"
```

---

## 🧠 Basic Syntax

You can use XML-style tags:

```powershell
Write-Host "<bold red>Error</bold>"
```

Or square-bracket tags:

```powershell
Write-Host "[bold red]Error[/bold]"
```

Both styles are supported.

---

## 🎨 Named Colors

Use color names directly inside a tag:

```powershell
Write-Host "<red>Red text</color>"
Write-Host "<green>Green text</color>"
Write-Host "<blue>Blue text</color>"
Write-Host "<orange>Orange text</color>"
```

Supported default color names:

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

Use the `bg` prefix for background colors:

```powershell
Write-Host "<white bgblue>White text on blue background</color>"
Write-Host "<black bgorange>Black text on orange background</color>"
Write-Host "<yellow bgdarkgray>Yellow text on dark gray background</color>"
```

These forms are supported:

```powershell
Write-Host "<bgblue>Background blue</color>"
Write-Host "<bg:blue>Background blue</color>"
Write-Host "<bg-blue>Background blue</color>"
Write-Host "<bg_blue>Background blue</color>"
```

---

## 🌈 Hex RGB Colors

Use full RGB hex colors for precise styling:

```powershell
Write-Host "<#00ffaa>Mint green text</color>"
Write-Host "<bold #ff5555>Error text</bold>"
Write-Host "<#ffffff bg#202020>White on dark gray</color>"
```

Hex colors must be 6 digits:

```text
#RRGGBB
```

Examples:

```powershell
Write-Host "<#ff0000>Red</color>"
Write-Host "<#00ff00>Green</color>"
Write-Host "<#0000ff>Blue</color>"
Write-Host "<#ffaa00>Orange</color>"
```

---

## 🖋️ Font Styles

You can combine colors with font styles:

```powershell
Write-Host "<bold red>Bold red</bold>"
Write-Host "<underline green>Underlined green</underline>"
Write-Host "<italic cyan>Italic cyan</italic>"
Write-Host "<strike gray>Strikethrough gray</strike>"
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

> ⚠️ Some terminals do not support every style. `bold`, `underline`, and colors are widely supported. `italic`, `blink`, and `overline` depend on the terminal.

---

## 🧩 Combining Styles

You can stack multiple styles in one tag:

```powershell
Write-Host "<bold underline red>Error:</bold> Invalid input"
```

You can also mix font styles, foreground colors, and background colors:

```powershell
Write-Host "<bold underline white bgred>CRITICAL</font>"
```

For a full reset, use:

```powershell
Write-Host "<bold red>Danger!</>"
```

or:

```powershell
Write-Host "[bold red]Danger![/]"
```

---

## 🔁 Reset Tags

Reset only bold:

```powershell
Write-Host "<bold red>Bold red</bold> Still red"
```

Reset all colors:

```powershell
Write-Host "<red bgblack>Colored text</color> Normal colors"
```

Reset all font modifiers:

```powershell
Write-Host "<bold underline green>Styled text</font> Normal font, still green if color remains"
```

Reset everything:

```powershell
Write-Host "<bold red bgblack>Styled text</> Normal text"
```

Available reset tags:

```text
</bold>       turns off bold only
</underline>  turns off underline only
</italic>     turns off italic only
</strike>     turns off strikethrough only
</color>      resets foreground and background colors
</fg>         resets foreground color only
</bg>         resets background color only
</font>       resets font styles only
</reset>      resets everything
</all>        resets everything
</>           resets everything
```

---

## 🏷️ Square Bracket Syntax

The script also supports bracket-style tags:

```powershell
Write-Host "[bold red]Error:[/bold] File missing"
Write-Host "[green]Success[/color]"
Write-Host "[white bgblue]Info[/color]"
```

This is useful when you do not want XML-like tags in your terminal strings.

---

## 🧪 Examples

### Error Message

```powershell
Write-Host "<bold red>Error:</bold> Unable to connect to database"
```

### Success Message

```powershell
Write-Host "<bold green>Success:</bold> Migration completed"
```

### Warning Message

```powershell
Write-Host "<bold yellow>Warning:</bold> Config file is missing optional settings"
```

### Info Message

```powershell
Write-Host "<cyan>Info:</color> Server started on port 8080"
```

### Badge Style

```powershell
Write-Host "<black bgorange> WARNING </color> Disk space is low"
Write-Host "<black bggreen> OK </color> Health check passed"
Write-Host "<white bgred> ERROR </color> Build failed"
```

### Custom RGB Theme

```powershell
Write-Host "<bold #00ffaa>Aesir CLI</bold> <#999999>v1.0.0</color>"
Write-Host "<#ffffff bg#202020> Dark mode output </color>"
```

---

## 🧱 Intended Use Cases

This helper is useful for:

- CLI tools
- Build scripts
- Deployment logs
- Status messages
- Developer tooling
- Terminal dashboards
- PowerShell utilities
- Lightweight terminal UI output

---

## ⚠️ Notes

This script styles terminal output using ANSI escape sequences.

It works best in modern terminals such as:

- Windows Terminal
- PowerShell 7+
- VS Code integrated terminal
- Most Linux/macOS terminals

Older consoles may not support all ANSI features.

Also, this is intended for terminal display. If output is redirected to a file, the raw ANSI escape codes may be written unless you disable styling.

---

## 📌 Example Output Design

```powershell
Write-Host "<bold cyan>Build Started</bold>"
Write-Host "<green>✔ Restore completed</color>"
Write-Host "<green>✔ Compile completed</color>"
Write-Host "<yellow>⚠ Tests skipped</color>"
Write-Host "<black bggreen> DONE </color> Project built successfully"
```

---

## 🧼 Design Goal

The goal is simple:

> Make PowerShell terminal styling readable, expressive, and easy to maintain.

Instead of raw ANSI codes scattered everywhere, your output can use clean markup:

```powershell
Write-Host "<bold green>Success</bold>"
```

That is easier to write, easier to read, and easier to change.
