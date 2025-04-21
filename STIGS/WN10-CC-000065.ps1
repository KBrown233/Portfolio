<#
.SYNOPSIS
    Configures registry setting to comply with STIG WN10-CC-000065 by disabling automatic Wi-Fi Sense connections.

.DESCRIPTION
    This script sets the 'AutoConnectAllowedOEM' registry value to '0' under the WcmSvc Wi-Fi network manager config path.
    This prevents automatic connection to suggested open hotspots, networks shared by contacts, or paid Wi-Fi hotspots.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-21
    Last Modified   : 2025-04-21
    Version         : 1.0
    STIG-ID         : WN10-CC-000065

.TESTED ON
    Date(s) Tested  : 2025-04-21
    Tested By       : Kevin Brown
    Systems Tested  : Windows 10 Pro 22H2
    PowerShell Ver. : 5.1

.USAGE
    Run this script in an elevated PowerShell session:
    PS C:\> .\WN10-CC-000065.ps1

.EXAMPLE
    PS C:\> .\WN10-CC-000065.ps1
#>

# Define registry path and value
$regPath = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"
$regName = "AutoConnectAllowedOEM"
$desiredValue = 0

# Ensure registry path exists
if (-not (Test-Path $regPath)) {
    try {
        New-Item -Path $regPath -Force | Out-Null
        Write-Output "✅ Created registry path: $regPath"
    } catch {
        Write-Error "❌ Failed to create registry path. Error: $_"
        exit
    }
}

# Set registry value
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord
    Write-Output "✅ '$regName' successfully set to $desiredValue."
} catch {
    Write-Error "❌ Failed to set registry value. Error: $_"
    exit
}

# Confirm the setting
try {
    $currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
    if ($currentValue -eq $desiredValue) {
        Write-Output "✅ Confirmed: '$regName' is configured correctly as $desiredValue."
    } else {
        Write-Warning "⚠️ '$regName' is set to $currentValue instead of $desiredValue."
    }
} catch {
    Write-Error "❌ Failed to verify registry value. Error: $_"
}
