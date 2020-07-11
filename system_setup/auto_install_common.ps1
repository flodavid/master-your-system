# Change execution policy to be allowed to installed apps that are not from Store
Set-ExecutionPolicy RemoteSigned | echo $(New-Object -ComObject Wscript.Shell).sendkeys("Y`r`n")

# Set scoop install location
[environment]::setEnvironmentVariable('SCOOP','D:\Apps','User')

echo "Downloading and install Scoop"
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

# Set install location of global apps to "D:\Apps\DevApps"
if ($args.Length -eq 0) {
    $env:SCOOP_GLOBAL='D:\Apps\ScoopApps'
    echo "Usaging default location for global apps: $env:SCOOP_GLOBAL"
} else {
    $env:SCOOP_GLOBAL=$args[0]
    echo "Usaging custom location for global apps: $env:SCOOP_GLOBAL"
}
[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')

# Install apps

echo "Installing git..."
scoop install git --global

# Add the bucket "extras" to scoop..."
scoop bucket add extras

echo "Installing Everything file search..."
scoop install everything --global
echo "Installing Visual Studio Code..."
scoop install vscode --global
echo "Installing Peazip archive management..."
scoop install peazip --global
echo "Installing qbittorent torrent client..."
scoop install qbittorent --global
echo "Installing new microsoft powershell..."
scoop install pwsh --global
echo "Installing AIMP audio player..."
scoop install aimp --global

echo "Installing Ripcord..."
scoop bucket add jamesgecko https://github.com/jamesgecko/scoop-packages.git
scoop install ripcord --global

# Install winget
$start_time = Get-Date
echo "Downloading winget..."
(New-Object System.Net.WebClient).DownloadFile("https://github.com/microsoft/winget-cli/releases/download/v0.1.4331-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle", "$PSScriptRoot\v0.1.4331-preview.appxbundle")
Write-Output "winget: $((Get-Date).Subtract($start_time).Seconds) second(s) to download"
echo "installing..."
Add-AppxPackage -Path v0.1.4331-preview.appxbundle

echo "Installing Voicemeeter Banana (virtual audio devices app)..."
winget install voicemeeter
