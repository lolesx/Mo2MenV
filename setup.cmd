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

:: Définir le chemin complet du dossier
set "folderPath=%USERPROFILE%\Desktop\%folderName%"

:: Créer le dossier sur le bureau
mkdir "%folderPath%"

:: Ajouter une exclusion Windows Defender en utilisant PowerShell
powershell.exe -Command Add-MpPreference -ExclusionPath "%folderPath%"

:: Afficher un message de confirmation
echo Le dossier "%folderName%" a été créé sur le bureau et ajouté aux exclusions de Windows Defender.

:: Mettre fin au script
exit /b 0
