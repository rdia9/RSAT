
stop-service wuauserv -force
Set-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU\ -Name UseWUServer -Value 0
start-service wuauserv
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All

# retablir l'état initial du service WSUS
stop-service wuauserv
Set-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU\ -Name UseWUServer -Value 1
start-service wuauserv
