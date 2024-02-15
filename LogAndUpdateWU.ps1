$datefile = (get-date -UFormat %Y%m%d%H%M)

$dossier = "C:\WUreports\"
$OutputFile  = $dossier + $datefile + "_WUreports.log"


Install-Module -Name PSWindowsUpdate -Force
Import-Module -Name PSWindowsUpdate

Write-Output (get-date) | Out-File $OutputFile
Write-Output "Script by Raphael Diacamille https://github.com/rdia9" | Out-File -Append $OutputFile
Write-Output "Project : https://github.com/Novalian-Fr/ansible-role-windows-servers" | Out-File -Append $OutputFile


Write-Output "=================================" | Out-File $OutputFile
Write-Output "Windows Update settings :" | Out-File -Append $OutputFile
Write-Output "=================================" | Out-File -Append $OutputFile
Get-WUSettings | Out-File -Append $OutputFile

Write-Output "=================================" | Out-File -Append $OutputFile
Write-Output "Windows Update last results :" | Out-File -Append $OutputFile
Write-Output "=================================" | Out-File -Append $OutputFile
Get-WULastResults | Out-File -Append $OutputFile

Write-Output "================================" | Out-File -Append $OutputFile
Write-Output "Windows updates available list :" | Out-File -Append $OutputFile
Write-Output "================================" | Out-File -Append $OutputFile
Get-WindowsUpdate | Out-File -Append $OutputFile

Write-Output "================================" | Out-File -Append $OutputFile
Write-Output "Install Windows updates :" | Out-File -Append $OutputFile
Write-Output "================================" | Out-File -Append $OutputFile
Install-WindowsUpdate -AcceptAll -IgnoreReboot | Out-File -Append $OutputFile

Write-Output "=======================================" | Out-File -Append $OutputFile
Write-Output "Checking Windows Update reboot status :" | Out-File -Append $OutputFile
Write-Output "=======================================" | Out-File -Append $OutputFile
Write-Output "Is a reboot required by Windows Update ?" | Out-File -Append $OutputFile
Get-WURebootStatus -Silent | Out-File -Append $OutputFile

Write-Output "=================================" | Out-File -Append $OutputFile
Write-Output "Windows Update last new results :" | Out-File -Append $OutputFile
Write-Output "=================================" | Out-File -Append $OutputFile
Get-WULastResults | Out-File -Append $OutputFile


