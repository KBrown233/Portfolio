<#
.SYNOPSIS
    This script configures the SCENoApplyLegacyAuditPolicy registry value to comply with STIG ID WN10-SO-000030 by setting it to 1.

.DESCRIPTION
    This script checks and sets the SCENoApplyLegacyAuditPolicy registry value in the Lsa registry path to 1.
    - This ensures that legacy audit policies are not applied as specified by the STIG.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-09
    Last Modified   : 2025-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000030

.TESTED ON
    Date(s) Tested  : 2025-04-09
    Tested By       : Kevin Brown
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    To execute the script, run it in an elevated PowerShell window with administrator privileges:
    PS C:\Users\Kbuser\Desktop\WN10-SO-000030.ps1

.EXAMPLE
    PS C:\> .\WN10-SO-000030.ps1
    This will configure the SCENoApplyLegacyAuditPolicy registry value to 1.
#>

# Define the registry path and value
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$regName = "SCENoApplyLegacyAuditPolicy"

# Set the registry value to 1
$desiredValue = 1  # This ensures legacy audit policies are not applied

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the registry value to 1
Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord

# Confirm the setting has been applied
$setting = Get-ItemProperty -Path $regPath -Name $regName
if ($setting.SCENoApplyLegacyAuditPolicy -eq $desiredValue) {
    Write-Output "SCENoApplyLegacyAuditPolicy registry value has been successfully configured to $desiredValue."
} else {
    Write-Output "Failed to configure the SCENoApplyLegacyAuditPolicy registry value."
}
