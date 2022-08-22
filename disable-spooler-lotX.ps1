$servicename = "spooler"
$serveurs = Get-Content "serveurs_spooler_lot_p3.csv"

(Invoke-Command -ComputerName $serveurs -ScriptBlock {Get-Service $using:servicename}) | Format-Table PSComputerName, name, status, StartType
Invoke-Command -ComputerName $serveurs -ScriptBlock {stop-Service $using:servicename} 
Invoke-Command -ComputerName $serveurs -ScriptBlock {set-Service $using:servicename -StartupType disabled} 
(Invoke-Command -ComputerName $serveurs -ScriptBlock {Get-Service $using:servicename}) | Format-Table PSComputerName, name, status, StartType