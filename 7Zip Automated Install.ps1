# URL 
$URL="https://www.7-zip.org/a/7z2407-x64.msi"
# Install Repo 
$Path="C:\Installs\7Zip Repo"
# Log Output Directory
$LogPath="C:\Scripts\Logs\7Zip"
$Package="7Zip_setup.msi"

# Creates Log Directory
if (-not (Test-Path $LogPath)) {
 New-Item -ItemType Directory -Path $LogPath | Out-Null
}

# Start transcript to log all output to a file
Start-Transcript -Path "$LogPath\Install Log_$(Get-Date -Format 'MM_dd_yy').txt" -Append -UseMinimalHeader 


try {
# Starts the file download for 7Zip Installer
Invoke-WebRequest -Uri $URL -OutFile $Path\7Zip_setup.msi


if (Test-Path $Path\7Zip_setup.msi) {
# Logs successful download of 7Zip_setup.msi
 Write-Output $(Get-Date).ToUniversalTime() "Success:$Package was successfully downloaded to: $Path."
    }

else {
# Logs failed 7Zipsetup.msi download
 Write-Output "Failed to download or install the setup MSI file from: $URL" 

}
# Starts a silent install for msiexec 
$msiexecArgs = "/i `"$Path\7Zip_setup.msi`" /qb"
$process = Start-Process msiexec.exe -ArgumentList $msiexecArgs -PassThru -Wait -NoNewWindow

# Check if installation succeeded by checking msiexec's exitcode 
if ($process.ExitCode -eq 0) {
    # Example check: Verify if 7-Zip executable exists in Program Files
    if (Test-Path "C:\Program Files\7-Zip\7z.exe") {
        Write-Output $(Get-Date).ToUniversalTime() "Success: 7Zip installation completed successfully."
    } else {
        Write-Output $(Get-Date).ToUniversalTime() "Error: 7Zip installation might have failed. Required files not found."
    }
} else {
    #If this is produced it is an issue with msiexec and not the installer 
    Write-Output $(Get-Date).ToUniversalTime() "Error: 7Zip msiexec silent install failed with exit code $($process.ExitCode). If you are seeing this, try a manual install!"
}

} catch {
# Log download or installation failure
Write-Output $(Get-Date).ToUniversalTime() "Error: Failed to download or install 7Zip: $_"

} finally {
# Stops transcript for Log File 
Stop-Transcript
}


