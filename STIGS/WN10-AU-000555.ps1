<#
.SYNOPSIS
    Configures "Audit: Force audit policy subcategory settings" to Enabled and ensures "Other Policy Change Events - Failure" is audited.
    This is in compliance with STIG WN10-AU-000555.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-11
    Last Modified   : 2025-04-11
    Version         : 1.0
    STIG-ID         : WN10-AU-000555

.DESCRIPTION
    This script configures the system to enforce audit policy subcategory settings for detailed auditing 
    and ensures the auditing of "Other Policy Change Events - Failure".

.TESTED ON
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    Run this script with administrative privileges to apply the necessary security settings.
#>

# Define registry path and value name
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "AuditPolicySubcategory"

# Set "Audit: Force audit policy subcategory settings" to Enabled (Value 1)
Set-ItemProperty -Path $regPath -Name $regName -Value 1 -Type DWord

# Use AuditPol to configure the audit policy for "Other Policy Change Events - Failure"
$AuditPolCommand = "AuditPol /set /subcategory:`"Other Policy Change Events`" /failure:enable"

# Execute the command
Invoke-Expression $AuditPolCommand

# Confirm changes
Write-Host "✅ Audit: Force audit policy subcategory settings has been set to Enabled."
Write-Host "✅ 'Other Policy Change Events - Failure' audit policy has been enabled."
