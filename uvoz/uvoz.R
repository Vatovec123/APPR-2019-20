uvoz
sl <-locale("sl", decimal_mark = ";", grouping_mark = ".")


starost <- read_csv2("podatki/pogostost-starost.csv", col_names=c("LETO","POGOSTOST E-NAKUPOVANJA",
                                                                "Moški 16-24","Moški 25-54","Moški 55-74",
                                                                "Ženske 16-24", "Ženske 25-54","Ženske 55-74"),
                     skip = 3, n_max = 13, locale=locale(encoding = "Windows-1250"))

izobrazba <- read_csv2("podatki/pogostost-izobrazba.csv",
                       col_names=c("LETO","POGOSTOST E-NAKUPOVANJA",
                                   "Moški-vsaj OŠ izobrazba","Moški-vsaj srednja izobrazba","Moški-vsaj višješolska izobrazba",
                                   "Ženske-vsaj OŠ izobrazba","Ženske-vsaj srednja izobrazba","Ženske-vsaj višješolska izobrazba"),
                       skip = 3, n_max = 13, locale=locale(encoding = "Windows-1250"))

izdelek <- read_csv2("podatki/vrsta izdelka ali storitve.csv",
                      skip = 2, n_max = 234, na = "-", locale=locale(encoding = "Windows-1250")) %>%
  rename(e.nakupi=`E-NAKUPI  PO VRSTI IZDELKA ALI STORITVE`)

vrednost <- read_csv2("podatki/število in ocenjena vrednost-stopnja urbanizacije.csv",
                      col_names=c("LETO","ŠTEVILO IN VREDNOST SPLETNIH NAKUPOV","Gosto poseljena območja","Vmesna območja","Redko poseljena območja","Vzhodna Slovenija","Zahodna Slovenija"),
                      skip = 3, n_max = 48, locale=locale(encoding = "Windows-1250"))

stolpci <- c("leto","iskanje",
             "Moški-največ OŠ izobrazba","Moški-srednja izobrazba","Moški-vsaj višješolska izobrazba",
             "Ženske-največ OŠ izobrazba","Ženske-srednja izobrazba","Ženske-vsaj višješolska izobrazba") %>%
  iconv(to="UTF-8")
informacija <- read_csv2("podatki/pogostost iskanja informacij pred nakupom.csv",
                         col_names=stolpci,
                         skip = 3, n_max = 13, locale=locale(encoding = "Windows-1250")) %>%
  gather(key="spol.izobrazba", value="stevilo", -leto, -iskanje) %>%
  separate(spol.izobrazba, c("spol", "izobrazba"), "-")
