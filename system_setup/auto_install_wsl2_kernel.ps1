# Download and install wsl2 kernel update
$start_time = Get-Date
echo "Downloading Linux kernel update..."
(New-Object System.Net.WebClient).DownloadFile("https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi", "$PSScriptRoot\wsl_update_x64.msi")
Write-Output "$((Get-Date).Subtract($start_time).Seconds) second(s) to download"
echo "installing..."
msiexec.exe /i "$PSScriptRoot\wsl_update_x64.msi"

# Set WSL 2 as default version
wsl --set-default-version 2

echo "You may have to restart your computer for changes to take effect"