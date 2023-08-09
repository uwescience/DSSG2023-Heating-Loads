# Code to generate tilegram structure
## Grids for each borough were generated here: https://hafen.github.io/grid-designer/

##---------Load packages-------
if (!require(pacman)) {install.packages("pacman"); require(pacman)}
p_load("ggplot2",
       "geofacet",
       "rnaturalearth",
       "raster",
       "useful",
       "plotly",
       "sf",
       "shiny",
       "shinydashboard",
       "shinyWidgets")

##---------Generate tilegrams for each borough-------

### PANHANDLE 

ketch_grid <- data.frame(
  code = c("ketch1", "ketch2", "ketch6", "ketch5", "ketch4", "ketch3", "ketch19", "ketch9", "ketch8", "ketch7", "ketch10", "ketch14", "ketch13", "ketch12", "ketch11", "ketch15", "ketch16", "ketch18", "ketch17"),
  row = c(1, 1, 2, 2, 2, 2, 6, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 6, 6),
  col = c(2, 3, 4, 3, 2, 1, 5, 4, 3, 2, 5, 5, 4, 3, 2, 4, 5, 4, 3),
  stringsAsFactors = FALSE
)
ketch_grid$name <- "Ketchikan Gateway Borough"
geofacet::grid_preview(ketch_grid)

prince_grid <- data.frame(
  code = c("prince1", "prince3", "prince2", "prince6", "prince5", "prince4", "prince8", "prince7"),
  row = c(1, 2, 2, 3, 3, 3, 4, 4),
  col = c(2, 2, 1, 4, 3, 2, 3, 2),
  stringsAsFactors = FALSE
)
prince_grid$name <- "Prince of Wales-Hyder Census Area"
geofacet::grid_preview(prince_grid)

sitka_grid <- data.frame(
  code = c("sitka1", "sitka2", "sitka3", "sitka4", "sitka5", "sitka6", "sitka7", "sitka8", "sitka9", "sitka11", "sitka12", "sitka10"),
  row = c(1, 1, 2, 2, 3, 3, 3, 4, 4, 5, 5, 4),
  col = c(1, 2, 1, 2, 1, 2, 3, 1, 2, 2, 3, 3),
  stringsAsFactors = FALSE
)
sitka_grid$name <- "Sitka City and Borough"
geofacet::grid_preview(sitka_grid)

wrangell_grid <- data.frame(
  code = c("wrang1", "wrang2", "wrang3"),
  row = c(1, 1, 2),
  col = c(1, 2, 2),
  stringsAsFactors = FALSE
)
wrangell_grid$name <- "Wrangell City and Borough"
geofacet::grid_preview(wrangell_grid)

peter_grid <- data.frame(
  code = c("peter1", "peter2", "peter4", "peter3"),
  row = c(1, 1, 2, 2),
  col = c(1, 2, 2, 1),
  stringsAsFactors = FALSE
)
peter_grid$name <- "Petersburg Borough"
geofacet::grid_preview(peter_grid)

juneau_grid <- data.frame(
  code = c("juneau1", "juneau2", "juneau3", "juneau4", "juneau5", "juneau6", "juneau7", "juneau8", "juneau9", "juneau10", "juneau11", "juneau12", "juneau19", "juneau13", "juneau14", "juneau15", "juneau16", "juneau17", "juneau18", "juneau20", "juneau21", "juneau22", "juneau23", "juneau24", "juneau25", "juneau26", "juneau27", "juneau30", "juneau29", "juneau28", "juneau31", "juneau32", "juneau33", "juneau34", "juneau35", "juneau39", "juneau38", "juneau37", "juneau36", "juneau42", "juneau40", "juneau41", "juneau43", "juneau44"),
  row = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8),
  col = c(1, 2, 3, 4, 5, 2, 3, 4, 5, 6, 7, 8, 9, 3, 4, 5, 6, 7, 8, 3, 4, 5, 6, 7, 8, 9, 10, 5, 4, 3, 6, 7, 8, 9, 10, 8, 7, 6, 5, 7, 5, 6, 8, 6),
  stringsAsFactors = FALSE
)
juneau_grid$name <- "Juneau City and Borough"
geofacet::grid_preview(juneau_grid)

skagway_grid <- data.frame(
  code = c("skag1", "skag2"),
  row = c(1, 2),
  col = c(1, 1),
  stringsAsFactors = FALSE
)
skagway_grid$name <- "Skagway Municipality"
geofacet::grid_preview(skagway_grid)

haines_grid <- data.frame(
  code = c("haines1", "haines2", "haines3"),
  row = c(1, 1, 2),
  col = c(1, 2, 2),
  stringsAsFactors = FALSE
)
haines_grid$name <- "Haines Borough"
geofacet::grid_preview(haines_grid)

hoon_grid <- data.frame(
  code = c("hoon1", "hoon3", "hoon2"),
  row = c(1, 2, 2),
  col = c(1, 2, 1),
  stringsAsFactors = FALSE
)
hoon_grid$name <- "Hoonah-Angoon Census Area"
geofacet::grid_preview(hoon_grid)

yakutat_grid <- data.frame(
  code = c("yakutat1"),
  row = c(1),
  col = c(1),
  stringsAsFactors = FALSE
)
yakutat_grid$name <- "Yakutat City and Borough"
geofacet::grid_preview(yakutat_grid)

valdez_grid <- data.frame(
  code = c("valdez1", "valdez5", "valdez4", "valdez3", "valdez2", "valdez10", "valdez9", "valdez8", "valdez7", "valdez6", "valdez11", "valdez13", "valdez12"),
  row = c(1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4),
  col = c(3, 5, 4, 3, 2, 5, 4, 3, 2, 1, 1, 3, 2),
  stringsAsFactors = FALSE
)
valdez_grid$name <- "Valdez-Cordova Census Area"
geofacet::grid_preview(valdez_grid)
# TO ADDRESS: we have no matching borough in our 2020 census data

# Adjust location of each grid, with Ketchikan as reference
wrangell_grid$col <-wrangell_grid$col + 3
prince_grid$row <-prince_grid$row + 2
prince_grid$col <-prince_grid$col - 1
sitka_grid$row <- sitka_grid$row - 2
sitka_grid$col <- sitka_grid$col - 3
peter_grid$col <- peter_grid$col + 3
peter_grid$row <- peter_grid$row - 2
juneau_grid$row <- juneau_grid$row - 7
juneau_grid$col <- juneau_grid$col - 5
skagway_grid$row <- skagway_grid$row - 8
skagway_grid$col <- skagway_grid$col + 1 
haines_grid$row <- haines_grid$row - 8
haines_grid$col <- haines_grid$col - 1
hoon_grid$row <- hoon_grid$row - 7
hoon_grid$col <- hoon_grid$col - 6
yakutat_grid$row <- yakutat_grid$row - 8
yakutat_grid$col <- yakutat_grid$col - 7
valdez_grid$row <- valdez_grid$row - 11
valdez_grid$col <- valdez_grid$col - 12

# Stack all grids on top of each other
panhandle_grids <- rbind(ketch_grid, prince_grid, sitka_grid, wrangell_grid, peter_grid,
                         juneau_grid, skagway_grid, haines_grid, hoon_grid, yakutat_grid,
                         valdez_grid) 

# Make all coordinates positive
min(panhandle_grids$row)
min(panhandle_grids$col)
panhandle_grids$row <- panhandle_grids$row + 11
panhandle_grids$col <- panhandle_grids$col + 12
# View resulting grid
geofacet::grid_preview(panhandle_grids)

# Create fake temp data
df <- panhandle_grids
df$value = c(runif(n=dim(df)[1], min=1, max=20))
meandf = df %>% group_by(name) %>% summarise(mean_value=mean(value))
temp_df_mean <- merge(df, meandf, by = "name")
temp_df_mean$name <- as.factor(temp_df_mean$name)

# Plot
ggplot(temp_df_mean, aes(x= '', y = '', fill = name, group = name)) +
  geom_tile(width = 10, height = 10, show.legend = TRUE) +
  coord_fixed(ratio = 1) +
  #scale_fill_gradient(low = "lightblue", high = "darkblue", guide = "legend") +
  facet_geo(~ code, grid = panhandle_grids, label = "code") +
  theme_bw() +
  labs(x = '', y = '', fill = "Outcome Measure") +
  theme(strip.background = element_blank(), 
        panel.border = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        strip.text.x = element_blank(),
        panel.spacing = unit(.05, "lines"))


### Non-panhandle

nwa_grid <- data.frame(
  code = c("NWA1", "NWA2", "NWA3", "NWA4", "NWA5", "NWA6", "NWA7", "NWA8", "NWA9", "NWA10", "NWA11"),
  row = c(1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3),
  col = c(2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4),
  stringsAsFactors = FALSE
)
nwa_grid$name <- "Northwest Arctic Borough"
geofacet::grid_preview(nwa_grid)

northslope_grid <- data.frame(
  code = c("NS1", "NS2", "NS3", "NS4", "NS5", "NS6", "NS7", "NS8", "NS9", "NS10", "NS11", "NS12", "NS13", "NS14"),
  row = c(1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3),
  col = c(2, 3, 4, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4, 5),
  stringsAsFactors = FALSE
)
northslope_grid$name <- "North Slope Borough"
geofacet::grid_preview(northslope_grid)

nome_grid <- data.frame(
  code = c("No1", "No2", "No3", "No4", "No5", "No6", "No7", "No8", "No9", "No10", "No11", "No12", "No13"),
  row = c(1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4),
  col = c(2, 3, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 5),
  stringsAsFactors = FALSE
)
nome_grid$name <- "Nome Census Area"
geofacet::grid_preview(nome_grid)

yukon_grid <- data.frame(
  code = c("YY1", "YY2", "YY3", "YY4", "YY5", "YY6", "YY7"),
  row = c(1, 1, 1, 1, 2, 2, 2),
  col = c(3, 4, 5, 6, 1, 2, 3),
  stringsAsFactors = FALSE
)
yukon_grid$name <- "Yukon-Koyukuk Census Area"
geofacet::grid_preview(yukon_grid)

