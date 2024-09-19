#' hc_use
#'
#' Helper to import Highcharts files from a CDN. 
#' See https://github.com/superchordate/hcslim for more detailed documentation and examples. 
#' 
#' Author: Bryce Chamberlain
#'
#' @param maps Indicate if maps are needed.
#' @param hc_paths Relative paths indicating which files to gather. Usually you can ignore this, the defaults should work. You may want to only send "highcharts" if you are running offline (Quarto, RMarkdown, RStudio).
#'
#' @return List of HTML script import snippets to gather files from the CDN.
#' @export
hc_use = function(
  maps = FALSE, 
  hc_paths = c(
    ifelse(maps, 'maps/highmaps', 'highcharts'), 
    'modules/accessibility', 'highcharts-more', 'modules/exporting'
)){
  lapply(
    hc_paths,
    function(module) htmltools::HTML(as.character(
      paste0('<script src="https://code.highcharts.com/', module, '.js"></script>')
    ))
  )
}
