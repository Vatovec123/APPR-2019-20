# Obdelava, uvoz in čiščenje podatkov.
ghags 

Tukaj bomo imeli program, ki bo obdelal, uvozil in očistil podatke (druga faza
projekta).

starost <- read_csv2("podatki/pogostost-starost.csv", col_names=c("LETO", "POGOSTOST","Moški1624", "Moški2554", "Moški5574","Ženske1624", "Ženske2554","Ženske5574"),
                     skip = 2, n_max = 13, locale=locale(encoding = "Windows-1250"))

izobrazba <- read_csv2("podatki/pogostost-izobrazba.csv", col_names=c("LETO", "POGOSTOST E-NAKUPOVANJA",
                                                                      "Moški-vsaj OŠ izobrazba", "Moški-srednja izobrazba","Moški-vsaj višješolska izobrazba",
                                                                      "Ženske-vsaj OŠ izobrazba", "Ženske-srednja izobrazba", "Ženske-vsaj višješolska izobrazba"),
                       skip = 2, n_max = 13, locale=locale(encoding = "Windows-1250"))
izdelek <- read_csv2("podatki/vrsta izdelka ali storitve.csv", col_names=c("LETO","E-NAKUPI PO VRSTI IZDELKA ALI STORITVE",
                                                                           "16-24","25-34","35-44","45-54","55-64","65-74"),
                     skip = 2, n_max = 234, na = "-", locale=locale(encoding = "Windows-1250"))