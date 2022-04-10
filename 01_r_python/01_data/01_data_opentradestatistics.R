

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


readr::write_csv(yrpc %>% 
          select(
            year,
            reporter = reporter_fullname_english, 
            partner = partner_fullname_english,
            commodity_code, 
            section_code,
            trade_value_usd_exp,
            trade_value_usd_imp)
          , 'data/df_arg_mx.csv')
write.csv(secciones, 'data/df_secciones.csv', row.names=FALSE, fileEncoding = "UTF-8")
write.csv(commodities, 'data/df_commodities.csv', row.names=FALSE, fileEncoding = "UTF-8")


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












pers_con = data.frame (
  year = c(1960:2005),
  epc = c(1597.4, 1630.3, 1711.1, 1781.6, 1888.4,
             2007.7, 2121.8, 2185.0, 2310.5, 2396.4,
              2451.9, 2545.5, 2701.3, 2833.8, 2812.3,
             2876.9, 3035.5, 3164.1, 3303.1, 3383.4,
              3374.1, 3422.2, 3470.3, 3668.6, 3863.3,
             4064.0, 4228.9, 4369.8, 4546.9, 4675.0,
              4770.3, 4778.4, 4934.8, 5099.8, 5290.7,
             5433.5, 5619.4, 5831.8, 6125.8, 6438.6,
              6739.4, 6910.4, 7099.3, 7259.3, 7577.1,
             7841.2),
  gpd = c(2501.8, 2560.0, 2715.2, 2834.0, 2998.6,
              3191.1, 3399.1, 3484.6, 3652.7, 3765.4,
               3771.9, 3898.6, 4105.0, 4341.5, 4319.6,
              4311.2, 4540.9, 4750.5, 5015.0, 5173.4,
               5161.7, 5291.7, 5189.3, 5423.8, 5813.6,
              6053.7, 6263.6, 6475.1, 6742.7, 6981.4,
               7112.5, 7100.5, 7336.6, 7532.7, 7835.5,
              8031.7, 8328.9, 8703.5, 9066.9, 9470.3,
               9817.0, 9890.7, 10048.8, 10301.0, 10703.5,
              11048.6))
