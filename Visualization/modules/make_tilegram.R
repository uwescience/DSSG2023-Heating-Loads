require(geofacet)

##### Generate tilegrams for each borough
## Define panhandle grids
ketch_grid <- data.frame(
  code = c("ketch1", "ketch2", "ketch6", "ketch5", "ketch4", "ketch3", "ketch19", "ketch9", "ketch8", "ketch7", "ketch10", "ketch14", "ketch13", "ketch12", "ketch11", "ketch15", "ketch16", "ketch18", "ketch17"),
  row = c(1, 1, 2, 2, 2, 2, 6, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 6, 6),
  col = c(2, 3, 4, 3, 2, 1, 5, 4, 3, 2, 5, 5, 4, 3, 2, 4, 5, 4, 3),
  stringsAsFactors = FALSE
)

prince_grid <- data.frame(
  code = c("prince1", "prince3", "prince2", "prince6", "prince5", "prince4", "prince8", "prince7"),
  row = c(1, 2, 2, 3, 3, 3, 4, 4),
  col = c(2, 2, 1, 4, 3, 2, 3, 2),
  stringsAsFactors = FALSE
)

sitka_grid <- data.frame(
  code = c("sitka1", "sitka2", "sitka3", "sitka4", "sitka5", "sitka6", "sitka7", "sitka8", "sitka9", "sitka11", "sitka12", "sitka10"),
  row = c(1, 1, 2, 2, 3, 3, 3, 4, 4, 5, 5, 4),
  col = c(1, 2, 1, 2, 1, 2, 3, 1, 2, 2, 3, 3),
  stringsAsFactors = FALSE
)

wrangell_grid <- data.frame(
  code = c("wrang1", "wrang2", "wrang3"),
  row = c(1, 1, 2),
  col = c(1, 2, 2),
  stringsAsFactors = FALSE
)

peter_grid <- data.frame(
  code = c("peter1", "peter2", "peter4", "peter3"),
  row = c(1, 1, 2, 2),
  col = c(1, 2, 2, 1),
  stringsAsFactors = FALSE
)

juneau_grid <- data.frame(
  code = c("juneau1", "juneau2", "juneau3", "juneau4", "juneau5", "juneau6", "juneau7", "juneau8", "juneau9", "juneau10", "juneau11", "juneau12", "juneau19", "juneau13", "juneau14", "juneau15", "juneau16", "juneau17", "juneau18", "juneau20", "juneau21", "juneau22", "juneau23", "juneau24", "juneau25", "juneau26", "juneau27", "juneau30", "juneau29", "juneau28", "juneau31", "juneau32", "juneau33", "juneau34", "juneau35", "juneau39", "juneau38", "juneau37", "juneau36", "juneau42", "juneau40", "juneau41", "juneau43", "juneau44"),
  row = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8),
  col = c(1, 2, 3, 4, 5, 2, 3, 4, 5, 6, 7, 8, 9, 3, 4, 5, 6, 7, 8, 3, 4, 5, 6, 7, 8, 9, 10, 5, 4, 3, 6, 7, 8, 9, 10, 8, 7, 6, 5, 7, 5, 6, 8, 6),
  stringsAsFactors = FALSE
)

skagway_grid <- data.frame(
  code = c("skag1", "skag2"),
  row = c(1, 2),
  col = c(1, 1),
  stringsAsFactors = FALSE
)

haines_grid <- data.frame(
  code = c("haines1", "haines2", "haines3"),
  row = c(1, 1, 2),
  col = c(1, 2, 2),
  stringsAsFactors = FALSE
)

hoon_grid <- data.frame(
  code = c("hoon1", "hoon3", "hoon2"),
  row = c(1, 2, 2),
  col = c(1, 2, 1),
  stringsAsFactors = FALSE
)

yakutat_grid <- data.frame(
  code = c("yakutat1"),
  row = c(1),
  col = c(1),
  stringsAsFactors = FALSE
)

valdez_grid <- data.frame(
  code = c("valdez1", "valdez5", "valdez4", "valdez3", "valdez2", "valdez10", "valdez9", "valdez8", "valdez7", "valdez6", "valdez11", "valdez13", "valdez12"),
  row = c(1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4),
  col = c(3, 5, 4, 3, 2, 5, 4, 3, 2, 1, 1, 3, 2),
  stringsAsFactors = FALSE
)

