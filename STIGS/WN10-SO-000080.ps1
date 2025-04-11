<#
.SYNOPSIS
    Configures the LegalNoticeCaption for the DoD Notice and Consent Banner in compliance with STIG WN10-SO-000080.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-11
    Last Modified   : 2025-04-11
    Version         : 1.0
    STIG-ID         : WN10-SO-000080

.DESCRIPTION
    Sets the 'LegalNoticeCaption' registry value to a site-approved notice title.
    Required for displaying a compliant login banner on Windows systems.

.TESTED ON
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    Run this script with administrative privileges.
    Example:
    PS C:\Users\Kbuser\Desktop\WN10-SO-000080.ps1
#>

# Define the registry path and the required value
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "LegalNoticeCaption"
$regValue = "DoD Notice and Consent Banner"  # Replace with your site-defined title if needed

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type String

# Confirm
$current = Get-ItemProperty -Path $regPath -Name $regName
if ($current.LegalNoticeCaption -eq $regValue) {
    Write-Host "✅ LegalNoticeCaption successfully set to: '$regValue'" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to set LegalNoticeCaption." -ForegroundColor Red
}