denali_grid <- data.frame(
  code = c("De1", "De2", "De3"),
  row = c(1, 2, 3),
  col = c(1, 1, 1),
  stringsAsFactors = FALSE
)
denali_grid$name <- "Denali Borough"
geofacet::grid_preview(denali_grid)

matanuska_grid <- data.frame(
  code = c("MS1", "MS2", "MS3", "MS4", "MS5", "MS6", "MS7", "MS8", "MS9", "MS10", "MS11", "MS12", "MS13", "MS14", "MS15", "MS16", "MS17", "MS18", "MS19", "MS20", "MS21", "MS22", "MS23", "MS24", "MS25", "MS26", "MS27", "MS28", "MS29", "MS30", "MS31", "MS32", "MS33", "MS34", "MS35", "MS36", "MS37", "MS38", "MS39", "MS41", "MS42", "MS43", "MS44", "MS45", "MS46", "MS47", "MS48", "MS49", "MS56", "MS40", "MS50", "MS51", "MS52", "MS53", "MS54", "MS55", "MS57", "MS58", "MS59", "MS60", "MS61", "MS62", "MS63", "MS64", "MS65", "MS66", "MS67", "MS68", "MS69", "MS70", "MS71", "MS73", "MS74", "MS75", "MS76", "MS77", "MS78", "MS79", "MS80", "MS81", "MS72", "MS82", "MS83", "MS84", "MS85", "MS86", "MS87", "MS89", "MS90", "MS91", "MS92", "MS93", "MS94", "MS88", "MS95", "MS96", "MS97", "MS98", "MS99", "MS100", "MS102", "MS103", "MS104", "MS105", "MS101", "MS106", "MS107", "MS108", "MS109", "MS110", "MS111", "MS113", "MS114", "MS115", "MS112", "MS116", "MS117", "MS118", "MS119", "MS120", "MS121", "MS123", "MS124", "MS122", "MS125", "MS126", "MS127", "MS128", "MS129", "MS130", "MS132", "MS133", "MS134", "MS135", "MS136", "MS137", "MS138", "MS139", "MS140", "MS141", "MS142", "MS143", "MS144", "MS145", "MS146"),
  row = c(1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 12, 12, 12, 12, 12, 12, 12, 12, 13, 13, 13, 13, 13, 13, 13, 14, 14, 14, 14, 14, 14),
  col = c(13, 14, 15, 9, 10, 11, 12, 13, 14, 15, 16, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 7, 7, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 7, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 7, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 7, 1, 2, 3, 4, 5, 6, 8, 9, 10, 7, 1, 2, 3, 4, 5, 6, 8, 9, 7, 1, 2, 3, 4, 5, 6, 8, 7, 1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4, 5, 6),
  stringsAsFactors = FALSE
)
matanuska_grid$name <- "Matanuska-Susitna Borough"
geofacet::grid_preview(matanuska_grid)

fairbanks_grid <- data.frame(
  code = c("FB1", "FB2", "FB3", "FB4", "FB5", "FB6", "FB7", "FB8", "FB9", "FB10", "FB11", "FB12", "FB13", "FB14", "FB15", "FB16", "FB17", "FB18", "FB19", "FB20", "FB21", "FB22", "FB23", "FB24", "FB25", "FB26", "FB27", "FB28", "FB29", "FB30", "FB31", "FB32", "FB33", "FB34", "FB35", "FB36", "FB37", "FB38", "FB39", "FB40", "FB41", "FB42", "FB43", "FB44", "FB45", "FB46", "FB47", "FB48", "FB49", "FB50", "FB51", "FB52", "FB53", "FB54", "FB55", "FB56", "FB57", "FB58", "FB59", "FB60", "FB61", "FB62", "FB63", "FB64", "FB65", "FB66", "FB67", "FB68", "FB69", "FB70", "FB71", "FB72", "FB73", "FB74", "FB75", "FB76", "FB77", "FB78", "FB79", "FB80", "FB81", "FB82", "FB83", "FB84", "FB85", "FB86", "FB87", "FB88", "FB89", "FB90", "FB91", "FB92", "FB93", "FB94", "FB95", "FB96", "FB97", "FB98", "FB99", "FB100", "FB101", "FB102", "FB103", "FB104", "FB105", "FB106", "FB107", "FB108", "FB109", "FB110", "FB111", "FB112", "FB113", "FB114", "FB115", "FB116", "FB117", "FB118", "FB119", "FB120", "FB121", "FB122", "FB123", "FB124", "FB125", "FB126", "FB127", "FB128", "FB129", "FB130", "FB131"),
  row = c(1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11),
  col = c(8, 9, 7, 8, 9, 4, 5, 6, 7, 8, 9, 10, 11, 14, 15, 16, 17, 18, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 2, 3, 4, 5, 6, 7, 8, 9, 10, 2, 3, 4, 5, 6, 7, 8, 9),
  stringsAsFactors = FALSE
)
fairbanks_grid$name <- "Fairbanks North Star Borough"
geofacet::grid_preview(fairbanks_grid)

sefairbanks_grid <- data.frame(
  code = c("SFB1", "SFB2", "SFB3", "SFB4", "SFB5", "SFB6", "SFB7", "SFB8", "SFB9"),
  row = c(1, 2, 2, 2, 3, 3, 3, 3, 4),
  col = c(4, 2, 3, 4, 1, 2, 3, 4, 4),
  stringsAsFactors = FALSE
)
sefairbanks_grid$name <- "Southeast Fairbanks Census Area"
geofacet::grid_preview(sefairbanks_grid)

anchorage_grid <- data.frame(
  code = c("An1", "An2", "An3", "An4", "An5", "An6", "An7", "An8", "An9", "An10", "An11", "An12", "An13", "An14", "An15", "An16", "An17", "An18", "An19", "An20", "An21", "An22", "An23", "An24", "An25", "An26", "An27", "An28", "An29", "An30", "An31", "An32", "An33", "An34", "An35", "An36", "An37", "An38", "An39", "An40", "An41", "An42", "An43", "An44", "An45", "An46", "An47", "An48", "An49", "An50", "An51", "An52", "An53", "An54", "An55", "An56", "An57", "An58", "An59", "An60", "An61", "An62", "An63", "An64", "An65", "An66", "An67", "An68", "An69", "An70", "An71", "An72", "An73", "An74", "An75", "An76", "An77", "An78", "An79", "An80", "An81", "An82", "An83", "An84", "An85", "An86", "An87", "An88", "An89", "An90", "An91", "An92", "An93", "An94", "An95", "An96", "An97", "An98", "An99", "An100", "An101", "An102", "An103", "An104", "An105", "An106", "An107", "An108", "An109", "An110", "An111", "An112", "An113", "An114", "An115", "An116", "An117", "An118", "An119", "An120", "An121", "An122", "An123", "An124", "An125", "An126", "An127", "An128", "An129", "An130", "An131", "An132", "An133", "An134", "An135", "An136", "An137", "An138", "An139", "An140", "An141", "An142", "An143", "An144", "An145", "An146", "An147", "An148", "An149", "An150", "An151", "An152", "An153", "An154", "An155", "An156", "An157", "An158", "An159", "An160", "An161", "An162", "An163", "An164", "An165", "An166", "An167", "An168", "An169", "An170", "An171", "An172", "An173", "An174", "An175", "An176", "An177", "An178", "An179", "An180", "An181", "An182", "An183", "An184", "An185", "An186", "An187", "An188", "An189", "An190", "An191", "An192", "An193", "An194", "An195", "An196", "An197", "An198", "An199",
           "An200", "An201", "An202", "An203", "An204", "An205", "An206", "An207", "An208", "An209", "An210", "An211", "An212", "An213", "An214", "An215", "An216", "An217", "An218", "An219", "An220", "An221", 
           "An222", "An223", "An224", "An225", "An226", "An227", "An228", "An229", "An230", "An231", "An232", "An233", "An234", "An235", "An236", "An237", "An238", "An239", "An240", "An241", "An242", "An243", "An244", "An245", 
           "An246", "An247", "An248", "An249", "An250", "An251", "An252", "An253", "An254", "An255", "An256", "An257", "An258", "An259", "An260", "An261", "An262", "An263", "An264", "An265", "An266", "An267", "An268", "An269", "An270", "An271", "An272", "An273", "An274", "An275", "An276", 
           "An277", "An278", "An279", "An280", "An281", "An282", "An283", "An284", "An285", "An286", "An287", "An288", "An289", "An290", "An291", "An292", "An293", "An294", "An295", "An296", "An297", "An298", "An299", "An300", "An301", "An302", "An303", 
           "An304", "An305", "An306", "An307", "An308", "An309", "An310", "An311", "An312", "An313", "An314", "An315", "An316", "An317", "An318", "An319", "An320", "An321", "An322", "An323", "An324", "An325", "An326", "An327", "An328", "An329", "An330", "An331", "An332", 
           "An333", "An334", "An335", "An336", "An337", "An338", "An339", "An340", "An341", "An342", "An343", "An344", "An345", "An346", "An347", "An348", "An349", "An350", "An351", "An352", "An353", "An354", "An355", "An356", "An357", "An358", "An359", "An360", "An361",
           "An362", "An363", "An364", "An365", "An366", "An367", "An368", "An369", "An370", "An371", "An372", "An373", "An374", "An375", "An376", "An377", "An378", "An379", "An380", "An381", "An382", "An383", "An384", "An385", "An386", "An387", "An388", "An389", "An390", "An391", "An392", "An393", "An394", "An395", "An396", "An397", "An398", "An399"),
  row = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 19, 19, 19, 19, 19, 19, 19, 19, 19, 20, 20, 20, 20, 20, 21, 21, 21, 21, 21, 22, 22, 22, 22, 22),
  col = c(14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 20, 21, 22, 23, 24, 25, 26, 27, 28, 21, 22, 23, 24, 25, 21, 22, 23, 24, 25, 21, 22, 23, 24, 25),
  stringsAsFactors = FALSE
)
anchorage_grid$name <- "Anchorage Municipality"
geofacet::grid_preview(anchorage_grid)

