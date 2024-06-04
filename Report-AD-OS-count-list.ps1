import-module activedirectory
$Computers = @(Get-ADComputer -Properties Name,operatingSystem -Filter {(OperatingSystem -like "*")})
$Computers | Group-Object operatingSystem | Select Count, Name | Sort Name
