<#
.SYNOPSIS
    Sets the Machine Inactivity Timeout to 900 seconds or less to comply with STIG WN10-SO-000070.

.DESCRIPTION
    This script configures the "InactivityTimeoutSecs" registry value under the System policies key.
    It ensures that a timeout period of 900 seconds (or less) is enforced to lock inactive sessions.

.NOTES
    Author          : Kevin Brown  
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/  
    GitHub          : https://github.com/KBrown233  
    Date Created    : 2025-04-21  
    Last Modified   : 2025-04-21  
    Version         : 1.1  
    STIG-ID         : WN10-SO-000070  

.TESTED ON
    Date(s) Tested  : 2025-04-21  
    Tested By       : Kevin Brown  
    Systems Tested  : Windows 10 VM  
    PowerShell Ver. : 5.1+

.USAGE
    Run in an elevated PowerShell window:
    PS C:\> .\WN10-SO-000070.ps1

.EXAMPLE
    PS C:\> .\WN10-SO-000070.ps1
    This will set the machine inactivity limit to 900 seconds.
#>

# Define registry path and desired setting
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "InactivityTimeoutSecs"
$desiredValue = 900

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    try {
        New-Item -Path $regPath -Force | Out-Null
        Write-Output "✅ Created missing registry path: $regPath"
    } catch {
        Write-Error "❌ Failed to create registry path. Error: $_"
        exit
    }
}

# Apply the timeout setting
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord
    Write-Output "✅ 'InactivityTimeoutSecs' has been successfully set to $desiredValue seconds."
} catch {
    Write-Error "❌ Failed to set the registry value. Error: $_"
}

# Confirm the value
try {
    $currentValue = (Get-ItemProperty -Path $regPath -Name $regName).$regName
    if (($currentValue -le $desiredValue) -and ($currentValue -ne 0)) {
        Write-Output "✅ Confirmed: Inactivity timeout is set correctly to $currentValue seconds."
    } else {
        Write-Warning "⚠️ Inactivity timeout is not within compliance: $currentValue"
    }
} catch {
    Write-Error "❌ Failed to confirm the registry value. Error: $_"
}