kenai_grid <- data.frame(
  code = c("KP1", "KP2", "KP3", "KP4", "KP5", "KP6", "KP7", "KP8", "KP9", "KP10", "KP11", "KP12", "KP13", "KP14", "KP15", "KP16", "KP17", "KP18", "KP19", "KP20", "KP21", "KP22", "KP23", "KP24", "KP25", "KP26", "KP27", "KP28", "KP29", "KP30", "KP31", "KP32", "KP33", "KP34", "KP35", "KP36", "KP37", "KP38", "KP39", "KP40", "KP41", "KP42", "KP43", "KP44", "KP45", "KP46", "KP47", "KP48", "KP49", "KP50", "KP51", "KP52", "KP53", "KP54", "KP55", "KP56", "KP57", "KP58", "KP59", "KP60", "KP61", "KP62", "KP63", "KP64", "KP65", "KP66", "KP67", "KP68", "KP69", "KP70", "KP71", "KP72", "KP73", "KP74", "KP75", "KP76", "KP77", "KP78", "KP79", "KP80"),
  row = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10),
  col = c(4, 5, 6, 7, 8, 4, 5, 6, 7, 8, 9, 10, 11, 4, 5, 6, 7, 8, 9, 10, 11, 12, 4, 5, 6, 7, 8, 9, 10, 11, 12, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4),
  stringsAsFactors = FALSE
)
kenai_grid$name <- "Kenai Peninsula Borough"
geofacet::grid_preview(kenai_grid)

kusilvak_grid <- data.frame(
  code = c("Ku1", "Ku2", "Ku3", "Ku4", "Ku5", "Ku6", "Ku7", "Ku8", "Ku9", "Ku10", "Ku11"),
  row = c(1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3),
  col = c(2, 3, 4, 2, 3, 4, 5, 1, 2, 3, 4),
  stringsAsFactors = FALSE
)
kusilvak_grid$name <- "Kusilvak Census Area"
geofacet::grid_preview(kusilvak_grid)

bethel_grid <- data.frame(
  code = c("Be1", "Be2", "Be3", "Be4", "Be5", "Be6", "Be7", "Be8", "Be9", "Be10", "Be11", "Be12", "Be13", "Be14", "Be15", "Be16", "Be17", "Be18", "Be19", "Be20", "Be21", "Be22", "Be23", "Be24", "Be25"),
  row = c(1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 5),
  col = c(6, 7, 8, 9, 10, 11, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 2, 3, 4, 5, 6, 4, 5, 4),
  stringsAsFactors = FALSE
)
bethel_grid$name <- "Bethel Census Area"
geofacet::grid_preview(bethel_grid)

dillingham_grid <- data.frame(
  code = c("Di1", "Di2", "Di3", "Di4", "Di5", "Di6", "Di7"),
  row = c(1, 1, 2, 2, 2, 3, 3),
  col = c(3, 4, 2, 3, 4, 1, 2),
  stringsAsFactors = FALSE
)
dillingham_grid$name <- "Dillingham Census Area"
geofacet::grid_preview(dillingham_grid)

bristol_grid <- data.frame(
  code = c("BB1"),
  row = c(1),
  col = c(1),
  stringsAsFactors = FALSE
)
bristol_grid$name <- "Bristol Bay Borough"
geofacet::grid_preview(bristol_grid)

lake_grid <- data.frame(
  code = c("LP1", "LP2"),
  row = c(1, 2),
  col = c(1, 1),
  stringsAsFactors = FALSE
)
lake_grid$name <- "Lake and Peninsula Borough"
geofacet::grid_preview(lake_grid)

ale_east_grid <- data.frame(
  code = c("AE1", "AE2", "AE3", "AE4"),
  row = c(1, 1, 2, 2),
  col = c(2, 3, 1, 2),
  stringsAsFactors = FALSE
)
ale_east_grid$name <- "Aleutians East Borough"
geofacet::grid_preview(ale_east_grid)

ale_west_grid <- data.frame(
  code = c("AW1", "AW2", "AW3", "AW4", "AW5", "AW6", "AW7", "AW8"),
  row = c(1, 1, 2, 2, 2, 2, 2, 2),
  col = c(6, 7, 1, 2, 3, 4, 5, 6),
  stringsAsFactors = FALSE
)
ale_west_grid$name <- "Aleutians West Census Area"
geofacet::grid_preview(ale_west_grid)

kodiak_grid <- data.frame(
  code = c("KI1", "KI2", "KI3", "KI4", "KI5", "KI6", "KI7", "KI8", "KI9", "KI10", "KI11", "KI12", "KI13", "KI14", "KI15", "KI16", "KI17", "KI18"),
  row = c(1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 7),
  col = c(5, 4, 5, 6, 3, 4, 5, 2, 3, 4, 5, 1, 2, 3, 4, 2, 3, 2),
  stringsAsFactors = FALSE
)
kodiak_grid$name <- "Kodiak Island Borough"
geofacet::grid_preview(kodiak_grid)

# Adjust location of each grid, with panhandle_grids as reference
grid_preview(panhandle_grids)
anchorage_grid$col <-anchorage_grid$col - 28
anchorage_grid$row <-anchorage_grid$row - 10
kenai_grid$col <-kenai_grid$col - 20
kenai_grid$row <-kenai_grid$row + 7
fairbanks_grid$col <- fairbanks_grid$col - 12
fairbanks_grid$row <- fairbanks_grid$row - 21
sefairbanks_grid$col <- sefairbanks_grid$col - 3
sefairbanks_grid$row <- sefairbanks_grid$row - 13
denali_grid$col <- denali_grid$col - 12
denali_grid$row <- denali_grid$row - 13
yukon_grid$col <- yukon_grid$col - 12
yukon_grid$row <- yukon_grid$row - 20
northslope_grid$col <- northslope_grid$col - 10
northslope_grid$row <- northslope_grid$row - 23
nwa_grid$col <- nwa_grid$col - 14
nwa_grid$row <- nwa_grid$row - 22
nome_grid$col <- nome_grid$col - 17
nome_grid$row <- nome_grid$row - 20
matanuska_grid$col <- matanuska_grid$col - 28
matanuska_grid$row <- matanuska_grid$row - 17
kusilvak_grid$col <- kusilvak_grid$col - 31
kusilvak_grid$row <- kusilvak_grid$row + 1
bethel_grid$col <- bethel_grid$col - 32
bethel_grid$row <- bethel_grid$row + 3
dillingham_grid$col <- dillingham_grid$col - 28
dillingham_grid$row <- dillingham_grid$row + 5
bristol_grid$col <- bristol_grid$col - 26
bristol_grid$row <- bristol_grid$row + 7
lake_grid$col <- lake_grid$col - 25
lake_grid$row <- lake_grid$row + 7
ale_east_grid$col <- ale_east_grid$col - 28
ale_east_grid$row <- ale_east_grid$row + 8
ale_west_grid$col <- ale_west_grid$col - 34
ale_west_grid$row <- ale_west_grid$row + 10
kodiak_grid$col <- kodiak_grid$col - 28
kodiak_grid$row <- kodiak_grid$row + 10

# Stack all grids on top of each other
all_grids <- rbind(panhandle_grids, anchorage_grid, kenai_grid, fairbanks_grid, sefairbanks_grid,
                   denali_grid, yukon_grid, northslope_grid, nwa_grid, nome_grid, matanuska_grid,
                   kusilvak_grid, bethel_grid, dillingham_grid, bristol_grid, lake_grid,
                   ale_east_grid, ale_west_grid, kodiak_grid)

# Make all coordinates positive
min(all_grids$row)
min(all_grids$col)
all_grids$row <- all_grids$row + 23
all_grids$col <- all_grids$col + 34
# View resulting grid
geofacet::grid_preview(all_grids)


##---------Plot-------

# Create fake temp data
df <- all_grids
df$value = c(runif(n=dim(df)[1], min=1, max=20))
meandf = df %>% group_by(name) %>% summarise(mean_value=mean(value))
temp_df_mean <- merge(df, meandf, by = "name")
temp_df_mean$name <- as.factor(temp_df_mean$name)
temp_df_mean$current_hp_adoption <- 0
temp_df_mean[temp_df_mean$code == "An1", "current_hp_adoption"] <- 1
temp_df_mean$current_hp_adoption <- as.factor(temp_df_mean$current_hp_adoption)

# Plot

# coerce name into integer-factor
temp_df_raster <- 
  temp_df_mean %>%
  mutate(name2 = as.integer(factor(name))) %>% # coerce name into integer-factor
  dplyr::select(row, col, name2)               # select X, Y (for coords), Z (for value)

temp_df_raster <- rasterFromXYZ(temp_df_raster)                       # turn to raster 
temp_df_polygon <- rasterToPolygons(temp_df_raster, dissolve = TRUE)  # turn to polygon 
temp_df_polygonSF <- st_as_sf(temp_df_polygon)                        # turn to sf object

ggplot() +
  geom_tile(data = temp_df_mean, aes(y = col, x = row, fill = name), color = 'white') +
  geom_sf(data = temp_df_polygonSF, size = 1, fill = NA, color = 'black') +
  theme_void()

ggplot() +
  geom_tile(data = temp_df_mean, aes(y = col, x = row, fill = current_hp_adoption), color = 'white') +
  geom_sf(data = temp_df_polygonSF, size = 1.5, fill = NA, color = 'black') +
  scale_fill_manual(values = c("lightgrey", "red"), labels = c("No", "Yes"), name = "Current HP Adoption") +
  theme_void()

### Notes about next steps:
# Notes from Erin: who where heat pumps are - we may have to bother the estimates for a best estimate
# Phylicia published an estimate for the railbelt
# Color by individual tiles
# Projected adoption rates - also really low, maybe two more boxes
# THEN aggressive - which would be a lot of boxes
# Lots of time people will pick the middle option - we don't want them to pick the middle option, we
# want the middle option to seem ridiculous, we want to make the aggressive option seem like the one we want
# most will come from Phylicia's paper 
# Bright color to show where the current ones so your eye is drawn to it, other parts grey
# plain background, borders, labels like they are in the example
# big numbers on the side or bottom either on the borough or state-level 
# could play around with colors
# silas - could also have different plots for different adoption rates and colors represent outcome measures

##---------Incorporating calculator data-------

