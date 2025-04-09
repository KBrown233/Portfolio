<#
.SYNOPSIS
    This script configures the DisableEnclosureDownload registry value to comply with STIG ID WN10-CC-000295 by setting it to "1".

.DESCRIPTION
    This script checks and sets the DisableEnclosureDownload registry value in the Internet Explorer Feeds registry path to "1".
    - This prevents the automatic download of enclosure items in RSS feeds in Internet Explorer, as specified by the STIG.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-09
    Last Modified   : 2025-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000295

.TESTED ON
    Date(s) Tested  : 2025-04-09
    Tested By       : Kevin Brown
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    To execute the script, run it in an elevated PowerShell window with administrator privileges:
    PS C:\Users\Kbuser\Desktop\WN10-CC-000295.ps1

.EXAMPLE
    PS C:\> .\WN10-CC-000295.ps1
    This will configure the DisableEnclosureDownload registry value to "1".
#>

# Define the registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds"
$regName = "DisableEnclosureDownload"

# Set the desired value for DisableEnclosureDownload
$desiredValue = 1

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the registry value to disable enclosure download
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord
    Write-Output "DisableEnclosureDownload registry value has been successfully configured to 1."
} catch {
    Write-Error "Failed to set the registry value. Error: $_"
}

# Confirm the setting has been applied
try {
    $setting = Get-ItemProperty -Path $regPath -Name $regName
    if ($setting.DisableEnclosureDownload -eq $desiredValue) {
        Write-Output "DisableEnclosureDownload registry value has been successfully configured to 1."
    } else {
        Write-Error "The DisableEnclosureDownload registry value is not configured as expected."
    }
} catch {
    Write-Error "Failed to read the registry value. Error: $_"
}
