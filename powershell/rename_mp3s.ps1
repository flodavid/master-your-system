# Ceci est un script Powershell Permettant de renommer des fichiers mp3 avec une meilleur syntaxe :
## suppression des _ est _-_, remplacés par des espaces ou des -
# Exécution : déplacer le script dans le dossier désiré, puis double clic ou .\rename_mp3s.ps1 dans le terminal
echo "Rename all mp3 files : '_-' becomes '-' and '_' becomes ' '"
Get-ChildItem *.mp3 | Rename-Item -NewName { $_.name -Replace '_-','-'}
Get-ChildItem *.mp3 | Rename-Item -NewName { $_.name -Replace '_',' '}