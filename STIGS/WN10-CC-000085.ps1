<#
.SYNOPSIS
    Configures Early Launch Antimalware Boot-Start Driver Initialization policy in compliance with STIG WN10-CC-000085.

.NOTES
    Author          : Kevin Brown  
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/  
    GitHub          : https://github.com/KBrown233  
    Date Created    : 2025-04-11  
    Last Modified   : 2025-04-11  
    Version         : 1.0  
    STIG-ID         : WN10-CC-000085  

.DESCRIPTION
    Sets the DriverLoadPolicy registry value under Early Launch Antimalware to a secure setting.
    Acceptable values are 1, 3, or 8. This script sets it to 3 (default and STIG-compliant).

.TESTED ON
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)  
    PowerShell Ver. :  

.USAGE
    Run as administrator:
    PS C:\Users\Kbuser\Desktop\WN10-CC-000085.ps1
#>

# Registry configuration
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Policies\EarlyLaunch"
$regName = "DriverLoadPolicy"
$desiredValue = 3  # Can be changed to 1 or 8 if preferred

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord

# Verify the setting
$currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName

if ($currentValue -eq $desiredValue) {
    Write-Host "✅ DriverLoadPolicy successfully set to $desiredValue." -ForegroundColor Green
} else {
    Write-Host "❌ Failed to set DriverLoadPolicy to $desiredValue." -ForegroundColor Red
}
