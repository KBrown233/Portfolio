<#
.SYNOPSIS
    This script configures the EnableUserControl registry value to comply with STIG ID WN10-CC-000310 by setting it to "0".

.DESCRIPTION
    This script checks and sets the EnableUserControl registry value in the Windows Installer registry path to "0".
    - This prevents users from controlling Windows Installer behavior.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-09
    Last Modified   : 2025-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000310

.TESTED ON
    Date(s) Tested  : 2025-04-09
    Tested By       : Kevin Brown
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    To execute the script, run it in an elevated PowerShell window with administrator privileges:
    PS C:\Users\Kbuser\Desktop\WN10-CC-000310.ps1

.EXAMPLE
    PS C:\> .\WN10-CC-000310.ps1
    This will configure the EnableUserControl registry value to "0".
#>

# Define the registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$regName = "EnableUserControl"

# Set the desired value for EnableUserControl
$desiredValue = 0

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the registry value to disable user control of Windows Installer
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord
    Write-Output "EnableUserControl registry value has been successfully configured to 0."
} catch {
    Write-Error "Failed to set the registry value. Error: $_"
}

# Confirm the setting has been applied
try {
    $setting = Get-ItemProperty -Path $regPath -Name $regName
    if ($setting.EnableUserControl -eq $desiredValue) {
        Write-Output "EnableUserControl registry value has been successfully configured to 0."
    } else {
        Write-Error "The EnableUserControl registry value is not configured as expected."
    }
} catch {
    Write-Error "Failed to read the registry value. Error: $_"
}
