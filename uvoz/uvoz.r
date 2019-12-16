# 2. faza: Uvoz podatkov
# 2.faza
sl <- locale("sl", decimal_mark=",", grouping_mark=".")

# Funkcija, ki uvozi občine iz Wikipedije
uvozi.obcine <- function() {
  link <- "http://sl.wikipedia.org/wiki/Seznam_ob%C4%8Din_v_Sloveniji"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
    .[[1]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  colnames(tabela) <- c("obcina", "povrsina", "prebivalci", "gostota", "naselja",
                        "ustanovitev", "pokrajina", "regija", "odcepitev")
  tabela$obcina <- gsub("Slovenskih", "Slov.", tabela$obcina)
  tabela$obcina[tabela$obcina == "Kanal ob Soči"] <- "Kanal"
  tabela$obcina[tabela$obcina == "Loški potok"] <- "Loški Potok"
  for (col in c("povrsina", "prebivalci", "gostota", "naselja", "ustanovitev")) {
    if (is.character(tabela[[col]])) {
      tabela[[col]] <- parse_number(tabela[[col]], na="-", locale=sl)
    }
  }
  for (col in c("obcina", "pokrajina", "regija")) {
    tabela[[col]] <- factor(tabela[[col]])
  }
  return(tabela)
}

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
uvozi.druzine <- function(obcine) {
  data <- read_csv2("podatki/druzine.csv", col_names=c("obcina", 1:4),
                    locale=locale(encoding="CP1250"))
  data$obcina <- data$obcina %>% strapplyc("^([^/]*)") %>% unlist() %>%
    strapplyc("([^ ]+)") %>% sapply(paste, collapse=" ") %>% unlist()
  data$obcina[data$obcina == "Sveti Jurij"] <- "Sveti Jurij ob Ščavnici"
  data <- data %>% gather(`1`:`4`, key="velikost.druzine", value="stevilo.druzin")
  data$velikost.druzine <- parse_number(data$velikost.druzine)
  data$obcina <- parse_factor(data$obcina, levels=obcine)
  return(data)
}

# Zapišimo podatke v razpredelnico obcine
obcine <- uvozi.obcine()

# Zapišimo podatke v razpredelnico druzine.
druzine <- uvozi.druzine(levels(obcine$obcina))

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.

starost <- read_csv2("podatki/pogostost-starost.csv", col_names=c("LETO", "POGOSTOST","Moški1624", "Moški2554", "Moški5574","Ženske1624", "Ženske2554","Ženske5574"),
                     skip = 2, n_max = 13, locale=locale(encoding = "Windows-1250"))

izobrazba <- read_csv2("podatki/pogostost-izobrazba.csv", col_names=c("LETO", "POGOSTOST E-NAKUPOVANJA",
                                                                      "Moški-vsaj OŠ izobrazba", "Moški-srednja izobrazba","Moški-vsaj višješolska izobrazba",
                                                                      "Ženske-vsaj OŠ izobrazba", "Ženske-srednja izobrazba", "Ženske-vsaj višješolska izobrazba"),
                       skip = 2, n_max = 13, locale=locale(encoding = "Windows-1250"))
izdelek <- read_csv2("podatki/vrsta izdelka ali storitve.csv", col_names=c("LETO","E-NAKUPI PO VRSTI IZDELKA ALI STORITVE",
                                                                           "16-24","25-34","35-44","45-54","55-64","65-74"),
                     skip = 2, n_max = 234, na = "-", locale=locale(encoding = "Windows-1250"))