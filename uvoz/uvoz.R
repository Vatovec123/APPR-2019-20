uvoz

starost <- read_csv2("podatki/pogostost-starost.csv", col_names=c("LETO","POGOSTOST E-NAKUPOVANJA",
                                                                "Moški 16-24","Moški 25-54","Moški 55-74",
                                                                "Ženske 16-24", "Ženske 25-54","Ženske 55-74"),
                     skip = 2, n_max = 13, locale=locale(encoding = "Windows-1250"))

izobrazba <- read_csv2("podatki/pogostost-izobrazba.csv",
                       col_names=c("LETO","POGOSTOST E-NAKUPOVANJA",
                                   "Moški-vsaj OŠ izobrazba","Moški-vsaj srednja izobrazba","Moški-vsaj višješolska izobrazba",
                                   "Ženske-vsaj OŠ izobrazba","Ženske-vsaj srednja izobrazba","Ženske-vsaj višješolska izobrazba"),
                       skip = 2, n_max = 13, locale=locale(encoding = "Windows-1250"))

izdelek <- read__csv2("podatki/vrsta izdelka ali storitve",
                      col_names=c("LETO","E-NAKUPOVANJE PO VRSTI IZDELKA ALI STORITVE",
                                  "16-24","25-34","35-44","55-64","65-74"),
                      skip = 2, n_max = 234, na = "-", locale=locale(encoding = "Windows-1250"))