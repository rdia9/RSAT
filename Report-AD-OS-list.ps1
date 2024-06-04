import-module activedirectory
$Computers = @(Get-ADComputer -Properties Name,operatingSystem -Filter {(OperatingSystem -like "*")})
$Computers  | Select operatingSystem, Name | Sort operatingSystem | Export-Csv Report-AD-OS-list.csv
