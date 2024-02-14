# see https://github.com/superchordate/hcslim for more detailed documentation and examples. 

hc_use = function(hc_paths = c('highcharts', 'modules/accessibility', 'highcharts-more', 'modules/exporting')) lapply(
  hc_paths,
  function(module) htmltools::HTML(as.character(
    glue::glue('<script src="https://code.highcharts.com/{module}.js"></script>')
  ))
)