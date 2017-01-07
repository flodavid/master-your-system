# Find the "My Documents" Folder
$mydocuments = [Environment]::GetFolderPath("MyDocuments")
$powershell_folder = $mydocuments + '\WindowsPowerShell'

if (!(Test-Path $powershell_folder)) {
    echo "Create folder : $powershell_folder"
    New-Item $powershell_folder -type directory
}

$powershell_profile = $powershell_folder + '\Microsoft.PowerShell_profile.ps1'
echo "Try to create file : $powershell_profile"


if (Test-Path $powershell_profile) {
    echo "Powershell profile file already exists. Aliases added nonetheless"
}

## Create aliases
# Show command aliases
$aliases = @(
'New-Alias show Get-ChildItem'
'New-Alias make mingw32-make'
'New-Alias gedit write.exe')

### Note : you can have a more gedit style  ###

# Append to profile file:
# Create the powershell profile file if it doesn't exists yet. Then, write into it to add aliases
# This way, aliases are saved between Windows PowerShell sessions
'' >> $powershell_profile
for($i=0 ; $i -lt $aliases.Count ; $i++){
    $aliases[$i] >> $powershell_profile
}

# Show all non-PowerShell aliases
get-alias | where {$_.ReferencedCommand -match "exe"} | format-table Name,Definition -autosize
