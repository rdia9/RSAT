(quser) -notlike ">$env:USERNAME *" | Select-Object -Skip 1 | ForEach-Object { logoff ($_ -split ' +')[-5] }
