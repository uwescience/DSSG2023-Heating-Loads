require(fresh)

mytheme <- create_theme(
  adminlte_color(
    light_blue = "#0F204B"
  ),
  adminlte_sidebar(
    width = "275px",
    dark_bg = "#D8DEE9",
    dark_hover_bg = "#FFB612",
    #dark_hover_bg = "#81A1C1",
    dark_color = "#0F204B",
    dark_hover_color = "#0F204B",
    dark_submenu_color = "#0F204B",
    dark_submenu_hover_color = "#FFB612"
  ),
  adminlte_global(
    content_bg = "#FFF",
    box_bg = "#D8DEE9", 
    info_box_bg = "#D8DEE9"
  )
)