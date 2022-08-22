import-module grouppolicy 
import-module activedirectory 

$PDC = Get-ADForest | Select-Object -ExpandProperty rootdomain | Get-ADDomain | Select-Object -Property pdcemulator
$DC = $PDC.pdcemulator

function IsNotLinked($xmldata){ 
    If ($xmldata.GPO.LinksTo -eq $null) { 
        Return $true 
    } 
     
    Return $false 
} 
 
$unlinkedGPOs = @() 
 
Get-GPO -All | ForEach { $gpo = $_ ; $_ | Get-GPOReport -ReportType xml | ForEach { If(IsNotLinked([xml]$_)){$unlinkedGPOs += $gpo} }} 
 
If ($unlinkedGPOs.Count -eq 0) { 
    "No Unlinked GPO's Found" 
} 
Else{ 
    $unlinkedGPOs | Select DisplayName,ID | ft 
}

Foreach($GPO in $unlinkedGPOs){

  Write-Host "Traitement de la GPO : $($GPO.DisplayName) ($($GPO.Id))"

  $Error.Clear()

  Backup-GPO -Guid $GPO.Id -Path "C:\GPO_Backup" -Server $DC -ErrorVariable BackupGPOState

  if($error.Count -ieq 0){

    Write-Host "Suppression de la GPO : $($GPO.DisplayName) ($($GPO.Id))" -ForegroundColor Green
    Remove-GPO -Guid $GPO.Id -Server $DC

  }else{

    Write-Host "Echec lors de la suppression de la GPO : $($GPO.DisplayName) ($($GPO.Id))" -ForegroundColor Red

  }
}
