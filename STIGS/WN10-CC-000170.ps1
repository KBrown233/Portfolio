<#
.SYNOPSIS
    Remediates STIG WN10-CC-000170 by setting the 'MSAOptional' registry value to 1, making Microsoft account use optional.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-11
    Last Modified   : 2025-04-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000170

.DESCRIPTION
    This script sets 'MSAOptional' to 1 under HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
    to ensure Microsoft account sign-in is optional (required for non-LTSC/B Windows 10 editions).

.TESTED ON
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    Run this script with administrative privileges.
    Example:
    PS C:\Users\Kbuser\Desktop\WN10-CC-000170.ps1
#>

# Define registry path and desired setting
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "MSAOptional"
$desiredValue = 1

# Create registry path if missing
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Apply the desired registry setting
Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord

# Confirm the setting
$currentValue = Get-ItemProperty -Path $regPath -Name $regName

if ($currentValue.$regName -eq $desiredValue) {
    Write-Host "✅ Successfully set MSAOptional to 1." -ForegroundColor Green
} else {
    Write-Host "❌ Failed to set MSAOptional." -ForegroundColor Red
}
