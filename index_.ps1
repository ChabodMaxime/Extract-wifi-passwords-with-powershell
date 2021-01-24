# Script Author: Chabod Maxime
# Version: 0.0.1
# Training script
# Windows 10 French

Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted

function Select-Folder($message, $path = 0)
{

$object = New-Object -comObject Shell.Application
$folder = $object.BrowseForFolder(0, $message, 0, $path)
if ($folder -ne $null){

$folder.self.Path

}
}

$net_profiles = (netsh wlan show profiles) | Out-String
$useless = $net_profiles -replace ".*:"

$taille = $net_profiles.Length-187
$resize = $net_profiles.Substring(187,$taille)

$a = $resize -replace '\s',''
$b = $a -replace 'ProfilTouslesutilisateurs',''
$c = $b -replace 'ÿ',''

$separator = ":",":"
$option = [System.StringSplitOptions]::RemoveEmptyEntries
$array = $c.Split($separator,$option)
$directory = Select-Folder 'Selectionner un répertoire pour extraction des logs'

For($i=0; $i -lt $array.Length; $i++)
{
   
   $temp = $array[$i]
   $command = (netsh wlan export profile $temp key=clear folder="$directory")| Out-String -ErrorAction Stop
   Write-Host $command
}




