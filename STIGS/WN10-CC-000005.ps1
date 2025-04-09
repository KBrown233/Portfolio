<#
.SYNOPSIS
    The script disables camera access from the lock screen by setting the appropriate registry value to prevent apps from using the camera while the system is locked.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-09
    Last Modified   : 2024-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 2025-04-09
    Tested By       : 2025-04-09
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\Users\Kbuser\Desktop\WN10-CC-000005.ps1 
#>

# Define the registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$regName = "NoLockScreenCamera"

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the registry value to 1 (disables camera access on the lock screen)
Set-ItemProperty -Path $regPath -Name $regName -Value 1 -Type DWord

# Confirm the setting has been applied
$setting = Get-ItemProperty -Path $regPath -Name $regName
if ($setting.NoLockScreenCamera -eq 1) {
    Write-Output "Camera access from the lock screen has been successfully disabled."
} else {
    Write-Output "Failed to disable camera access from the lock screen."
}
