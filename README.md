# 7Zip-Automated-Install
Automatically installs 7Zip using PowerShell and practices outputting error handing logs. Requires PowerShell 6.2x as this uses -UseMinimalHeader parameter on Start-Transcript to remove some of the bloat from logs.

This automatically installs 7Zip to C:\Program Files\7Zip, along with installing 7Zip it also creates a repo for the installer and a directory for the log file. 


Common Issues 

Error: 7Zip msiexec silent install failed with exit code
Resolution, check that the extension of the setup is a .msi and that the arguements for msiexec are valid and have not been changed 

Error: Failed to download or install the setup MSI file from:
Resolution, This is caused by a faulty URL in the script, grab the new URL for the 64x MSI installer and replace it. 

Error: 7Zip installation might have failed. Required files not found.
This may be a false positive if you edited the script to install to a different directory as install verification checks for the .exe in C:\Program Files along with the exit code from msiexec. However it may have been successful, if you need, edit the path on line 40 to the path you are installing to and it should work as expected.
