<#
.SYNOPSIS
    This script configures the EnableScriptBlockLogging registry value to comply with STIG ID WN10-CC-000326 by setting it to "1".

.DESCRIPTION
    This script checks and sets the EnableScriptBlockLogging registry value in the PowerShell configuration registry path to "1".
    - This enables PowerShell Script Block Logging, which helps in monitoring and logging script block activity for security auditing.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-09
    Last Modified   : 2025-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000326

.TESTED ON
    Date(s) Tested  : 2025-04-09
    Tested By       : Kevin Brown
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    To execute the script, run it in an elevated PowerShell window with administrator privileges:
    PS C:\Users\Kbuser\Desktop\WN10-CC-000326.ps1

.EXAMPLE
    PS C:\> .\WN10-CC-000326.ps1
    This will configure the EnableScriptBlockLogging registry value to "1".
#>

# Define the registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
$regName = "EnableScriptBlockLogging"

# Set the desired value for EnableScriptBlockLogging
$desiredValue = 1

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the registry value to enable script block logging
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord
    Write-Output "EnableScriptBlockLogging registry value has been successfully configured to 1."
} catch {
    Write-Error "Failed to set the registry value. Error: $_"
}

# Confirm the setting has been applied
try {
    $setting = Get-ItemProperty -Path $regPath -Name $regName
    if ($setting.EnableScriptBlockLogging -eq $desiredValue) {
        Write-Output "EnableScriptBlockLogging registry value has been successfully configured to 1."
    } else {
        Write-Error "The EnableScriptBlockLogging registry value is not configured as expected."
    }
} catch {
    Write-Error "Failed to read the registry value. Error: $_"
}
