if (!require(pacman, quietly = TRUE)) {
  install.packages("pacman")
  library(pacman)
}

p_load("magrittr", "tidyverse", "pins", "todor", "cli")

options(todor_extra = c("qmd", "md", "txt", "r", "py"))
dotenv::load_dot_env(".env")

p_load_gh("MarcellGranat/granatlib")
p_load_gh("MarcellGranat/ggProfessional")
set_palette("blind", attach = TRUE)

if (is.null(knitr::pandoc_to())) {
  # only in RStudio (for coding, but not for the resulted output)
  p_load("ggdark")
  theme_set(
    dark_theme_minimal() +
      theme(
        plot.background = element_rect(fill = "#161616", color = "#161616"),
        panel.border = element_blank(),
        panel.grid.major = element_line(color = "grey25"),
        panel.grid.minor = element_line(color = "grey25"),
        legend.position = "bottom",
        plot.title.position = "plot",
        plot.title = element_text(face = "bold", hjust = .5),
        plot.tag.position = "topright",
        plot.caption.position = "plot",
        legend.key = element_blank(),
        legend.box = "vertical"
      )
  )
}

walk(list.files("R", full.names = TRUE), source)

.p <- function(name = "") {
  # nicely formatted progress line for `map()`
  list(
    clear = FALSE,
    name = name,
    format = paste0(
      "\033[35m {pb_spin}\033[39m \033[1m\033[34m", name,
      "\033[39m\033[22m [{pb_current}/{pb_total}]  ETA: {pb_eta}"
    ),
    format_done = paste0(
      "{col_green(symbol$tick)} All done \033[90m[{pb_total}]\033[39m ",
      "in {pb_elapsed}. ", "\033[35m", Sys.time(), "\033[39m"
    ),
    format_failed = paste0(
      "{col_red(symbol$cross)} Failed at index {pb_current} ",
      "in {pb_elapsed}. ", "\033[35m", Sys.time(), "\033[39m"
    )
  )
}

cli_div(theme = list(
  span.b = list(color = "blue", "font-weight" = "bold"),
  span.c = list(color = "cyan", "font-weight" = "bold"),
  span.g = list(color = "green", "font-weight" = "bold"),
  span.r = list(color = "red", "font-weight" = "bold"),
  span.s = list(color = "silver", before = "[", after = "]"), # progress infos
  span.m = list(color = "magenta") # additional infos
))