setwd("/Users/katherinegrisanzio/Desktop/dssg-vis/")

# hpcalc_data <- read.csv("results_tmy3.csv") # first of Brian's data exports
base_df <- read.csv("results_baseCase.csv")
medfuel_df <- read.csv("results_medFuelEsc.csv")
highfuel_df <- read.csv("results_highFuelEsc.csv")
medrebate_df <- read.csv("results_medRebate.csv")
highrebate_df <- read.csv("results_highRebate.csv")

# 'NPV' column is economic feasibility information
# 'Census_Area' refers to Boroughs, but from 2010 Census data (w/ potentially differing names from 2020)

str(base_df)
levels(factor(base_df$Census_Area)) # 2010 boroughs
levels(factor(all_grids$name)) # AK figure boroughs

# Kusilvak Census Area is in the AK figure boroughs but not 2010 boroughs
# Wade-Hampton is in 2010 boroughs but not AK figure
# OH! Kusilvak is formerly known as Wade-Hampton! We'll re-name Wade Hampton
base_df[which(base_df$Census_Area == "Wade Hampton Census Area"), "Census_Area"] <- "Kusilvak Census Area"
medfuel_df[which(medfuel_df$Census_Area == "Wade Hampton Census Area"), "Census_Area"] <- "Kusilvak Census Area"
highfuel_df[which(highfuel_df$Census_Area == "Wade Hampton Census Area"), "Census_Area"] <- "Kusilvak Census Area"
# And re-name anchorage for consistency in capitalization
base_df[which(base_df$Census_Area == "Anchorage municipality"), "Census_Area"] <- "Anchorage Municipality"
medfuel_df[which(medfuel_df$Census_Area == "Anchorage municipality"), "Census_Area"] <- "Anchorage Municipality"
highfuel_df[which(highfuel_df$Census_Area == "Anchorage municipality"), "Census_Area"] <- "Anchorage Municipality"


# Check they're the same now
compare.list(levels(factor(base_df$Census_Area)), levels(factor(all_grids$name))) # yes
identical(levels(factor(base_df$Census_Area)), levels(factor(all_grids$name))) # yes

# First, average by borough
basedf_avg <- base_df %>%
  group_by(Census_Area) %>%
  summarise(mean_NPV = mean(NPV), mean_co2 = mean(CO2_lbs_saved))
names(basedf_avg)[1] <- 'name'

medfuel_df_avg <- medfuel_df %>%
  group_by(Census_Area) %>%
  summarise(mean_NPV = mean(NPV), mean_co2 = mean(CO2_lbs_saved))
names(medfuel_df_avg)[1] <- 'name'

highfuel_df_avg <- highfuel_df %>%
  group_by(Census_Area) %>%
  summarise(mean_NPV = mean(NPV), mean_co2 = mean(CO2_lbs_saved))
names(highfuel_df_avg)[1] <- 'name'

# Merge
merged_basedf <- merge(all_grids, basedf_avg, by = 'name')
merged_medfueldf <- merge(all_grids, medfuel_df_avg, by = 'name')
merged_highfueldf <- merge(all_grids, highfuel_df_avg, by = 'name')


# coerce name into integer-factor
merged_basedf_raster <- 
  merged_basedf %>%
  mutate(name2 = as.integer(factor(name))) %>% # coerce name into integer-factor
  mutate(row = -row) %>%
  dplyr::select(col, row, name2)               # select X, Y (for coords), Z (for value)

merged_medfueldf_raster <- 
  merged_medfueldf %>%
  mutate(name2 = as.integer(factor(name))) %>% # coerce name into integer-factor
  mutate(row = -row) %>%
  dplyr::select(col, row, name2)               # select X, Y (for coords), Z (for value)

merged_highfueldf_raster <- 
  merged_highfueldf %>%
  mutate(name2 = as.integer(factor(name))) %>% # coerce name into integer-factor
  mutate(row = -row) %>%
  dplyr::select(col, row, name2)               # select X, Y (for coords), Z (for value)



merged_basedf_raster <- rasterFromXYZ(merged_basedf_raster)       # turn to raster 
merged_basedf_polygon <- rasterToPolygons(merged_basedf_raster, dissolve = TRUE)  # turn to polygon 
merged_basedf_polygonSF <- st_as_sf(merged_basedf_polygon)                        # turn to sf object
merged_medfueldf_raster <- rasterFromXYZ(merged_medfueldf_raster)       # turn to raster 
merged_medfueldf_polygon <- rasterToPolygons(merged_medfueldf_raster, dissolve = TRUE)  # turn to polygon 
merged_medfueldf_polygonSF <- st_as_sf(merged_medfueldf_polygon)                        # turn to sf object
merged_highfueldf_raster <- rasterFromXYZ(merged_highfueldf_raster)       # turn to raster 
merged_highfueldf_polygon <- rasterToPolygons(merged_highfueldf_raster, dissolve = TRUE)  # turn to polygon 
merged_highfueldf_polygonSF <- st_as_sf(merged_highfueldf_polygon)                        # turn to sf object

#merged_grid_npv_polygonSF$name <- c("Aleutians East Borough", "Hoonah-Angoon Census Area", "Juneau City and Borough",
#                                    "Kenai Peninsula Borough", "Ketchikan Gateway Borough", "Kodiak Island Borough",
#                                    "Kusilvak Census Area", "Lake and Peninsula Borough", "Matanuska-Susitna Borough",
#                                    "Nome Census Area", "North Slope Borough", "Aleutians West Census Area", "Northwest Arctic Borough",         
#                                    "Petersburg Borough", "Prince of Wales-Hyder Census Area", "Sitka City and Borough", "Southeast Fairbanks Census Area", "Valdez-Cordova Census Area",       
#                                    "Wrangell City and Borough", "Yakutat City and Borough",         
#                                    "Yukon-Koyukuk Census Area", "Anchorage Municipality", "Bethel Census Area",               
#                                    "Bristol Bay Borough", "Denali Borough",                   
#                                    "Dillingham Census Area", "Fairbanks North Star Borough",     
#                                    "Haines Borough") # left off here

# Base - NPV
g <- ggplot() +
  geom_tile(data = merged_basedf, aes(y = -row, x = col, fill = mean_NPV, text = sprintf("Borough: %s<br>Net Present Value: %s<br>", name, round(mean_NPV))), color = 'white') +
  geom_sf(data = merged_basedf_polygonSF, size = 1, fill = NA, color = 'black') +
  #scale_fill_gradient(low = "lightblue", high = "darkblue", guide = "legend") +
  scale_fill_viridis_c(option = "B", direction = -1, limits=c(9000,60000)) +
  labs(fill = 'Economic Feasibility') +
  #geom_sf_text(data = merged_grid_npv_polygonSF, aes(label = name2)) +
  theme_void() +
  xlim(c(0,52)) +
  ylim(c(-41,0)) +
  theme(plot.margin=unit(c(0,0,0,0),"mm"))
g_int <- ggplotly(g, width = 600, height = 700, # ggplotly returns a plotly object 
         tooltip = c("text"))

# Medium fuel - NPV
g1 <- ggplot() +
  geom_tile(data = merged_medfueldf, aes(y = -row, x = col, fill = mean_NPV, text = sprintf("Borough: %s<br>Net Present Value: %s<br>", name, round(mean_NPV))), color = 'white') +
  geom_sf(data = merged_medfueldf_polygonSF, size = 1, fill = NA, color = 'black') +
  #scale_fill_gradient(low = "lightblue", high = "darkblue", guide = "legend") +
  scale_fill_viridis_c(option = "B", direction = -1, limits=c(9000,60000)) +
  labs(fill = 'Economic Feasibility') +
  #geom_sf_text(data = merged_grid_npv_polygonSF, aes(label = name2)) +
  theme_void()
g1_int <- ggplotly(g1, width = 600, height = 700, 
                  tooltip = c("text")) 

# High fuel - NPV
g2 <- ggplot() +
  geom_tile(data = merged_highfueldf, aes(y = -row, x = col, fill = mean_NPV, text = sprintf("Borough: %s<br>Net Present Value: %s<br>", name, round(mean_NPV))), color = 'white') +
  geom_sf(data = merged_highfueldf_polygonSF, size = 1, fill = NA, color = 'black') +
  #scale_fill_gradient(low = "lightblue", high = "darkblue", guide = "legend") +
  scale_fill_viridis_c(option = "B", direction = -1, limits=c(9000,60000)) +
  labs(fill = 'Economic Feasibility') +
  #geom_sf_text(data = merged_grid_npv_polygonSF, aes(label = name2)) +
  theme_void()
g2_int <- ggplotly(g2, width = 600, height = 700,
                   tooltip = c("text")) 


# Base - CO2
g_co2 <- ggplot() +
  geom_tile(data = merged_basedf, aes(y = -row, x = col, fill = mean_co2, text = sprintf("Borough: %s<br>Net Present Value: %s<br>", name, round(mean_NPV))), color = 'white') +
  geom_sf(data = merged_basedf_polygonSF, size = 1, fill = NA, color = 'black') +
  #scale_fill_gradient(low = "lightblue", high = "darkblue", guide = "legend") +
  scale_fill_viridis_c(option = "B", direction = -1) + #limits = c(X,X)
  labs(fill = 'Carbon Dioxide Saved') +
  #geom_sf_text(data = merged_grid_npv_polygonSF, aes(label = name2)) +
  theme_void()
g_co2_int <- ggplotly(g_co2, width = 600, height = 700, # ggplotly returns a plotly object 
                  tooltip = c("text"))

# Med fuel - CO2
g_medfuel_co2 <- ggplot() +
  geom_tile(data = merged_medfueldf, aes(y = -row, x = col, fill = mean_co2, text = sprintf("Borough: %s<br>Net Present Value: %s<br>", name, round(mean_NPV))), color = 'white') +
  geom_sf(data = merged_medfueldf_polygonSF, size = 1, fill = NA, color = 'black') +
  #scale_fill_gradient(low = "lightblue", high = "darkblue", guide = "legend") +
  scale_fill_viridis_c(option = "B", direction = -1) + #limits = c(X,X)
  labs(fill = 'Carbon Dioxide Saved') +
  #geom_sf_text(data = merged_grid_npv_polygonSF, aes(label = name2)) +
  theme_void()