## Rename the panhandle grids
ketch_grid$name <- "Ketchikan Gateway Borough"
prince_grid$name <- "Prince of Wales-Hyder Census Area"
sitka_grid$name <- "Sitka City and Borough"
wrangell_grid$name <- "Wrangell City and Borough"
peter_grid$name <- "Petersburg Borough"
juneau_grid$name <- "Juneau City and Borough"
skagway_grid$name <- "Skagway Municipality"
haines_grid$name <- "Haines Borough"
hoon_grid$name <- "Hoonah-Angoon Census Area"
yakutat_grid$name <- "Yakutat City and Borough"
valdez_grid$name <- "Valdez-Cordova Census Area"

## Adjust location of each grid, with Ketchikan as reference
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

## Stack all grids on top of each other
panhandle_grids <- rbind(ketch_grid, prince_grid, sitka_grid, wrangell_grid, peter_grid,
                         juneau_grid, skagway_grid, haines_grid, hoon_grid, yakutat_grid, 
                         valdez_grid) 

## Make all coordinates positive
min(panhandle_grids$row)
min(panhandle_grids$col)
panhandle_grids$row <- panhandle_grids$row + 11
panhandle_grids$col <- panhandle_grids$col + 12

## Optional - view resulting panhandle grid
# geofacet::grid_preview(panhandle_grids)

### Non-panhandle
nwa_grid <- data.frame(
  code = c("NWA1", "NWA2", "NWA3", "NWA4", "NWA5", "NWA6", "NWA7", "NWA8", "NWA9", "NWA10", "NWA11"),
  row = c(1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3),
  col = c(2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4),
  stringsAsFactors = FALSE
)

northslope_grid <- data.frame(
  code = c("NS1", "NS2", "NS3", "NS4", "NS5", "NS6", "NS7", "NS8", "NS9", "NS10", "NS11", "NS12", "NS13", "NS14"),
  row = c(1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3),
  col = c(2, 3, 4, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4, 5),
  stringsAsFactors = FALSE
)

nome_grid <- data.frame(
  code = c("No1", "No2", "No3", "No4", "No5", "No6", "No7", "No8", "No9", "No10", "No11", "No12", "No13"),
  row = c(1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4),
  col = c(2, 3, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 5),
  stringsAsFactors = FALSE
)

yukon_grid <- data.frame(
  code = c("YY1", "YY2", "YY3", "YY4", "YY5", "YY6", "YY7"),
  row = c(1, 1, 1, 1, 2, 2, 2),
  col = c(3, 4, 5, 6, 1, 2, 3),
  stringsAsFactors = FALSE
)

denali_grid <- data.frame(
  code = c("De1", "De2", "De3"),
  row = c(1, 2, 3),
  col = c(1, 1, 1),
  stringsAsFactors = FALSE
)

matanuska_grid <- data.frame(
  code = c("MS1", "MS2", "MS3", "MS4", "MS5", "MS6", "MS7", "MS8", "MS9", "MS10", "MS11", "MS12", "MS13", "MS14", "MS15", "MS16", "MS17", "MS18", "MS19", "MS20", "MS21", "MS22", "MS23", "MS24", "MS25", "MS26", "MS27", "MS28", "MS29", "MS30", "MS31", "MS32", "MS33", "MS34", "MS35", "MS36", "MS37", "MS38", "MS39", "MS41", "MS42", "MS43", "MS44", "MS45", "MS46", "MS47", "MS48", "MS49", "MS56", "MS40", "MS50", "MS51", "MS52", "MS53", "MS54", "MS55", "MS57", "MS58", "MS59", "MS60", "MS61", "MS62", "MS63", "MS64", "MS65", "MS66", "MS67", "MS68", "MS69", "MS70", "MS71", "MS73", "MS74", "MS75", "MS76", "MS77", "MS78", "MS79", "MS80", "MS81", "MS72", "MS82", "MS83", "MS84", "MS85", "MS86", "MS87", "MS89", "MS90", "MS91", "MS92", "MS93", "MS94", "MS88", "MS95", "MS96", "MS97", "MS98", "MS99", "MS100", "MS102", "MS103", "MS104", "MS105", "MS101", "MS106", "MS107", "MS108", "MS109", "MS110", "MS111", "MS113", "MS114", "MS115", "MS112", "MS116", "MS117", "MS118", "MS119", "MS120", "MS121", "MS123", "MS124", "MS122", "MS125", "MS126", "MS127", "MS128", "MS129", "MS130", "MS132", "MS133", "MS134", "MS135", "MS136", "MS137", "MS138", "MS139", "MS140", "MS141", "MS142", "MS143", "MS144", "MS145", "MS146"),
  row = c(1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 12, 12, 12, 12, 12, 12, 12, 12, 13, 13, 13, 13, 13, 13, 13, 14, 14, 14, 14, 14, 14),
  col = c(13, 14, 15, 9, 10, 11, 12, 13, 14, 15, 16, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 7, 7, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 7, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 7, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 7, 1, 2, 3, 4, 5, 6, 8, 9, 10, 7, 1, 2, 3, 4, 5, 6, 8, 9, 7, 1, 2, 3, 4, 5, 6, 8, 7, 1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4, 5, 6),
  stringsAsFactors = FALSE
)

