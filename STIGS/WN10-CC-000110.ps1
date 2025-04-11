<#
.SYNOPSIS
    Disables HTTP printing by setting the DisableHTTPPrinting registry key in compliance with STIG WN10-CC-000110.

.NOTES
    Author          : Kevin Brown  
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/  
    GitHub          : https://github.com/KBrown233  
    Date Created    : 2025-04-11  
    Last Modified   : 2025-04-11  
    Version         : 1.0  
    STIG-ID         : WN10-CC-000110  

.DESCRIPTION
    This script sets the registry key to disable HTTP printing, preventing clients from printing via HTTP-based printers.

.TESTED ON
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)  
    PowerShell Ver. :  

.USAGE
    Run this script with administrative privileges.
    Example:
    PS C:\Users\Kbuser\Desktop\WN10-CC-000110.ps1
#>

# Define registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$regName = "DisableHTTPPrinting"
$desiredValue = 1

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the value
Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord

# Verify and confirm
$current = Get-ItemProperty -Path $regPath -Name $regName
if ($current.$regName -eq $desiredValue) {
    Write-Host "✅ HTTP Printing has been successfully disabled (DisableHTTPPrinting = 1)." -ForegroundColor Green
} else {
    Write-Host "❌ Failed to set DisableHTTPPrinting to 1." -ForegroundColor Red
}
