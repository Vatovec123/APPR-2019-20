uvoz

starost <- read_csv2("podatki/pogostost-starost.csv", col_names=c("LETO","POGOSTOST E-NAKUPOVANJA",
                                                                "Moški 16-24","Moški 25-54","Moški 55-74",
                                                                "Ženske 16-24", "Ženske 25-54","Ženske 55-74"),
                     skip = 2, n_max = 13, locale=locale(encoding = "Windows-1250"))