fairbanks_grid <- data.frame(
  code = c("FB1", "FB2", "FB3", "FB4", "FB5", "FB6", "FB7", "FB8", "FB9", "FB10", "FB11", "FB12", "FB13", "FB14", "FB15", "FB16", "FB17", "FB18", "FB19", "FB20", "FB21", "FB22", "FB23", "FB24", "FB25", "FB26", "FB27", "FB28", "FB29", "FB30", "FB31", "FB32", "FB33", "FB34", "FB35", "FB36", "FB37", "FB38", "FB39", "FB40", "FB41", "FB42", "FB43", "FB44", "FB45", "FB46", "FB47", "FB48", "FB49", "FB50", "FB51", "FB52", "FB53", "FB54", "FB55", "FB56", "FB57", "FB58", "FB59", "FB60", "FB61", "FB62", "FB63", "FB64", "FB65", "FB66", "FB67", "FB68", "FB69", "FB70", "FB71", "FB72", "FB73", "FB74", "FB75", "FB76", "FB77", "FB78", "FB79", "FB80", "FB81", "FB82", "FB83", "FB84", "FB85", "FB86", "FB87", "FB88", "FB89", "FB90", "FB91", "FB92", "FB93", "FB94", "FB95", "FB96", "FB97", "FB98", "FB99", "FB100", "FB101", "FB102", "FB103", "FB104", "FB105", "FB106", "FB107", "FB108", "FB109", "FB110", "FB111", "FB112", "FB113", "FB114", "FB115", "FB116", "FB117", "FB118", "FB119", "FB120", "FB121", "FB122", "FB123", "FB124", "FB125", "FB126", "FB127", "FB128", "FB129", "FB130", "FB131"),
  row = c(1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11),
  col = c(8, 9, 7, 8, 9, 4, 5, 6, 7, 8, 9, 10, 11, 14, 15, 16, 17, 18, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 2, 3, 4, 5, 6, 7, 8, 9, 10, 2, 3, 4, 5, 6, 7, 8, 9),
  stringsAsFactors = FALSE
)

sefairbanks_grid <- data.frame(
  code = c("SFB1", "SFB2", "SFB3", "SFB4", "SFB5", "SFB6", "SFB7", "SFB8", "SFB9"),
  row = c(1, 2, 2, 2, 3, 3, 3, 3, 4),
  col = c(4, 2, 3, 4, 1, 2, 3, 4, 4),
  stringsAsFactors = FALSE
)

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

kenai_grid <- data.frame(
  code = c("KP1", "KP2", "KP3", "KP4", "KP5", "KP6", "KP7", "KP8", "KP9", "KP10", "KP11", "KP12", "KP13", "KP14", "KP15", "KP16", "KP17", "KP18", "KP19", "KP20", "KP21", "KP22", "KP23", "KP24", "KP25", "KP26", "KP27", "KP28", "KP29", "KP30", "KP31", "KP32", "KP33", "KP34", "KP35", "KP36", "KP37", "KP38", "KP39", "KP40", "KP41", "KP42", "KP43", "KP44", "KP45", "KP46", "KP47", "KP48", "KP49", "KP50", "KP51", "KP52", "KP53", "KP54", "KP55", "KP56", "KP57", "KP58", "KP59", "KP60", "KP61", "KP62", "KP63", "KP64", "KP65", "KP66", "KP67", "KP68", "KP69", "KP70", "KP71", "KP72", "KP73", "KP74", "KP75", "KP76", "KP77", "KP78", "KP79", "KP80"),
  row = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10),
  col = c(4, 5, 6, 7, 8, 4, 5, 6, 7, 8, 9, 10, 11, 4, 5, 6, 7, 8, 9, 10, 11, 12, 4, 5, 6, 7, 8, 9, 10, 11, 12, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4),
  stringsAsFactors = FALSE
)

