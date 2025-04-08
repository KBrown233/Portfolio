<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-08
    Last Modified   : 2024-04-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# YOUR CODE GOES HERE

# Define the registry key path and value
$regKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Eventlog\Application"
$regValueName = "MaxSize"
$regValue = 0x8000  # 0x8000 is equivalent to 32768 in decimal

# Check if the registry path exists
if (-not (Test-Path $regKeyPath)) {
    # If it doesn't exist, create the registry path
    New-Item -Path $regKeyPath -Force
}

# Set the registry value
Set-ItemProperty -Path $regKeyPath -Name $regValueName -Value $regValue

# Confirm the change
Write-Host "Registry key '$regValueName' set to $($regValue.ToString('X')) at '$regKeyPath'."