g_medfuel_co2_int <- ggplotly(g_medfuel_co2, width = 600, height = 700, # ggplotly returns a plotly object 
                      tooltip = c("text"))

# High fuel - CO2
g_highfuel_co2 <- ggplot() +
  #geom_tile(data = merged_highfueldf, aes(y = -row, x = col, fill = mean_co2, text = sprintf("Borough: %s<br>Net Present Value: %s<br>", name, round(mean_NPV))), color = 'white') +
  geom_sf(data = merged_highfueldf_polygonSF, size = 1, fill = NA, color = 'black') +
  #scale_fill_gradient(low = "lightblue", high = "darkblue", guide = "legend") +
  scale_fill_viridis_c(option = "B", direction = -1) + #limits = c(X,X)
  labs(fill = 'Carbon Dioxide Saved') +
  #geom_sf_text(data = merged_grid_npv_polygonSF, aes(label = name2)) +
  theme_void()
g_highfuel_co2_int <- ggplotly(g_highfuel_co2, width = 600, height = 700, # ggplotly returns a plotly object 
                              tooltip = c("text"))


# Alternative way of plotting - all plot_ly, no ggplot + ggplotly

g2 <- plot_ly() # create a plotly object
g2 <- add_trace( # add the scatter layer
  g2,
  data = merged_highfueldf,
  type = "scatter",
  mode   = 'markers',
  marker = list(symbol = 'square', size = 10),
  y = ~(-row),
  x = ~col,
  text = ~paste("Borough:", name, "<br>Net Present Value:", round(mean_NPV)),
  color = ~mean_NPV,
  hoverinfo = "text"
)
g2 <- add_sf( # add the geom_sf layer
  g2, 
  data = merged_highfueldf_polygonSF,
  size = I(1),
  fill = I("transparent"),
  color = I("black")
)
g2 <- colorbar(g2, limits = c(10000,60000))
g2 <- layout( # set the labels and axis titles
  g2,
  xaxis = list(title = ""),
  yaxis = list(title = ""),
  showlegend = FALSE
)
m <- list( # layout
  l = 50,
  r = 50,
  b = 100,
  t = 100,
  pad = 0
)
g2 <- g2 %>% layout(autosize = F, width = 775, height = 775, margin = m)

#text_annotation <- list(
#  x = 9, y = -45, # Adjust x and y values for positioning
#  text = "Cost-effectiveness is expressed as Net Present Value, or the sum of the benefits minus the costs \nof a project over the life of a project. Here, a NPV value of 10K means that an average household in that borough will save \n10 thousand dollars from installing a heat pump over the life of a heat pump (~14 years).",
#  showarrow = FALSE,
#  xref = "x",
#  yref = "y"
#)
#g2 <- g2 %>% layout(annotations = list(text_annotation))
g2 # show plot

# Function for NPV plot
npv_plot_func <- function(plot_name, scatter_df, sf_df){
plot_name <- plot_ly() # create a plotly object
plot_name <- add_trace( # add the scatter layer
  plot_name,
  data = scatter_df,
  type = "scatter",
  mode   = 'markers',
  marker = list(symbol = 'square', size = 9),
  y = ~(-row),
  x = ~col,
  text = ~paste("Borough:", name, "<br>Net Present Value:", round(mean_NPV)),
  color = ~mean_NPV,
  colors = "YlOrRd",
  hoverinfo = "text"
)
plot_name <- add_sf( # add the geom_sf layer
  plot_name, 
  data = sf_df,
  size = I(1),
  fill = I("transparent"),
  color = I("black")
)
plot_name <- plot_name %>% colorbar(limits = c(9000,58000), title = "<b>Cost-Effectiveness</b>\n<i>Net Present Value",
                                    orientation = "h", len = 1)
plot_name <- layout( # set the labels and axis titles
  plot_name,
  title = '<b>Average Cost Savings from Heat Pump Installation \nby Borough',
  xaxis = list(title = ""),
  yaxis = list(title = ""),
  showlegend = FALSE
)
m <- list( # layout
  l = 30,
  r = 1,
  b = 1,
  t = 75,
  pad = 3
)
plot_name <- plot_name %>% layout(autosize = F, width = 600, height = 680, margin = m)
plot_name # show plot
}

plotly_npv_base <- npv_plot_func(plotly_npv_base, merged_basedf, merged_basedf_polygonSF)
plotly_npv_medfuel <- npv_plot_func(plotly_npv_medfuel, merged_medfueldf, merged_medfueldf_polygonSF)
plotly_npv_highfuel <- npv_plot_func(plotly_npv_highfuel, merged_highfueldf, merged_highfueldf_polygonSF)

# Interactive plot for CO2 at borough level
plotly_co2 <- plot_ly() # create a plotly object
plotly_co2 <- add_trace( # add the scatter layer
  plotly_co2,
    data = merged_basedf,
    type = "scatter",
    mode   = 'markers',
    marker = list(symbol = 'square', size = 9),
    y = ~(-row),
    x = ~col,
    text = ~paste("Borough:", name, "<br>CO2 Saved:", round(mean_co2), "lbs"),
    color = ~mean_co2,
    colors = "YlGn",
    hoverinfo = "text"
  )
plotly_co2 <- add_sf( # add the geom_sf layer
  plotly_co2, 
    data = merged_basedf_polygonSF,
    size = I(1),
    fill = I("transparent"),
    color = I("black")
  )
plotly_co2 <- plotly_co2 %>% colorbar(limits = c(2800,8050), title = "<b>CO2 Saved (lbs)",
                                      orientation = "h", len = 1)
plotly_co2 <- layout( # set the labels and axis titles
  plotly_co2,
    title = '<b>Average Pounds of Carbon Dioxide Saved from Heat Pumps \nPer Household',
    xaxis = list(title = ""),
    yaxis = list(title = ""),
    showlegend = FALSE
  )
m <- list( # layout
    l = 30,
    r = 1,
    b = 1,
    t = 75,
    pad = 3
  )
plotly_co2 <- plotly_co2 %>% layout(autosize = F, width = 600, height = 680, margin = m)
plotly_co2 # show plot



# FINAL ONES
first_proj <- read.csv('adoption_scenarios_by_cop_and_pop_max_50p_sat_pretty.csv')
head(first_proj)
names(first_proj)[2] <- 'name'
proj_df <- merge(first_proj, merged_basedf, by = 'name')
proj_df_raster <- 
  proj_df %>%
  mutate(name2 = as.integer(factor(name))) %>% # coerce name into integer-factor
  mutate(row = -row) %>%
  dplyr::select(col, row, name2)               # select X, Y (for coords), Z (for value)

proj_df_raster <- rasterFromXYZ(proj_df_raster)       # turn to raster 
proj_df_polygon <- rasterToPolygons(proj_df_raster, dissolve = TRUE)  # turn to polygon 
proj_df_polygonSF <- st_as_sf(proj_df_polygon)                        # turn to sf object


# Current HP adoption rates
current_adoptrate <- plot_ly() # create a plotly object
current_adoptrate <- add_trace( # add the scatter layer
  current_adoptrate,
  data = proj_df,
  type = "scatter",
  mode   = 'markers',
  marker = list(symbol = 'square', size = 9),
  y = ~(-row),
  x = ~col,
  text = ~paste("Borough:", name, "<br>", "Number of heat pumps:", hp_current, "<br>", "Percentage out of households in borough:", round(hp_current_prop_b*100, 2), "%"),
  #text = sprintf("Borough: %s<br>Number of Heat Pumps: %s<br>", name, hp_current),
  text = ~name,
  #hovertemplate = paste('<b>Borough</b>: %{text}<br>', '<b>Number of Heat Pumps</b>: %{marker.color}<br>'),
  color = ~hp_current,
  colors = "YlOrRd",
  hoverinfo = "text"
)
current_adoptrate <- add_sf( # add the geom_sf layer
  current_adoptrate, 
  data = proj_df_polygonSF,
  size = I(1),
  fill = I("transparent"),
  color = I("black")
)
current_adoptrate <- current_adoptrate %>% colorbar(limits = c(0,7050), title = "<b>No. of Heat Pumps",
                                                    orientation = "h", len = 1)
current_adoptrate <- layout( # set the labels and axis titles
  current_adoptrate,
  title = '<b>Number of Heat Pumps Installed \nby Borough',
  xaxis = list(title = ""),
  yaxis = list(title = ""),
  showlegend = FALSE
)
m <- list( # layout
  l = 30,
  r = 1,
  b = 1,
  t = 75,
  pad = 3
)
current_adoptrate <- current_adoptrate %>% layout(autosize = F, width = 600, height = 680, margin = m)
current_adoptrate # show plot

# 2% HP adoption rates
two_adoptrate <- plot_ly() # create a plotly object
two_adoptrate <- add_trace( # add the scatter layer
  two_adoptrate,
  data = proj_df,
  type = "scatter",
  mode   = 'markers',
  marker = list(symbol = 'square', size = 9),
  y = ~(-row),
  x = ~col,
  text = ~paste("Borough:", name, "<br>", "Number of heat pumps:", hp_2p, "<br>", "Percentage out of households in borough:", round(hp_2p_prop_b*100, 2), "%"),
  #text = sprintf("Borough: %s<br>Number of Heat Pumps: %s<br>", name, hp_current),
  text = ~name,
  #hovertemplate = paste('<b>Borough</b>: %{text}<br>', '<b>Number of Heat Pumps</b>: %{marker.color}<br>'),
  color = ~hp_2p,
  colors = "YlOrRd",
  hoverinfo = "text"
)
two_adoptrate <- add_sf( # add the geom_sf layer
  two_adoptrate, 
  data = proj_df_polygonSF,
  size = I(1),
  fill = I("transparent"),
  color = I("black")
)
two_adoptrate <- two_adoptrate %>% colorbar(limits = c(0,7050), title = "<b>No. of Heat Pumps",
                                            orientation = "h", len = 1)
