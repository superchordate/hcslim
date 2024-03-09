#' View hcslim result in viewer. (Deprecated, replaced with hc_widget)
#' 
#' Allows viewing of hcslim output in RStudio. 
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param class "chart" in Highcharts.chart(... For Highmaps, it should be "mapChart".
#' @param usecode_include Required Highcharts modules that you'd pass to hcslim::usecode().
#' @param loadmapfromurl If you are using a map, this is the URL of the topo.json file. Example: 'https://code.highcharts.com/mapdata/countries/us/us-ca-all.topo.json'
#' @param pretty Use pretty formatting when converting options to JSON.
#' @param printjs Print completed JS to console for troubleshooting or pasting into jsFiddle.
#' @param printtempfile Print the location of the temporary HTML file (helpful for troubleshooting).
#' @param printhtml Print the HTML code used for Viewer (helpful for troubleshooting).
#'
#' @return Creates a temp HTML file and shows it in the viewer. 
#' @export
#'
#' @examples
#' \dontrun{
#'
#'require(hcslim)
#'
#'options = list(
#'  chart = list(type = 'line'),
#'  title = list(text = 'Some Numbers'),
#'  yAxis = list(
#'      title = list(
#'          text = '123456'
#'      )
#'  ),
#'  series = list(
#'      list(
#'        name = '123',
#'        data = c(1, 2, 3)
#'      ),
#'      list(
#'        name = '456',
#'        data = c(4, 5, 6)
#'      )
#'  )
#')
#'
#'hcslim_view(options)
#'
#' }
hc_view = function(
    
    options, 
    class = c('chart', 'mapChart', 'stockChart', 'ganttChart'),
    usecode_include = ifelse(class[1] == 'mapChart', 'maps/highmaps', 'highcharts'),
    loadmapfromurl = NULL,
    pretty = printjs,

    # debug options: 
    printjs = FALSE, 
    printtempfile = FALSE,
    printhtml = FALSE

){
  
  # get a temp file and use it to build a div id.
  tempfile = tempfile(fileext = ".html")
  if(printtempfile) print(tempfile)
  id = gsub('[.]html', '', gsub('.+\\\\', '', tempfile))
  
  # build the chart from options, and the module import.
  toview = list(
    hc_use(usecode_include),
    hc_html(
      id = id, 
      options = options, 
      class = class, 
      loadmapfromurl = loadmapfromurl,
      printjs = printjs, 
      pretty = pretty
    )
  )
  toview = unlist(toview)
  
  # write the temporary file.
  fileConn = file(tempfile)
  html = c(glue::glue('<div id="{id}"></div>'), toview)
  if(printhtml) print(html)
  writeLines(html, fileConn)
  close(fileConn)
  
  # open the viewer.
  viewer = getOption("viewer")
  viewer(tempfile)
  print(tempfile)
  
}

