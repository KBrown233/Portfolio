<#
.SYNOPSIS
    This script disables the "Secondary Logon" service to comply with STIG ID WN10-00-000175.

.DESCRIPTION
    The "Secondary Logon" service (seclogon) allows users to run applications with alternate credentials.
    Disabling this service reduces the attack surface by preventing elevation via this method.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-21
    Last Modified   : 2025-04-21
    Version         : 1.0
    STIG-ID         : WN10-00-000175

.TESTED ON
    Date(s) Tested  : 2025-04-21
    Systems Tested  : Windows 10 VM
    PowerShell Ver. : 5.1+

.USAGE
    Run this script in an elevated PowerShell session (as Administrator):
    PS C:\> .\WN10-00-000175.ps1

.EXAMPLE
    PS C:\> .\WN10-00-000175.ps1
    This will set the "Secondary Logon" service startup type to "Disabled".
#>

# Define the service name
$serviceName = "seclogon"

try {
    # Check if the service exists
    if (Get-Service -Name $serviceName -ErrorAction Stop) {
        # Set the service startup type to Disabled
        Set-Service -Name $serviceName -StartupType Disabled
        Write-Output "✅ '$serviceName' service has been successfully set to Disabled."
    }
} catch {
    Write-Error "❌ Failed to configure '$serviceName' service. Error: $_"
}