two_adoptrate <- layout( # set the labels and axis titles
  two_adoptrate,
  title = '<b>Number of Heat Pumps Installed \nby Borough',
  xaxis = list(title = ""),
  yaxis = list(title = ""),
  showlegend = FALSE
)
m <- list( # layout
  l = 30,
  r = 1,
  b = 1,
  t = 75,
  pad = 3
)
two_adoptrate <- two_adoptrate %>% layout(autosize = F, width = 600, height = 680, margin = m)
two_adoptrate # show plot


# 15% HP adoption rates
fifteen_adoptrate <- plot_ly() # create a plotly object
fifteen_adoptrate <- add_trace( # add the scatter layer
  fifteen_adoptrate,
  data = proj_df,
  type = "scatter",
  mode   = 'markers',
  marker = list(symbol = 'square', size = 9),
  y = ~(-row),
  x = ~col,
  text = ~paste("Borough:", name, "<br>", "Number of heat pumps:", hp_15p, "<br>", "Percentage out of households in borough:", round(hp_15p_prop_b*100, 2), "%"),
  #text = sprintf("Borough: %s<br>Number of Heat Pumps: %s<br>", name, hp_current),
  text = ~name,
  #hovertemplate = paste('<b>Borough</b>: %{text}<br>', '<b>Number of Heat Pumps</b>: %{marker.color}<br>'),
  color = ~hp_15p,
  colors = "YlOrRd",
  hoverinfo = "text"
)
fifteen_adoptrate <- add_sf( # add the geom_sf layer
  fifteen_adoptrate, 
  data = proj_df_polygonSF,
  size = I(1),
  fill = I("transparent"),
  color = I("black")
)
fifteen_adoptrate <- fifteen_adoptrate %>% colorbar(limits = c(0,7050), title = "<b>No. of Heat Pumps",
                                                    orientation = "h", len = 1)
fifteen_adoptrate <- layout( # set the labels and axis titles
  fifteen_adoptrate,
  title = '<b>Number of Heat Pumps Installed \nby Borough',
  xaxis = list(title = ""),
  yaxis = list(title = ""),
  showlegend = FALSE
)
m <- list( # layout
  l = 30,
  r = 1,
  b = 1,
  t = 75,
  pad = 3
)
fifteen_adoptrate <- fifteen_adoptrate %>% layout(autosize = F, width = 600, height = 680, margin = m)
fifteen_adoptrate # show plot


# 15% HP adoption rates - percentages
fifteen_adoptrate_perc <- plot_ly() # create a plotly object
fifteen_adoptrate_perc <- add_trace( # add the scatter layer
  fifteen_adoptrate_perc,
  data = proj_df,
  type = "scatter",
  mode   = 'markers',
  marker = list(symbol = 'square', size = 9),
  y = ~(-row),
  x = ~col,
  text = ~paste("Borough:", name, "<br>", "Number of heat pumps:", hp_15p, "<br>", "Percentage out of households in borough:", round(hp_15p_prop_b*100, 2), "%"),
  #text = sprintf("Borough: %s<br>Number of Heat Pumps: %s<br>", name, hp_current),
  text = ~name,
  #hovertemplate = paste('<b>Borough</b>: %{text}<br>', '<b>Number of Heat Pumps</b>: %{marker.color}<br>'),
  color = ~hp_15p_prop_b,
  colors = "YlOrRd",
  hoverinfo = "text"
)
fifteen_adoptrate_perc <- add_sf( # add the geom_sf layer
  fifteen_adoptrate_perc, 
  data = proj_df_polygonSF,
  size = I(1),
  fill = I("transparent"),
  color = I("black")
)
fifteen_adoptrate_perc <- fifteen_adoptrate_perc %>% colorbar(limits = c(0,.5), title = "<b>No. of Heat Pumps",
                                                              orientation = "h", len = 1)
fifteen_adoptrate_perc <- layout( # set the labels and axis titles
  fifteen_adoptrate_perc,
  title = '<b>Number of Heat Pumps Installed \nby Borough',
  xaxis = list(title = ""),
  yaxis = list(title = ""),
  showlegend = FALSE
)
m <- list( # layout
  l = 30,
  r = 1,
  b = 1,
  t = 75,
  pad = 3
)
fifteen_adoptrate_perc <- fifteen_adoptrate_perc %>% layout(autosize = F, width = 600, height = 680, margin = m)
fifteen_adoptrate_perc # show plot


# Plain tilegram for first page of dashboard
plain_plot <- plot_ly() # create a plotly object
plain_plot <- add_trace( # add the scatter layer
  plain_plot,
  data = proj_df,
  type = "scatter",
  mode   = 'markers',
  marker = list(symbol = 'square', size = 9, color = 'rgb(230,230,230)'),
  text = ~paste("Borough:", name, "<br>", "Value of interest:", hp_15p),
  hoverinfo = "text",
  y = ~(-row),
  x = ~col
)
plain_plot <- add_sf( # add the geom_sf layer
  plain_plot, 
  data = proj_df_polygonSF,
  size = I(1),
  fill = I("transparent"),
  color = I("black")
)
plain_plot <- layout( # set the labels and axis titles
  plain_plot,
  title = '',
  xaxis = list(title = ""),
  yaxis = list(title = ""),
  showlegend = FALSE
)
m <- list( # layout
  l = 30,
  r = 1,
  b = 1,
  t = 75,
  pad = 3
)
plain_plot <- plain_plot %>% layout(autosize = F, width = 600, height = 680, margin = m)
plain_plot # show plot




##------Shiny dashboard-----

ui <- dashboardPage(skin = "blue",
  dashboardHeader(title = HTML("<b>Heat Pump Adoption in Alaska: A Visualization Tool</b>"), titleWidth = 540),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Motivation", tabName = "motivation", icon = icon("file")),      
      menuItem("Adoption Rate Projections", tabName = "statewide", icon = icon("chart-line")),
      menuItem("Projections", tabName = "proj", icon = icon("money-bill"),
               menuSubItem("Feasibility", tabName = "sub_feas"), 
               menuSubItem("Economic", tabName = "sub_ec"),
               menuSubItem("Environmental", tabName = "sub_env")),
      menuItem("Case Studies", tabName = "case", icon = icon("map-marker"))
    )
  ),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    tabItems(
      tabItem(tabName = "motivation",
              fluidRow(
                column(width = 12,
                  titlePanel("Guide to Exploring the Visualizations on this Dashboard"),
                  box(title = HTML(" Many of our visualizations are <b>Tilegrams</b>"),
                    width = NULL,
                    HTML("A Tilegram, short for <i>Tiled Cartogram</i>, is a map made up of tiles where regions are proportional to a dataset. In our plots, regions are Census Boroughs and they are proportional to the number of people in that Borough. Tilegrams can represent demographic data more accurately than traditional geographic maps, but still retain a familiar shape. You can read more about tilegrams here <insert a link?>")),
                  imageOutput("image"))
              )
      ),
      tabItem(tabName = "statewide",
              fluidRow(
                column(width=4,
                  box(title = HTML("<b>Projected Heat Pump Adoption Rates</b>"), solidHeader = TRUE,
                    "Toggle between current heat pump estimates, moderate projections (2% of households), and aggressive projections (15% of households)", 
                    ticks = FALSE, radioGroupButtons(
                      inputId = "adoption_button",
                      label = " ",
                      choices = c("Current", "2%", "15%"),
                      status = "primary", size = 'normal', justified = TRUE), width = NULL), 
                  valueBoxOutput("moneysaved", width = NULL),
                  valueBoxOutput("co2saved", width = NULL),
                  valueBoxOutput("heatingdays", width = NULL),
                ),
                column(width = 8,
                  plotlyOutput("plot1")
                )
              )
      ),
      tabItem(tabName = "sub_ec",
              fluidRow(
                column(width=4, 
                  box(title = HTML("<b>Fuel Price Increase Projections</b>"), solidHeader = TRUE,
                    "Toggle between current fuel prices, medium increases in projected fuel prices, and large increases in projected fuel prices", 
                    ticks = FALSE, radioGroupButtons(
                      inputId = "buttons_fuel",
                      label = "Level of increase:",
                      choices = c("Current", "Medium", "Large"),
                      status = "primary", size = 'normal', justified = TRUE), width = NULL),
                  box(title = HTML("<b>Rebate Projections</b>"), solidHeader = TRUE,
                    "Toggle between currently provided rebates, moderate increases in projected rebates, and large increases in projected rebates", 
                    ticks = FALSE, radioGroupButtons(
                      inputId = "buttons_rebate",
                      label = "Level of increase:",
                      choices = c("Current", "Medium", "Large"),
                      status = "primary", size = 'normal', justified = TRUE), width = NULL),
                  box(title = HTML("<b>Climate Change Projections</b>"), solidHeader = TRUE,
                    "Toggle between current climate conditions, moderate increases in projected temperature increases, and large increases in projected temperature increases", 
                    ticks = FALSE, radioGroupButtons(
                      inputId = "buttons_climate",
                      label = "Level of increase:",
                      choices = c("Current", "Medium", "Large"),
                      status = "primary", size = 'normal', justified = TRUE), width = NULL),
                ),
                column(width = 8,
                  plotlyOutput("plot2", height = 615),
                  box(title = HTML("<b>What is Net Present Value?</b>"), 
                      HTML("<b>Cost-effectiveness</b> is expressed as <b>Net Present Value</b>, or the sum of the benefits minus the costs of a project over the life of a project. For example, a NPV value of 10K means that an average household in that borough will save $10k from installing a heat pump over the life of a heat pump (~14 years)"),
                      collapsible = TRUE, collapsed = TRUE)
                )
              )
      ),
      tabItem(tabName = "sub_env",
              plotlyOutput("plot3")
      ),
      tabItem(tabName = "case",
              h2("Census block visualizations in progress")
      )
    ),
  )
)


