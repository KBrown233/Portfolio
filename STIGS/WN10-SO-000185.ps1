<#
.SYNOPSIS
    Remediates STIG WN10-SO-000185 by disabling Online ID authentication via the PKU2U protocol.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-11
    Last Modified   : 2025-04-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000185

.DESCRIPTION
    This script sets the registry key 'AllowOnlineID' to 0 to prevent the use of Online IDs for authentication.

.TESTED ON
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    Run this script with administrative privileges.
    Example:
    PS C:\Users\Kbuser\Desktop\WN10-SO-000185.ps1
#>

# Define registry path and desired values
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\LSA\pku2u"
$regName = "AllowOnlineID"
$desiredValue = 0

# Create registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord

# Confirm the change
$currentValue = Get-ItemProperty -Path $regPath -Name $regName

if ($currentValue.$regName -eq $desiredValue) {
    Write-Host "✅ Successfully set AllowOnlineID to 0. Online ID sign-in is now disabled." -ForegroundColor Green
} else {
    Write-Host "❌ Failed to set AllowOnlineID." -ForegroundColor Red
}
