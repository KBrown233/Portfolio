<#
.SYNOPSIS
    This script configures the EccCurves registry value to comply with STIG ID WN10-CC-000052 by setting it to "NistP384" and "NistP256".

.DESCRIPTION
    This script checks and sets the EccCurves registry value in the SSL configuration registry path to "NistP384" and "NistP256".
    - This ensures the proper ECC curves are configured for use in SSL/TLS communications as specified by the STIG.

.NOTES
    Author          : Kevin Brown
    LinkedIn        : https://www.linkedin.com/in/kevin-brown-6b6a51247/
    GitHub          : https://github.com/KBrown233
    Date Created    : 2025-04-09
    Last Modified   : 2025-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000052

.TESTED ON
    Date(s) Tested  : 2025-04-09
    Tested By       : Kevin Brown
    Systems Tested  : Windows 10 Virtual Machine (Windows-MDE-KB)
    PowerShell Ver. : 

.USAGE
    To execute the script, run it in an elevated PowerShell window with administrator privileges:
    PS C:\Users\Kbuser\Desktop\WN10-CC-000052.ps1

.EXAMPLE
    PS C:\> .\WN10-CC-000052.ps1
    This will configure the EccCurves registry value to "NistP384" and "NistP256".
#>

# Define the registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"
$regName = "EccCurves"

# Set the desired ECC curve values
$desiredValues = @("NistP384", "NistP256")

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the registry value to the desired values (multi-string registry type)
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValues -Type MultiString
    Write-Output "EccCurves registry value has been successfully configured to NistP384 and NistP256."
} catch {
    Write-Error "Failed to set the registry value. Error: $_"
}

# Confirm the setting has been applied by checking the values
try {
    $setting = Get-ItemProperty -Path $regPath -Name $regName
    # Compare the values (case-insensitive)
    $currentValues = $setting.EccCurves
    if ($currentValues -contains "NistP384" -and $currentValues -contains "NistP256") {
        Write-Output "EccCurves registry value has been successfully configured to NistP384 and NistP256."
    } else {
        Write-Error "The EccCurves registry value does not match the expected values."
    }
} catch {
    Write-Error "Failed to read the registry value. Error: $_"
}
