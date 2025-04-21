<#
.SYNOPSIS
    This script sets the AllowDomainPINLogon registry value to comply with STIG ID WN10-CC-000370 by setting it to "0".

.DESCRIPTION
    This script checks for the existence of the AllowDomainPINLogon registry value under the System key.
    If it doesn't exist, the script creates the key and sets the value to 0 to prevent domain users from using PIN sign-in.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-21
    Last Modified   : 2025-04-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000370

.TESTED ON
    Date(s) Tested  : 2025-04-21
    Tested By       : Kevin Brown
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 5.1+

.USAGE
    To execute the script, run it in an elevated PowerShell window with administrator privileges:
    PS C:\Users\Kbuser\Desktop\WN10-CC-000370.ps1

.EXAMPLE
    PS C:\> .\WN10-CC-000370.ps1
    This will configure the AllowDomainPINLogon registry value to "0".
#>

# Define registry path and desired value
$regPath = "HKLM:\Software\Policies\Microsoft\Windows\System"
$regName = "AllowDomainPINLogon"
$desiredValue = 0

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    try {
        New-Item -Path $regPath -Force | Out-Null
        Write-Output "Registry path created: $regPath"
    } catch {
        Write-Error "Failed to create registry path: $_"
        exit 1
    }
}

# Set the registry value
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord
    Write-Output "AllowDomainPINLogon registry value successfully set to $desiredValue."
} catch {
    Write-Error "Failed to set the registry value. Error: $_"
    exit 1
}

# Confirm the setting
try {
    $check = Get-ItemProperty -Path $regPath -Name $regName
    if ($check.$regName -eq $desiredValue) {
        Write-Output "✅ Registry value verified: AllowDomainPINLogon = $desiredValue"
    } else {
        Write-Warning "⚠️ Registry value does not match the desired setting."
    }
} catch {
    Write-Error "Failed to verify the registry value. Error: $_"
}
