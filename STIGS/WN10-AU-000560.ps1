<#
.SYNOPSIS
    Configures audit policy subcategory settings and enables auditing of "Other Logon/Logoff Events" for Success.

.DESCRIPTION
    This script enables the "Force audit policy subcategory settings" option via the registry
    and configures Success auditing for "Other Logon/Logoff Events" using auditpol.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-21
    Last Modified   : 2025-04-21
    Version         : 1.1
    STIG-IDs        : WN10-AU-000560, WN10-SO-000030

.TESTED ON
    Windows 10 VM with PowerShell 5.1+

#>

# Set registry key to force subcategory settings to override audit policy
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$regName = "SCENoApplyLegacyAuditPolicy"
$desiredValue = 1

try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord -Force
    Write-Output "✅ 'Force audit policy subcategory settings' has been enabled via registry."
} catch {
    Write-Error "❌ Failed to set registry value for audit subcategory enforcement. $_"
}

# Configure AuditPol for "Other Logon/Logoff Events"
try {
    auditpol /set /subcategory:"Other Logon/Logoff Events" /success:enable
    if ($LASTEXITCODE -eq 0) {
        Write-Output "✅ 'Other Logon/Logoff Events' auditing for Success has been configured successfully."
    } else {
        Write-Error "❌ Failed to configure 'Other Logon/Logoff Events'. Exit Code: $LASTEXITCODE"
    }
} catch {
    Write-Error "❌ AuditPol execution failed. $_"
}