kusilvak_grid <- data.frame(
  code = c("Ku1", "Ku2", "Ku3", "Ku4", "Ku5", "Ku6", "Ku7", "Ku8", "Ku9", "Ku10", "Ku11"),
  row = c(1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3),
  col = c(2, 3, 4, 2, 3, 4, 5, 1, 2, 3, 4),
  stringsAsFactors = FALSE
)

bethel_grid <- data.frame(
  code = c("Be1", "Be2", "Be3", "Be4", "Be5", "Be6", "Be7", "Be8", "Be9", "Be10", "Be11", "Be12", "Be13", "Be14", "Be15", "Be16", "Be17", "Be18", "Be19", "Be20", "Be21", "Be22", "Be23", "Be24", "Be25"),
  row = c(1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 5),
  col = c(6, 7, 8, 9, 10, 11, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 2, 3, 4, 5, 6, 4, 5, 4),
  stringsAsFactors = FALSE
)

dillingham_grid <- data.frame(
  code = c("Di1", "Di2", "Di3", "Di4", "Di5", "Di6", "Di7"),
  row = c(1, 1, 2, 2, 2, 3, 3),
  col = c(3, 4, 2, 3, 4, 1, 2),
  stringsAsFactors = FALSE
)

bristol_grid <- data.frame(
  code = c("BB1"),
  row = c(1),
  col = c(1),
  stringsAsFactors = FALSE
)

lake_grid <- data.frame(
  code = c("LP1", "LP2"),
  row = c(1, 2),
  col = c(1, 1),
  stringsAsFactors = FALSE
)

ale_east_grid <- data.frame(
  code = c("AE1", "AE2", "AE3", "AE4"),
  row = c(1, 1, 2, 2),
  col = c(2, 3, 1, 2),
  stringsAsFactors = FALSE
)

ale_west_grid <- data.frame(
  code = c("AW1", "AW2", "AW3", "AW4", "AW5", "AW6", "AW7", "AW8"),
  row = c(1, 1, 2, 2, 2, 2, 2, 2),
  col = c(6, 7, 1, 2, 3, 4, 5, 6),
  stringsAsFactors = FALSE
)

kodiak_grid <- data.frame(
  code = c("KI1", "KI2", "KI3", "KI4", "KI5", "KI6", "KI7", "KI8", "KI9", "KI10", "KI11", "KI12", "KI13", "KI14", "KI15", "KI16", "KI17", "KI18"),
  row = c(1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 7),
  col = c(5, 4, 5, 6, 3, 4, 5, 2, 3, 4, 5, 1, 2, 3, 4, 2, 3, 2),
  stringsAsFactors = FALSE
)

## Rename non-panhandle grids
nwa_grid$name <- "Northwest Arctic Borough"
northslope_grid$name <- "North Slope Borough"
nome_grid$name <- "Nome Census Area"
yukon_grid$name <- "Yukon-Koyukuk Census Area"
denali_grid$name <- "Denali Borough"
matanuska_grid$name <- "Matanuska-Susitna Borough"
fairbanks_grid$name <- "Fairbanks North Star Borough"
sefairbanks_grid$name <- "Southeast Fairbanks Census Area"
anchorage_grid$name <- "Anchorage Municipality"
kenai_grid$name <- "Kenai Peninsula Borough"
kusilvak_grid$name <- "Kusilvak Census Area"
bethel_grid$name <- "Bethel Census Area"
dillingham_grid$name <- "Dillingham Census Area"
bristol_grid$name <- "Bristol Bay Borough"
lake_grid$name <- "Lake and Peninsula Borough"
ale_east_grid$name <- "Aleutians East Borough"
ale_west_grid$name <- "Aleutians West Census Area"
kodiak_grid$name <- "Kodiak Island Borough"

## Adjust location of each grid, with panhandle_grids as reference
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

## Stack all grids on top of each other
all_grids <- rbind(panhandle_grids, 
                   anchorage_grid, kenai_grid, fairbanks_grid, sefairbanks_grid, denali_grid, 
                   yukon_grid, northslope_grid, nwa_grid, nome_grid, matanuska_grid,
                   kusilvak_grid, bethel_grid, dillingham_grid, bristol_grid, lake_grid,
                   ale_east_grid, ale_west_grid, kodiak_grid)

## Make all coordinates positive
min(all_grids$row)
min(all_grids$col)
all_grids$row <- all_grids$row + 23
all_grids$col <- all_grids$col + 34

## View resulting grid
geofacet::grid_preview(all_grids)



