# Spécifie un délai d'inactivité avant déconnexion (30 minutes)
$timeOutValue = 1800

# Appliquer à la configuration du serveur
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\' -Name IdleWinStationPoolTimeout -Value $timeOutValue
