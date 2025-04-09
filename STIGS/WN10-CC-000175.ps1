<#
.SYNOPSIS
    This script configures the DisableInventory registry value to comply with STIG ID N10-CC-000175 by setting it to 1.

.DESCRIPTION
    This script checks and sets the DisableInventory registry value in the Windows AppCompat policy to 1.
    - This ensures that inventory-related functionalities for application compatibility are disabled, as specified by the STIG.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-09
    Last Modified   : 2025-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : N10-CC-000175

.TESTED ON
    Date(s) Tested  : 2025-04-09
    Tested By       : Kevin Brown
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    To execute the script, run it in an elevated PowerShell window with administrator privileges:
    PS C:\Users\Kbuser\Desktop\N10-CC-000175.ps1

.EXAMPLE
    PS C:\> .\N10-CC-000175.ps1
    This will configure the DisableInventory registry value to 1.
#>

# Define the registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"
$regName = "DisableInventory"

# Set the registry value to 1
$desiredValue = 1  # This disables application inventory functionality

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the registry value to 1
Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord

# Confirm the setting has been applied
$setting = Get-ItemProperty -Path $regPath -Name $regName
if ($setting.DisableInventory -eq $desiredValue) {
    Write-Output "DisableInventory registry value has been successfully configured to $desiredValue."
} else {
    Write-Output "Failed to configure the DisableInventory registry value."
}
