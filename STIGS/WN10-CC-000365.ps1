<#
.SYNOPSIS
    Configures registry settings to comply with STIG WN10-CC-000365 regarding voice activation while the system is locked.

.DESCRIPTION
    This script checks for and sets the required registry values for App Privacy settings to force deny app voice activation above the lock screen, unless the global voice activation policy is already set to force deny, in which case the requirement is NA.

.NOTES
    Author          : Kevin Brown  
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/  
    GitHub          : https://github.com/KBrown233  
    Date Created    : 2025-04-21  
    Last Modified   : 2025-04-21  
    Version         : 1.0  
    STIG-ID         : WN10-CC-000365  

.TESTED ON
    Date(s) Tested  : 2025-04-21  
    Tested By       : Kevin Brown  
    Systems Tested  : Windows 10 Pro 22H2  
    PowerShell Ver. : 5.1  

.USAGE
    Run this script in an elevated PowerShell window:
    PS C:\> .\WN10-CC-000365.ps1

.EXAMPLE
    PS C:\> .\WN10-CC-000365.ps1
#>

# Define registry paths and values
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"
$voiceKey = "LetAppsActivateWithVoice"
$voiceAboveLockKey = "LetAppsActivateWithVoiceAboveLock"
$forceDenyValue = 2

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

# Check if LetAppsActivateWithVoice is already set to Force Deny
$globalVoiceSetting = $null
try {
    $globalVoiceSetting = (Get-ItemProperty -Path $regPath -Name $voiceKey -ErrorAction Stop).$voiceKey
} catch {
    Write-Output "ℹ️ '$voiceKey' not currently set. Will configure '$voiceAboveLockKey'."
}

if ($globalVoiceSetting -eq $forceDenyValue) {
    Write-Output "✅ '$voiceKey' is already set to 'Force Deny' (2). STIG WN10-CC-000365 is Not Applicable."
    exit
}

# Set LetAppsActivateWithVoiceAboveLock to Force Deny
try {
    Set-ItemProperty -Path $regPath -Name $voiceAboveLockKey -Value $forceDenyValue -Type DWord
    Write-Output "✅ '$voiceAboveLockKey' successfully set to Force Deny (2)."
} catch {
    Write-Error "❌ Failed to set '$voiceAboveLockKey'. Error: $_"
    exit
}

# Confirm the setting
try {
    $currentSetting = (Get-ItemProperty -Path $regPath -Name $voiceAboveLockKey).$voiceAboveLockKey
    if ($currentSetting -eq $forceDenyValue) {
        Write-Output "✅ Confirmed: '$voiceAboveLockKey' is correctly configured to $forceDenyValue."
    } else {
        Write-Warning "⚠️ '$voiceAboveLockKey' is set to $currentSetting instead of $forceDenyValue."
    }
} catch {
    Write-Error "❌ Failed to verify registry value. Error: $_"
}