server <- function(input, output) {
  
  output$image <- renderImage({
    return(list(src = "/Users/katherinegrisanzio/Desktop/dssg-vis/map_image.png", contentType = "image/png", alt = "picture",
                width = "100%"))
  }, deleteFile = FALSE) 
  
  valuebox1 <- reactive({
    if(input$adoption_button == "Current") {
      valueBox(40.87, "Millions of $ Saved", icon = icon("dollar-sign"), color = 'blue', width=NULL)
    }
    else if (input$adoption_button == "2%"){
      valueBox(113.75, "Millions of $ Saved", icon = icon("dollar-sign"), color = 'blue', width=NULL)
    }
    else if (input$adoption_button == "15%"){
      valueBox(855.48, "Millions of $ Saved", icon = icon("dollar-sign"), color = 'blue', width=NULL)
    }
  })
  
  valuebox2 <- reactive({
    if(input$adoption_button == "Current") {
      valueBox(12.65, "Millions of lbs CO2 Saved", icon = icon("seedling"), color = 'green', width=NULL)
    }
    else if (input$adoption_button == "2%"){
      valueBox(35.79, "Millions of lbs CO2 Saved", icon = icon("seedling"), color = 'green', width=NULL)
    }
    else if (input$adoption_button == "15%"){
      valueBox(258.50, "Millions of lbs CO2 Saved", icon = icon("seedling"), color = 'green', width=NULL)
    }
  })
  
  valuebox3 <- reactive({
    if(input$adoption_button == "Current") {
      valueBox(100, "Thousands of Days of Heat Provided", icon = icon("fire"), color = 'red', width=NULL)
    }
    else if (input$adoption_button == "2%"){
      valueBox(250, "Thousands of Days of Heat Provided", icon = icon("fire"), color = 'red', width=NULL)
    }
    else if (input$adoption_button == "15%"){
      valueBox(800, "Thousands Days of Heat Provided", icon = icon("fire"), color = 'red', width=NULL)
    }
  })
  
  your_plot <- reactive({
    if(input$adoption_button == "Current") {
      current_adoptrate
    }
    else if (input$adoption_button == "2%"){
      two_adoptrate
    }
    else if (input$adoption_button == "15%"){
      fifteen_adoptrate
    }
  })
  
  output$plot1 <- renderPlotly({
    your_plot()
  })
  
  your_plot_borough <- reactive({
    if(input$buttons_fuel == "Current") {
      plotly_npv_base
    }
    else if (input$buttons_fuel == "Medium"){
      plotly_npv_medfuel
    }
    else if (input$buttons_fuel == "Large"){
      plotly_npv_highfuel
    }
  })
  
  output$plot2 <- renderPlotly({
    your_plot_borough()
  })
  
  output$moneysaved <- renderValueBox({
    valuebox1()
  })
  
  output$co2saved <- renderValueBox({
    valuebox2()
  })
  
  output$heatingdays <- renderValueBox({
    valuebox3()
  })
 
   output$plot3 <- renderPlotly({
     plotly_co2
  })
  
}


shinyApp(ui, server)

# https://fontawesome.com/v5/search?q=cash&o=r
# "Box content here", br(), "More box content"



##----TRASH-----



### Figure for 2% HP adoption by borough
cop_df <- read.csv('exploreCOP.csv')
head(merged_basedf)
names(cop_df)[7] <- 'name'
vis_test <- merge(cop_df, merged_basedf, by = 'name')

vis_test_raster <- 
  vis_test %>%
  mutate(name2 = as.integer(factor(name))) %>% # coerce name into integer-factor
  mutate(row = -row) %>%
  dplyr::select(col, row, name2)               # select X, Y (for coords), Z (for value)

vis_test_raster <- rasterFromXYZ(vis_test_raster)       # turn to raster 
vis_test_polygon <- rasterToPolygons(vis_test_raster, dissolve = TRUE)  # turn to polygon 
vis_test_polygonSF <- st_as_sf(vis_test_polygon)                        # turn to sf object


twoperc_plot <- ggplot() +
  geom_tile(data = vis_test, aes(y = -row, x = col, fill = distributed_2p), color = 'white') +
  geom_sf(data = vis_test_polygonSF, size = 1, fill = NA, color = 'black') +
  #scale_fill_gradient(low = "lightblue", high = "darkblue", guide = "legend") +
  scale_fill_viridis_c(option = "B", direction = -1) +
  labs(title = "2% Heat Pump Adoption Adjusted by Feasibility per Borough", fill = 'No. of Installed Heat Pumps') +
  #geom_sf_text(data = merged_grid_npv_polygonSF, aes(label = name2)) +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))


naive_proj_df <- read.csv('naive_projections.csv')
head(naive_proj_df)
names(naive_proj_df)[2] <- 'name'
vistest2 <- merge(naive_proj_df, merged_basedf, by = 'name')
vistest2[which(vistest2$hp_15p_proportion > 1), "hp_15p_proportion"] <- 1

ggplot() +
  geom_tile(data = vistest2, aes(y = -row, x = col, fill = hp_15p), color = 'white') +
  #geom_sf(data = vis_test_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, 3400)) +
  labs(title = "15% Heat Pump Adoption", fill = '# Houses with HP Installed') +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

# current_hp, hp_2p, hp_15p


# Should be only one we need
first_proj <- read.csv('first_projections.csv')
head(first_proj)
names(first_proj)[2] <- 'name'
proj_df <- merge(first_proj, merged_basedf, by = 'name')
proj_df_raster <- 
  proj_df %>%
  mutate(name2 = as.integer(factor(name))) %>% # coerce name into integer-factor
  mutate(row = -row) %>%
  dplyr::select(col, row, name2)               # select X, Y (for coords), Z (for value)

proj_df_raster <- rasterFromXYZ(proj_df_raster)       # turn to raster 
proj_df_polygon <- rasterToPolygons(proj_df_raster, dissolve = TRUE)  # turn to polygon 
proj_df_polygonSF <- st_as_sf(proj_df_polygon)                        # turn to sf object

cur_totalprop <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = current_hp/326200), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, .015)) +
  labs(title = "Current Heat Pump Adoption", fill = 'Prop Houses with HP Installed') +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

p2_totalprop <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_2p_total_prop), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, .015)) +
  labs(title = "2% Projected Heat Pump Adoption", fill = 'Prop Houses with HP Installed') +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

p15_totalprop <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_total_prop), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, .015)) +
  labs(title = "15% Projected Heat Pump Adoption", fill = 'Prop Houses with HP Installed') +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

# Newest csv
fifteen_df <- read.csv('15percent_adoption_scenarios.csv')
names(fifteen_df)[2] <- 'name'
proj_df <- merge(fifteen_df, merged_basedf, by = 'name')
proj_df_raster <- 
  proj_df %>%
  mutate(name2 = as.integer(factor(name))) %>% # coerce name into integer-factor
  mutate(row = -row) %>%
  dplyr::select(col, row, name2)               # select X, Y (for coords), Z (for value)

proj_df_raster <- rasterFromXYZ(proj_df_raster)       # turn to raster 
proj_df_polygon <- rasterToPolygons(proj_df_raster, dissolve = TRUE)  # turn to polygon 
proj_df_polygonSF <- st_as_sf(proj_df_polygon)                        # turn to sf object

hp_15p_r1 <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r1), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(100, 5000)) +
  #labs(title = "hp_15p_r1") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_r2 <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r2), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(100, 5000)) + 
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_norm <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_norm), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(100, 5000)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(hp_15p_r1, hp_15p_r2, hp_15p_norm, nrow = 1)


hp_15p_r1_prop <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r1_prop), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, .015)) +
  #labs(title = "hp_15p_r1") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_r2_prop <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r2_prop), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, .015)) + 
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_norm_prop <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_norm_prop), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, .015)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(hp_15p_r1_prop, hp_15p_r2_prop, hp_15p_norm_prop, nrow = 1)


hp_15p_r1_prop_b <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r1_prop_b), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, 1)) +
  #labs(title = "hp_15p_r1") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_r2_prop_b <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r2_prop_b), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, 1)) + 
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_norm_prop_b <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_norm_prop_b), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, 1)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(hp_15p_r1_prop_b, hp_15p_r2_prop_b, hp_15p_norm_prop_b, nrow = 1)


#hp_15p_r1, hp_15p_r2, hp_15p_norm
#absolute numbers

#_prop all go together
#_propb all go together

# Newest
first_proj <- read.csv('15percent_adoption_scenarios_by_npv.csv')
head(first_proj)
names(first_proj)[2] <- 'name'
proj_df <- merge(first_proj, merged_basedf, by = 'name')
proj_df_raster <- 
  proj_df %>%
  mutate(name2 = as.integer(factor(name))) %>% # coerce name into integer-factor
  mutate(row = -row) %>%
  dplyr::select(col, row, name2)               # select X, Y (for coords), Z (for value)

proj_df_raster <- rasterFromXYZ(proj_df_raster)       # turn to raster 
proj_df_polygon <- rasterToPolygons(proj_df_raster, dissolve = TRUE)  # turn to polygon 
proj_df_polygonSF <- st_as_sf(proj_df_polygon)                        # turn to sf object

hp_15p_r1_npv_prop_b <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r1_npv_prop_b), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, 1)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_r2_npv_prop_b <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r2_npv_prop_b), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, 1)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_norm_npv_prop_b <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_norm_npv_prop_b), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, 1)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(hp_15p_r1_npv_prop_b, hp_15p_r2_npv_prop_b, hp_15p_norm_npv_prop_b, nrow = 1)


hp_15p_r1_npv_prop <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r1_npv_prop), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, .015)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_r2_npv_prop <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r2_npv_prop), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, .015)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_norm_npv_prop <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_norm_npv_prop), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, .015)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(hp_15p_r1_npv_prop, hp_15p_r2_npv_prop, hp_15p_norm_npv_prop, nrow = 1)


hp_15p_r1_npv <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r1_npv), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(100, 5000)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_r2_npv <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r2_npv), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(100, 5000)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_norm_npv <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_norm_npv), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(100, 5000)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(hp_15p_r1_npv, hp_15p_r2_npv, hp_15p_norm_npv, nrow = 1)


# Newest
first_proj <- read.csv('15percent_adoption_scenarios_by_cop_max_50p_sat.csv')
head(first_proj)
names(first_proj)[2] <- 'name'
proj_df <- merge(first_proj, merged_basedf, by = 'name')
proj_df_raster <- 
  proj_df %>%
  mutate(name2 = as.integer(factor(name))) %>% # coerce name into integer-factor
  mutate(row = -row) %>%
  dplyr::select(col, row, name2)               # select X, Y (for coords), Z (for value)

