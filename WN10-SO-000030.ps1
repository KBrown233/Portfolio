<#
.SYNOPSIS
    Enables policy to force subcategory audit settings to override category-level audit policies.

.DESCRIPTION
    Configures the registry to enable subcategory-level auditing for Windows, satisfying STIG WN10-SO-000030.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-21
    Version         : 1.0
    STIG-ID         : WN10-SO-000030

.TESTED ON
    Windows 10 VM (Microsoft Defender Enabled)

.USAGE
    Run in an elevated PowerShell window:
    PS C:\> .\WN10-SO-000030.ps1
#>

try {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "SCENoApplyLegacyAuditPolicy" -Value 1 -Type DWord
    Write-Output "✅ Subcategory auditing override has been enabled (STIG WN10-SO-000030)."
} catch {
    Write-Error "❌ Failed to apply STIG WN10-SO-000030. Error: $_"
}
