<#
.SYNOPSIS
    This script configures the AllowDigest registry value to comply with STIG ID WN10-CC-000360 by setting it to "0".

.DESCRIPTION
    This script checks and sets the AllowDigest registry value in the WinRM Client registry path to "0".
    - This setting disables the Digest authentication method for Windows Remote Management (WinRM) client.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-09
    Last Modified   : 2025-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000360

.TESTED ON
    Date(s) Tested  : 2025-04-09
    Tested By       : Kevin Brown
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    To execute the script, run it in an elevated PowerShell window with administrator privileges:
    PS C:\Users\Kbuser\Desktop\WN10-CC-000360.ps1

.EXAMPLE
    PS C:\> .\WN10-CC-000360.ps1
    This will configure the AllowDigest registry value to "0".
#>

# Define the registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"
$regName = "AllowDigest"
$desiredValue = 0

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    Write-Output "The registry path does not exist. Creating the path..."
    try {
        New-Item -Path $regPath -Force
        Write-Output "Registry path created successfully."
    } catch {
        Write-Error "Failed to create registry path. Error: $_"
        exit
    }
}

# Set the registry value to disable Digest authentication (AllowDigest = 0)
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord -Force
    Write-Output "AllowDigest registry value has been successfully configured to 0."
} catch {
    Write-Error "Failed to set the registry value. Error: $_"
    exit
}

# Confirm the setting has been applied
try {
    $setting = Get-ItemProperty -Path $regPath -Name $regName
    if ($setting.AllowDigest -eq $desiredValue) {
        Write-Output "AllowDigest registry value has been successfully configured to 0."
    } else {
        Write-Error "The AllowDigest registry value is not configured as expected. Expected value: 0."
    }
} catch {
    Write-Error "Failed to read the registry value. Error: $_"
}