proj_df_raster <- rasterFromXYZ(proj_df_raster)       # turn to raster 
proj_df_polygon <- rasterToPolygons(proj_df_raster, dissolve = TRUE)  # turn to polygon 
proj_df_polygonSF <- st_as_sf(proj_df_polygon)                        # turn to sf object

hp_15p_r1_50 <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r1_50), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(100, 8000)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_r2_50 <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r2_50), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(100, 8000)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_norm_50 <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_norm_50), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(100, 8000)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(hp_15p_r1_50, hp_15p_r2_50, hp_15p_norm_50, nrow = 1)


hp_15p_r1_50_prop <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r1_50_prop), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, .022)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_r2_50_prop <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r2_50_prop), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, .022)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_norm_50_prop <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_norm_50_prop), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0, .022)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(hp_15p_r1_50_prop, hp_15p_r2_50_prop, hp_15p_norm_50_prop, nrow = 1)


hp_15p_r1_50_prop_b <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r1_50_prop_b), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0,.5)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_r2_50_prop_b <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r2_50_prop_b), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0,.5)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_norm_50_prop_b <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_norm_50_prop_b), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0,.5)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(hp_15p_r1_50_prop_b, hp_15p_r2_50_prop_b, hp_15p_norm_50_prop_b, nrow = 1)


# Newest
first_proj <- read.csv('15percent_adoption_scenarios_by_cop_and_pop_max_50p_sat.csv')
head(first_proj)
names(first_proj)[2] <- 'name'
proj_df <- merge(first_proj, merged_basedf, by = 'name')
proj_df_raster <- 
  proj_df %>%
  mutate(name2 = as.integer(factor(name))) %>% # coerce name into integer-factor
  mutate(row = -row) %>%
  dplyr::select(col, row, name2)               # select X, Y (for coords), Z (for value)

proj_df_raster <- rasterFromXYZ(proj_df_raster)       # turn to raster 
proj_df_polygon <- rasterToPolygons(proj_df_raster, dissolve = TRUE)  # turn to polygon 
proj_df_polygonSF <- st_as_sf(proj_df_polygon)                        # turn to sf object


hp_15p_r1_50 <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r1_50), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(100, 8000)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_r2_50 <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r2_50), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(100, 8000)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(hp_15p_r1_50, hp_15p_r2_50, nrow = 1)

hp_15p_r1_50_prop_b <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r1_50_prop_b), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0,.5)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

hp_15p_r2_50_prop_b <- ggplot() +
  geom_tile(data = proj_df, aes(y = -row, x = col, fill = hp_15p_r2_50_prop_b), color = 'white') +
  geom_sf(data = proj_df_polygonSF, size = 1, fill = NA, color = 'black') +
  scale_fill_viridis_c(option = "B", direction = -1, limits = c(0,.5)) +
  #labs(title = "hp_15p_r2") +
  theme_void(base_size = 16) +
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(hp_15p_r1_50_prop_b, hp_15p_r2_50_prop_b, nrow = 1)


# Actual plots- hp_current, hp_2p_r1_50, hp_15p_r1_50
# hp_2p_r1_50_prop_b, hp_15p_r1_50_prop_b




# Shiny
ui <- fluidPage(
  plotlyOutput("graph")
)


server <- shinyServer(function(input, output, session) {
  
  your_plot <- reactive({
    if(input$PlotChoice == "Base Scenario") {
      plot(g)
    }
    else if (input$PlotChoice == "Medium Fuel Price Increases"){
      plot(g1)
    }
    else if (input$PlotChoice == "High Fuel Price Increases"){
      plot(g2)
    }
  })
  
  output$SelectedPlot <- renderPlot({ 
    your_plot()
  })
  
})


ui <-  shinyUI(fluidPage(
  navbarPage(title=" ",
             tabPanel("Economic Feasibility",
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons("PlotChoice", "Displayed plot:", 
                                       choices = c("Base Scenario", "Medium Fuel Price Increases", "High Fuel Price Increases"))),
                        mainPanel(plotOutput("SelectedPlot")))))
  ,  fluid=TRUE))

shinyApp(ui=ui, server=server)


# Interactive plots

server <- shinyServer(function(input, output, session) {
  
  your_plot <- reactive({
    if(input$PlotChoice == "Base Scenario") {
      g_int
    }
    else if (input$PlotChoice == "Medium Fuel Price Increases"){
      g1_int
    }
    else if (input$PlotChoice == "High Fuel Price Increases"){
      g2_int
    }
  })
  
  output$SelectedPlot <- renderPlotly({ 
    your_plot()
  })
  
})


ui <-  shinyUI(fluidPage(
  navbarPage(title="",
             tabPanel("Economic Feasibility",
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons("PlotChoice", "Displayed plot:", 
                                       choices = c("Base Scenario", "Medium Fuel Price Increases", "High Fuel Price Increases"))),
                        mainPanel(plotlyOutput("SelectedPlot")))))
  ,  fluid=TRUE))

shinyApp(ui=ui, server=server)


# Multiple panels

ui <-  shinyUI(fluidPage(
  navbarPage(title="",
             tabPanel("Economic Feasibility",
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons("PlotChoice1", "Displayed plot:", 
                                       choices = c("Base Scenario", "Medium Fuel Price Increases", "High Fuel Price Increases"))),
                        mainPanel(plotlyOutput("SelectedPlot1")))),
             tabPanel("Greenness",
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons("PlotChoice2", "Displayed plot:", 
                                       choices = c("Base Scenario", "Medium Fuel Price Increases", "High Fuel Price Increases"))),
                        mainPanel(plotlyOutput("SelectedPlot2")))),
             tabPanel("Technical Feasibility",
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons("PlotChoice3", "Displayed plot:", 
                                       choices = c("Base Scenario", "Medium Fuel Price Increases", "High Fuel Price Increases"))),
                        mainPanel(plotlyOutput("SelectedPlot3")))))
  ,  fluid=TRUE))

server <- shinyServer(function(input, output, session) {
  
  your_plot1 <- reactive({
    if(input$PlotChoice1 == "Base Scenario") {
      g_int
    }
    else if (input$PlotChoice1 == "Medium Fuel Price Increases"){
      g1_int
    }
    else if (input$PlotChoice1 == "High Fuel Price Increases"){
      g2_int
    }
  })
  
  your_plot2 <- reactive({
    if(input$PlotChoice2 == "Base Scenario") {
      g_int
    }
    else if (input$PlotChoice2 == "Medium Fuel Price Increases"){
      g1_int
    }
    else if (input$PlotChoice2 == "High Fuel Price Increases"){
      g2_int
    }
  })
  
  your_plot3 <- reactive({
    if(input$PlotChoice3 == "Base Scenario") {
      g_int
    }
    else if (input$PlotChoice3 == "Medium Fuel Price Increases"){
      g1_int
    }
    else if (input$PlotChoice3 == "High Fuel Price Increases"){
      g2_int
    }
  })
  
  output$SelectedPlot1 <- renderPlotly({ 
    your_plot1()
  })
  
  output$SelectedPlot2 <- renderPlotly({ 
    your_plot2()
  })
  
  output$SelectedPlot3 <- renderPlotly({ 
    your_plot3()
  })
})

shinyApp(ui=ui, server=server)


# Sliders instead of buttons

ui <-  shinyUI(fluidPage(
  navbarPage(title="",
             tabPanel("Economic Feasibility",
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("PlotChoice1", "Predicted Fuel Price Increases: Baseline----------Medium----------High", 
                                      min = 1, max = 3, value = 1, step = 1),
                          sliderInput("PlotChoice1a", "Predicted Rebate Amounts:",
                                      min = 1, max = 3, value = 1, step = 1),
                          sliderInput("PlotChoice1b", "Predicted Global Warming:",
                                      min = 1, max = 3, value = 1, step = 1)),
                        mainPanel(plotlyOutput("SelectedPlot1")))),
             tabPanel("Greenness",
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("PlotChoice2", "Predicted Fuel Price Increases: Baseline----------Medium----------High", 
                                      min = 1, max = 3, value = 1, step = 1),
                          sliderInput("PlotChoice2a", "Predicted Rebate Amounts:",
                                      min = 1, max = 3, value = 1, step = 1),
                          sliderInput("PlotChoice2b", "Predicted Global Warming:",
                                      min = 1, max = 3, value = 1, step = 1)),
                        mainPanel(plotlyOutput("SelectedPlot2")))),
             tabPanel("Technical Feasibility",
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("PlotChoice3", "Predicted Fuel Price Increases: Baseline----------Medium----------High", 
                                      min = 1, max = 3, value = 1, step = 1),
                          sliderInput("PlotChoice3a", "Predicted Rebate Amounts:",
                                      min = 1, max = 3, value = 1, step = 1),
                          sliderInput("PlotChoice3b", "Predicted Global Warming:",
                                      min = 1, max = 3, value = 1, step = 1)),
                        mainPanel(plotlyOutput("SelectedPlot3")))))
  ,  fluid=TRUE))

server <- shinyServer(function(input, output, session) {
  
  your_plot1 <- reactive({
    if(input$PlotChoice1 == 1) {
      g_int
    }
    else if (input$PlotChoice1 == 2){
      g1_int
    }
    else if (input$PlotChoice1 == 3){
      g2_int
    }
  })
  
  your_plot2 <- reactive({
    if(input$PlotChoice2 == 1) {
      g_int
    }
    else if (input$PlotChoice2 == 2){
      g1_int
    }
    else if (input$PlotChoice2 == 3){
      g2_int
    }
  })
  
  your_plot3 <- reactive({
    if(input$PlotChoice3 == 1) {
      g_int
    }
    else if (input$PlotChoice3 == 2){
      g1_int
    }
    else if (input$PlotChoice3 == 3){
      g2_int
    }
  })
  
  output$SelectedPlot1 <- renderPlotly({ 
    your_plot1()
  })
  
  output$SelectedPlot2 <- renderPlotly({ 
    your_plot2()
  })
  
  output$SelectedPlot3 <- renderPlotly({ 
    your_plot3()
  })
})

shinyApp(ui=ui, server=server)



