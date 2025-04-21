<#
.SYNOPSIS
    Disables toast notifications on the lock screen for the current user.

.DESCRIPTION
    This script sets the registry value 'NoToastApplicationNotificationOnLockScreen' to 1
    under HKEY_CURRENT_USER to comply with STIG ID WN10-UC-000015.

.NOTES
    Author          : Kevin Brown  
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/  
    GitHub          : https://github.com/KBrown233  
    Date Created    : 2025-04-21  
    Last Modified   : 2025-04-21  
    Version         : 1.0  
    STIG-ID         : WN10-UC-000015  

.TESTED ON
    Date(s) Tested  : 2025-04-21  
    Tested By       : Kevin Brown  
    Systems Tested  : Windows 10 Pro  
    PowerShell Ver. : 5.1  

.USAGE
    Run this script as the user whose settings need to be configured:
    PS C:\> .\WN10-UC-000015.ps1  

.EXAMPLE
    PS C:\> .\WN10-UC-000015.ps1
    This will configure the registry to disable toast notifications on the lock screen.
#>

# Registry Configuration
$regPath = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"
$regName = "NoToastApplicationNotificationOnLockScreen"
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

# Set the registry value
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord
    Write-Output "✅ Registry value '$regName' set to $desiredValue."
} catch {
    Write-Error "❌ Failed to set registry value. Error: $_"
    exit
}

# Confirm the setting
try {
    $currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
    if ($currentValue -eq $desiredValue) {
        Write-Output "✅ Confirmed: '$regName' is correctly configured to $desiredValue."
    } else {
        Write-Warning "⚠️ '$regName' is set to $currentValue instead of $desiredValue."
    }
} catch {
    Write-Error "❌ Failed to verify the registry setting. Error: $_"
}
