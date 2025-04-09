<#
.SYNOPSIS
    This script configures the SupportedEncryptionTypes registry value to comply with STIG ID WN10-SO-000190 by setting it to "0x7ffffff8".

.DESCRIPTION
    This script checks and sets the SupportedEncryptionTypes registry value in the Kerberos Parameters registry path to "0x7ffffff8" (2147483640).
    - This setting configures the encryption types supported by Kerberos.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-09
    Last Modified   : 2025-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000190

.TESTED ON
    Date(s) Tested  : 2025-04-09
    Tested By       : Kevin Brown
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    To execute the script, run it in an elevated PowerShell window with administrator privileges:
    PS C:\Users\Kbuser\Desktop\WN10-SO-000190.ps1

.EXAMPLE
    PS C:\> .\WN10-SO-000190.ps1
    This will configure the SupportedEncryptionTypes registry value to "0x7ffffff8".
#>

# Define the registry path and value
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters"
$regName = "SupportedEncryptionTypes"
$desiredValue = 0x7ffffff8  # 2147483640 in decimal

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

# Set the registry value to the desired value (SupportedEncryptionTypes = 0x7ffffff8)
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord -Force
    Write-Output "SupportedEncryptionTypes registry value has been successfully configured to 0x7ffffff8."
} catch {
    Write-Error "Failed to set the registry value. Error: $_"
    exit
}

# Confirm the setting has been applied
try {
    $setting = Get-ItemProperty -Path $regPath -Name $regName
    if ($setting.SupportedEncryptionTypes -eq $desiredValue) {
        Write-Output "SupportedEncryptionTypes registry value has been successfully configured to 0x7ffffff8."
    } else {
        Write-Error "The SupportedEncryptionTypes registry value is not configured as expected. Expected value: 0x7ffffff8."
    }
} catch {
    Write-Error "Failed to read the registry value. Error: $_"
}
