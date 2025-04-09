<#
.SYNOPSIS
    This script configures the DisableExceptionChainValidation registry value to comply with STIG ID WN10-00-000150 by setting it to "0".

.DESCRIPTION
    This script checks and sets the DisableExceptionChainValidation registry value in the Session Manager kernel registry path to "0".
    - This enables Structured Exception Handling Overwrite Protection (SEHOP), improving system security.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-09
    Last Modified   : 2025-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000150

.TESTED ON
    Date(s) Tested  : 2025-04-09
    Tested By       : Kevin Brown
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    To execute the script, run it in an elevated PowerShell window with administrator privileges:
    PS C:\Users\Kbuser\Desktop\WN10-00-000150.ps1

.EXAMPLE
    PS C:\> .\WN10-00-000150.ps1
    This will configure the DisableExceptionChainValidation registry value to "0".
#>

# Define the registry path and value
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"
$regName = "DisableExceptionChainValidation"

# Set the desired value for DisableExceptionChainValidation
$desiredValue = 0

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the registry value to enable SEHOP (DisableExceptionChainValidation = 0)
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord
    Write-Output "DisableExceptionChainValidation registry value has been successfully configured to 0."
} catch {
    Write-Error "Failed to set the registry value. Error: $_"
}

# Confirm the setting has been applied
try {
    $setting = Get-ItemProperty -Path $regPath -Name $regName
    if ($setting.DisableExceptionChainValidation -eq $desiredValue) {
        Write-Output "DisableExceptionChainValidation registry value has been successfully configured to 0."
    } else {
        Write-Error "The DisableExceptionChainValidation registry value is not configured as expected."
    }
} catch {
    Write-Error "Failed to read the registry value. Error: $_"
}
