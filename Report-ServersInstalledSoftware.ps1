$serveurs = (Get-ADComputer -Filter {(Enabled -eq $True)} -SearchBase "OU=Serveurs, DC=btp-consultants, DC=fr").name

$datefichier= get-date -UFormat %Y%m%d%H%M%S
$fichier = $datefichier + "Report-ServersSoftware" + ".csv"
Get-CimInstance -ComputerName (Get-Content $serveurs) -ClassName win32_product -ErrorAction SilentlyContinue| Select-Object PSComputerName, Name, PackageName, InstallDate | Export-Csv $fichier -NoTypeInformation -Delimiter ","