#q2.1
# Je me connecte sur le serveur depuis le client via le burreau d'accès à distance et je fais un copié collé entre les deux mahcines
#q2.2
# A l'execution le script lance une fenêtre powershell et se ferme, il ne se passe rien car le chemin pour aller chercher le fichier CSV n'est pas bon
#il faut donc le remplacer comme ceci :
# Start-Process -FilePath "powershell.exe" -ArgumentList "C:\Scripts\AddLocalUsers.ps1" -Verb RunAs -WindowStyle Maximized
#q2.3 
# Cela sert à exécuté le script en Adminisatrateur 
#Q2.4
# cela permet d'ouvrir la fenêtre en plein écran
#Q2.5
#L'utilisateur n'es as pris en compte car à la ligne 27, on demande lors de l'import du CSV de ne pas prendre en comptre les deux premières lignes
# il faut donc corriger cela comme suit :
# $Users = Import-Csv -Path $CsvFile -Delimiter ";" -Header "prenom","nom","societe","fonction","service","description","mail","mobile","scriptPath","telephoneNumber" -Encoding UTF8  | Select-Object -Skip 1
#Q2.6
# dans les lignes suivante (29 à 46) il manque l'ajout de la description dans les paramètre lors de la création du compte
#foreach ($User in $Users)
#{
#    $Prenom = ManageAccentsAndCapitalLetters -String $User.prenom
#    $Nom = ManageAccentsAndCapitalLetters -String $User.Nom
#    $Name = "$Prenom.$Nom"
#    If (-not(Get-LocalUser -Name "$Prenom.$Nom" -ErrorAction SilentlyContinue))
#    {
#        $Pass = Random-Password
#        $Password = (ConvertTo-secureString $Pass -AsPlainText -Force)
#        $Description = "$($user.description) - $($User.fonction)"
#        $UserInfo = @{
#            Name                 = "$Prenom.$Nom"
#            FullName             = "$Prenom.$Nom"
#            Password             = $Password
#            AccountNeverExpires  = $true
#            PasswordNeverExpires = $false
#       }
# Il faut donc rajouter l'ajout du paramètre dans la création comme ceci :
#{#foreach ($User in $Users)
#{
#    $Prenom = ManageAccentsAndCapitalLetters -String $User.prenom
#    $Nom = ManageAccentsAndCapitalLetters -String $User.Nom
#    $Name = "$Prenom.$Nom"
#    If (-not(Get-LocalUser -Name "$Prenom.$Nom" -ErrorAction SilentlyContinue))
#    {
#        $Pass = Random-Password
#        $Password = (ConvertTo-secureString $Pass -AsPlainText -Force)
#        $Description = "$($user.description) - $($User.fonction)"
#        $UserInfo = @{
#            Name                 = "$Prenom.$Nom"
#            FullName             = "$Prenom.$Nom"
#            Password             = $Password
#            Description          = "$description"
#            AccountNeverExpires  = $true
#            PasswordNeverExpires = $false
#       }
#Q2.9
# on peut recopier le code de la fonction et l'appeler dans le le scrit AddLocalUsers.ps1
# ou alors on peut directement appeler la fonction depuis le script avec les commandes suivante :
# Import-Module -Name "C:\Scripts\Functions.psm1" -Function Log (importer la fonction)
# Dans les deux cas on utilise la fonction comme cela 
# Log -FilePath "chemin d'enregistrement du fichier a créer" -Content "message a afficher"
#2.10
#la fonction permet de supprimer tout les accents qui pouurait composer les prénoms et noms des utilisateurs
# elle permet aussi de passer tout les caractères en miniscule.
#cela permet pour par exemple Anaïs Bourgeois, d'afficher son nom comme cela : anais.bourgeois

##### code script Main.ps1
Start-Process -FilePath "powershell.exe" -ArgumentList "C:\Scripts\AddLocalUsers.ps1" -Verb RunAs -WindowStyle Maximized

#### code script AddLocalUsers.ps1
Write-Host "--- Début du script ---"

function Log
{
    param([string]$FilePath,[string]$Content)

    # Vérifie si le fichier existe, sinon le crée
    If (-not (Test-Path -Path $FilePath))
    {
        New-Item -ItemType File -Path $FilePath | Out-Null
    }

    # Construit la ligne de journal
    $Date = Get-Date -Format "dd/MM/yyyy-HH:mm:ss"
    $User = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    $logLine = "$Date;$User;$Content"

    # Ajoute la ligne de journal au fichier
    Add-Content -Path $FilePath -Value $logLine
}
Function Random-Password ($length = 12)
{
    $punc = 46..46
    $digits = 48..57
    $letters = 65..90 + 97..122

    $password = get-random -count $length -input ($punc + $digits + $letters) |`
        ForEach -begin { $aa = $null } -process {$aa += [char]$_} -end {$aa}
    Return $password.ToString()
}

Function ManageAccentsAndCapitalLetters
{
    param ([String]$String)
    
    $StringWithoutAccent = $String -replace '[éèêë]', 'e' -replace '[àâä]', 'a' -replace '[îï]', 'i' -replace '[ôö]', 'o' -replace '[ùûü]', 'u'
    $StringWithoutAccentAndCapitalLetters = $StringWithoutAccent.ToLower()
    $StringWithoutAccentAndCapitalLetters
}

$Path = "C:\Scripts"
$CsvFile = "$Path\Users.csv"
$LogFile = "$Path\Log.log"

$Users = Import-Csv -Path $CsvFile -Delimiter ";" -Header "prenom","nom","societe","fonction","service","description" -Encoding UTF8  | Select-Object -Skip 1

foreach ($User in $Users)
{
    $Prenom = ManageAccentsAndCapitalLetters -String $User.prenom
    $Nom = ManageAccentsAndCapitalLetters -String $User.Nom
    $Name = "$Prenom.$Nom"
    If (-not(Get-LocalUser -Name "$Name" -ErrorAction SilentlyContinue))
    {
        $Pass = Random-Password
        $Password = (ConvertTo-secureString $Pass -AsPlainText -Force)
        $Description = "$($user.description) - $($User.fonction)"
        $UserInfo = @{
            Name                 = "$Name"
            FullName             = "$Name"
            Password             = $Password
            Description          = "$description"
            AccountNeverExpires  = $true
            PasswordNeverExpires = $tr
        }

        New-LocalUser @UserInfo
        Add-LocalGroupMember -Group "Utilisateurs" -Member "$Name"
        Write-Host "Le compte $Name à été créé avec le mot de passe $Pass" -ForegroundColor Green
        $Resulstat= "Le compte $Name à été créé avec le mot de passe $Pass"
    }
    Else
    {
       Write-Host "Le compte $Name existe déjà" -ForegroundColor Red
       $Resulstat= "Le compte $Name existe déjà"
    }
log -FilePath "C:\Scripts\journal.log" -Content $Resulstat
}


Write-Host "--- Fin du script ---"
Read-Host "Appuyez sur Entrée pour continuer ... " 

