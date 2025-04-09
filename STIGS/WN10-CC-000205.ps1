<#
.SYNOPSIS
    This script configures the AllowTelemetry registry value to comply with STIG ID WN10-CC-000205 by setting it to 0 (Security).

.DESCRIPTION
    This script checks and sets the AllowTelemetry registry value in the Windows DataCollection policy to 0 (Security).
    - This is done to reduce telemetry data collection to the minimum required for security purposes.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-09
    Last Modified   : 2025-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000205

.TESTED ON
    Date(s) Tested  : 2025-04-09
    Tested By       : Kevin Brown
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    To execute the script, run it in an elevated PowerShell window with administrator privileges:
    PS C:\Users\YourUserName\Desktop\WN10-CC-000205.ps1

.EXAMPLE
    PS C:\> .\WN10-CC-000205.ps1
    This will configure the AllowTelemetry registry value to 0 (Security).
#>

# Define the registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
$regName = "AllowTelemetry"

# Set the registry value to 0 (Security)
$desiredValue = 0  # This sets the telemetry level to Security (minimum)

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the registry value to 0 (Security)
Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord

# Confirm the setting has been applied
$setting = Get-ItemProperty -Path $regPath -Name $regName
if ($setting.AllowTelemetry -eq $desiredValue) {
    Write-Output "AllowTelemetry registry value has been successfully configured to $desiredValue (Security)."
} else {
    Write-Output "Failed to configure the AllowTelemetry registry value."
}
