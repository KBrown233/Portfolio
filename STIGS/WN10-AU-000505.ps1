<#
.SYNOPSIS
    Ensures Security Event Log maximum size is set to at least 1,024,000 KB per STIG WN10-AU-000505.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-11
    Last Modified   : 2025-04-11
    Version         : 1.0
    STIG-ID         : WN10-AU-000505

.DESCRIPTION
    Sets the 'MaxSize' registry value under the Security Event Log policy to a minimum of 1024000 KB (1 GB).

.TESTED ON
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    Run as administrator:
    PS C:\Users\Kbuser\Desktop\WN10-AU-000505.ps1
#>

# Registry path and settings
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security"
$regName = "MaxSize"
$minSize = 1024000

# Ensure the path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get current value if it exists
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue).$regName

# Set or update the value if needed
if ($null -eq $currentValue -or $currentValue -lt $minSize) {
    Set-ItemProperty -Path $regPath -Name $regName -Value $minSize -Type DWord
    Write-Host "✅ MaxSize has been set to $minSize KB." -ForegroundColor Green
} else {
    Write-Host "ℹ️ MaxSize is already $currentValue KB. No change needed." -ForegroundColor Cyan
}
