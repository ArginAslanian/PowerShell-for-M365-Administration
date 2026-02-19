# How to get the hardware ID of a device and export it as a CSV file using PowerShell
# To then import to Intune for autopilot

# If on the OOBE screen
SHIFT + F10 to get command prompt

# Open powershell by typing "powershell" and pressing Enter

# Set execution policy 
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Get Hardware ID of a specific device for Autopilot with Windows Autopilot Info
Install-Script -Name Get-WindowsAutopilotInfo -Force

Get-WindowsAutopilotInfo -OutputFile "C:\AutopilotHWID.csv"

# Now we will check what drive letter is our USB drive to move the file there for import to Intune

# List the volumes in system to get drive name
Get-Volume

# Move the file to the usb drive
Move-Item -Path "C:\AutopilotHWID.csv" -Destination "D:\"

# Verify file is there

# cd D:\
# dir 

# On Intune
Devices -> Windows -> Windows Enrollment -> Devices -> Import -> Upload -> CSV file
