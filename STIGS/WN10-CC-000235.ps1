<#
.SYNOPSIS
    Configures the registry setting to prevent bypassing Windows Defender SmartScreen prompts for files.

.DESCRIPTION
    This script sets the PreventOverrideAppRepUnknown value under the Microsoft Edge PhishingFilter registry key
    to enforce SmartScreen prompts and comply with STIG ID WN10-CC-000235.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-21
    Last Modified   : 2025-04-21
    Version         : 1.0
    STIG-ID         : WN10-CC-000235

.TESTED ON
    Date(s) Tested  : 2025-04-21
    Tested By       : Kevin Brown
    Systems Tested  : Windows 10 Pro (non-LTSC), with Microsoft Edge installed
    PowerShell Ver. : 5.1

.USAGE
    Run this script in an elevated PowerShell session:
    PS C:\> .\WN10-CC-000235.ps1

.EXAMPLE
    PS C:\> .\WN10-CC-000235.ps1
    This sets the registry key to prevent SmartScreen bypass in Microsoft Edge.
#>

# Registry configuration
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter"
$regName = "PreventOverrideAppRepUnknown"
$desiredValue = 1

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    try {
        New-Item -Path $regPath -Force | Out-Null
        Write-Output "✅ Created registry path: $regPath"
    } catch {
        Write-Error "❌ Failed to create registry path. Error: $_"
        exit
    }
}

# Set the registry key
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord
    Write-Output "✅ Registry key '$regName' has been successfully set to $desiredValue."
} catch {
    Write-Error "❌ Failed to set registry key. Error: $_"
    exit
}

# Confirm the setting
try {
    $currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
    if ($currentValue -eq $desiredValue) {
        Write-Output "✅ Confirmed: '$regName' is set to $desiredValue and in compliance."
    } else {
        Write-Warning "⚠️ '$regName' is set to $currentValue. Expected: $desiredValue."
    }
} catch {
    Write-Error "❌ Failed to verify registry setting. Error: $_"
}
