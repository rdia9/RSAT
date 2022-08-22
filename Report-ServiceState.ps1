$servicename = "spooler"

$serveurs = (Get-ADComputer -Filter {(Enabled -eq $True)} -SearchBase "OU=Serveurs, DC=btp-consultants, DC=fr").name

$result = foreach ($item in $serveurs) {
    invoke-command -ComputerName $item -ScriptBlock {Get-Service $using:servicename | Select-Object PSComputerName, name, status, StartType}
}

$fichier = "Report-Service_" + $servicename + "_on_servers.csv"
$result | Export-Csv -NoTypeInformation -Delimiter ";" $fichier