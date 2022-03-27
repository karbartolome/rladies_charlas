

options(scipen = 999)
#install.packages("tradestatistics")

library(dplyr)
library(tidyr)
library(tradestatistics)
library(DT)

datatable(ots_tables)

# y: year column.
# r: reporter column
# p: partner column
# c: commodity column

datatable(ots_countries)

# Argentina: arg
# México: mex

commodities <- ots_commodities


# 22 ramas de comercio, cada una incluye múltiples commodities
secciones <- commodities %>% 
  group_by(section_fullname_english, section_code) %>% 
  summarise(n=n()) %>% 
  mutate(
    section_shortname_english = case_when(
      section_code=='01'~'Animal Products',
      section_code=='02'~'Vegetable Products',
      section_code=='03'~'Animal and Vegetable Bi-Products',
      section_code=='04'~'Foodstuffs',
      section_code=='05'~'Mineral Products',
      section_code=='06'~'Chemical Products',
      section_code=='07'~'Plastics and Rubbers',
      section_code=='08'~'Animal Hides',
      section_code=='09'~'Wood Products',
      section_code=='10'~'Paper Goods',
      section_code=='11'~'Textiles',
      section_code=='12'~'Footwear and Headwear',
      section_code=='13'~'Stone And Glass',
      section_code=='14'~'Precious Metals',
      section_code=='15'~'Metals',
      section_code=='16'~'Machines',
      section_code=='17'~'Transportation',
      section_code=='18'~'Instruments',
      section_code=='19'~'Weapons',
      section_code=='20'~'Miscellaneous',
      section_code=='21'~'Arts and Antiques',
      TRUE~'Unspecified'
    )
  ) 

datatable(secciones)

# Si interesa encontrar un tipo de producto: vehìculos
datatable(ots_commodity_code(commodity = "vehicle", group = "vehicles"))


# Comercio bilateral entre Argentina y México
yrpc <- ots_create_tidy_data(
  years = 2017:2020,
  reporters = "arg",
  partners = "mex",
  table = "yrpc",
  use_localhost = FALSE
)

datatable(yrpc)


write.csv(yrpc %>% 
          select(
            reporter = reporter_fullname_english, 
            partner = partner_fullname_english,
            commodity_code, 
            expo=trade_value_usd_exp,
            impo=trade_value_usd_imp)
          , 'data/df_arg_mx.csv', row.names=FALSE, fileEncoding='UTF-8')
write.csv(secciones, 'data/df_secciones.csv', row.names=FALSE, fileEncoding='UTF-8')



# Análisis ----------------------------------------------------------------


### Filtros

# Se quieren las exportaciones de commodities que incluyan la palabra vehicles de Argentina a México en 2020

yrpc %>% 
  filter(
    year==2020 &
    str_detect(tolower(commodity_fullname_english), 'vehicle')     
  ) %>% 
  select(
         reporter = reporter_fullname_english, 
         partner = partner_fullname_english,
         commodity = commodity_fullname_english, 
         expo=trade_value_usd_exp,
         impo=trade_value_usd_imp) %>% 
  mutate(commodity=substr(commodity,1,30)) %>% 
  head(10)

yrpc %>% 
  filter(
    year==2020 &
      str_detect(tolower(commodity_fullname_english), 'vehicle')     
  ) %>% 
  select(
    reporter = reporter_fullname_english, 
    partner = partner_fullname_english,
    commodity = commodity_fullname_english, 
    expo=trade_value_usd_exp,
    impo=trade_value_usd_imp) %>% 
  mutate(commodity=substr(commodity,1,30)) %>% 
  head(10)















datos <- yrpc %>% 
  left_join(secciones %>% select(section_code, section_shortname_english)) %>% 
  group_by(year,
           section_shortname_english) %>% 
  summarise(trade_value_usd_exp=sum(trade_value_usd_exp),
            trade_value_usd_imp=sum(trade_value_usd_imp)) %>% 
  ungroup() %>% 
  mutate(balance = trade_value_usd_exp-trade_value_usd_imp) %>% 
  select(year,section_shortname_english, balance) %>% 
  arrange(desc(abs(balance))) %>% 
  mutate(exportador = ifelse(balance<0,'México','Argentina'), 
         balance = abs(balance))

datos %>% View()


datos %>% 
  group_by(year) %>% 
  slice_max(order_by = abs(balance), n = 2) 






  


argentina <- yrpc %>% 
  group_by(reporter_fullname_english, commodity_fullname_english) %>% 
  summarise(trade_value_usd_exp=sum(trade_value_usd_exp),
            trade_value_usd_imp=sum(trade_value_usd_imp)) %>% 
  mutate(balance = trade_value_usd_exp-trade_value_usd_imp) %>% 
  arrange(desc(abs(balance))) %>% 
  top_n(10)

mexico <-  yrpc %>% 
  group_by(partner_fullname_english, commodity_fullname_english) %>% 
  summarise(trade_value_usd_exp=sum(trade_value_usd_exp),
            trade_value_usd_imp=sum(trade_value_usd_imp)) %>% 
  mutate(balance = trade_value_usd_exp-trade_value_usd_imp) %>% 
  arrange(desc(abs(balance))) %>% 
  top_n(10)



ots_sections_colors


