# pour avoir un unilog lisible
# Affichage en West European Latin
chcp 1252 | Out-Null


# variable à ajuster
$source="\\SRVSQYDFS03\D$\structure"
$dest="\\SRVOVHDFS03\D$\structure"
$excludeDir=@("DfsrPrivate") #separate exclude dirs by comma in array "quote" for earch ; example @("dfsrprivate,"test")

mkdir -force c:\temp
cd c:\temp
$date = [string](get-date -Format "yyyyMMddHHmm")
$log= "c:\temp\robocopy_" + $date + "_" + ($source).Replace("\","_") + "_to_" + ($dest).Replace("\","_") + ".log"
$errorslog ="c:\temp\robocopy_" + $date + "_" + ($source).Replace("\","_") + "_to_" + ($dest).Replace("\","_") + "_errors" + ".log"
New-Item $errorslog
set-content $errorslog "Initilisation manuelle par Powershell du fichier `n Si vide, il n'y a aucune erreur"
$OwnerFilesInError= "c:\temp\robocopy_" + $date + "_" + ($source).Replace("\","_") + "_to_" + ($dest).Replace("\","_") + "_errors_FilesWithOwner" + ".csv"

# To run robocopy with logging which logs errors
robocopy.exe $source $dest /b /NP /mir /sec /secfix /r:2 /w:2 /tee /MT:32 /xo /xd @excludeDir /unilog+:$log

# get errors from log and use set-content so it only writes if there are errors.
get-content $log -Encoding Default | select-string "0x0000" | set-content $errorslog -Encoding utf8

# avoir seulement le chemin des fichiers en erreur
# OLD supprimer les 55 premiers caractères
#$cheminenerreur = get-content $errorslog  | ForEach-Object {($_).remove(0,54)}
# FIXME essayer d'avoir le même résultat mais avec la methode débute par \\
#$cheminenerreur = ls $errorslog | Select-String '\\' -Encoding default
#alternate method | split et avoir la seconde partie (0,1)
$cheminenerreur = cat $errorslog -Encoding utf8 | % {($_ -split '\\\\')[1]} | % {"\\" + $_}

# voir les propriétaires de ces fichiers
$arr=@()
$cheminenerreur | % {
$obj = New-Object PSObject
    $obj | Add-Member NoteProperty FilePath $_
    $obj | Add-Member NoteProperty owner ((get-acl $_).owner)
    $arr += $obj
    }
$arr | export-csv -NoTypeInformation -Delimiter ";" $OwnerFilesInError -Encoding utf8
