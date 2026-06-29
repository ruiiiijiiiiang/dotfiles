# Tool initializations
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    zoxide init powershell | Out-String | Invoke-Expression
}
if (Get-Command starship -ErrorAction SilentlyContinue) {
    starship init powershell | Out-String | Invoke-Expression
}
if (Get-Command atuin -ErrorAction SilentlyContinue) {
    atuin init powershell | Out-String | Invoke-Expression
}
if (Get-Command carapace -ErrorAction SilentlyContinue) {
    Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
    Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
    carapace _carapace | Out-String | Invoke-Expression
}

# Aliases
Set-Alias -Name cd -Value z -Option Force -ErrorAction SilentlyContinue
Set-Alias -Name ls -Value lsd -Option Force -ErrorAction SilentlyContinue
Set-Alias -Name cat -Value bat -Option Force -ErrorAction SilentlyContinue
Set-Alias -Name l -Value lsd -Option Force -ErrorAction SilentlyContinue
Set-Alias -Name nv -Value nvim -Option Force -ErrorAction SilentlyContinue
Set-Alias -Name lg -Value lazygit -Option Force -ErrorAction SilentlyContinue

# Abbreviations & command wrappers
function lt { lsd --tree $args }
function lta { lsd --tree -a $args }

# Navigation abbreviations (q+)
function q { Set-Location .. }
function qq { Set-Location ../.. }
function qqq { Set-Location ../../.. }
function qqqq { Set-Location ../../../.. }
function qqqqq { Set-Location ../../../../../ }

# Interactive Functions
function fzf {
    $file = (fzf --preview "bat --style=numbers --color=always --line-range :500 {}")
    if ($file) {
        nvim $file
    }
}

function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    if (Test-Path $tmp) {
        $cwd = Get-Content $tmp -Raw
        if ($cwd -and $cwd -ne $PWD) {
            Set-Location $cwd
        }
        Remove-Item $tmp -ErrorAction SilentlyContinue
    }
}

function open {
    Start-Process $args
}

function hx {
    if (Get-Command hx -ErrorAction SilentlyContinue) {
        hx $args
    } elseif (Get-Command helix -ErrorAction SilentlyContinue) {
        helix $args
    } else {
        Write-Error "Helix not installed"
    }
}

# WezTerm Explorer
function wezterm_explorer {
    # Inform WezTerm that this is the explorer pane by setting the user variable.
    # "explorer" base64 encoded is "ZXhwbG9yZXI="
    Write-Host -NoNewline "$([char]27)]1337;SetUserVar=WEZTERM_ROLE=ZXhwbG9yZXI=$([char]7)"

    [Console]::CursorVisible = $false

    function _render_dir {
        Clear-Host
        if (Get-Command lsd -ErrorAction SilentlyContinue) {
            lsd -A -F --icon=always --color=always
        } else {
            Get-ChildItem -Force
        }
        Write-Host ([char]10 + '────────────────────────────────────────' + [char]10 + ' 📂 ' + $PWD)
    }

    _render_dir

    try {
        while ($target_dir = [Console]::ReadLine()) {
            $target_dir = $target_dir.Trim()
            if ($target_dir -eq 'q' -or $target_dir -eq 'exit') {
                break
            }
            if (Test-Path -Path $target_dir -PathType Container) {
                Set-Location $target_dir
                _render_dir
            }
        }
    } finally {
        [Console]::CursorVisible = $true
    }
}

$global:LastPWD = $PWD.Path
$oldPrompt = $function:prompt
function prompt {
    if ($PWD.Path -ne $global:LastPWD) {
        $global:LastPWD = $PWD.Path
        if (Get-Command lsd -ErrorAction SilentlyContinue) {
            lsd -l
        } else {
            Get-ChildItem
        }
    }
    & $oldPrompt
}

if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
    fastfetch
}
