#' View hcslim result in viewer. 
#' 
#' Allows viewing of hcslim output in RStudio. 
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param usecode_include Required Highcharts modules that you'd pass to hcslim::usecode().
#' @param class "chart" in Highcharts.chart(... For Highmaps, it should be "mapChart".
#' @param printjs Print completed JS to console for troubleshooting or pasting into jsFiddle.
#' @param pretty Use pretty formatting when converting options to JSON.
#' @printtempfile Print the location of the temporary HTML file. Useful for troubleshooting.
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
hcslim_view = function(
    options, 
    usecode_include = 'highcharts',
    class = c('chart', 'mapChart', 'stockChart', 'ganttChart'),
    printjs = FALSE, 
    pretty = !printjs,
    printtempfile = FALSE
){
  
  # get a temp file and use it to build a div id.
  tempfile = tempfile(fileext = ".html")
  if(printtempfile) print(tempfile)
  id = gsub('[.]html', '', gsub('.+\\\\', '', tempfile))
  
  # build the chart from options, and the module import.
  toview = unlist(list(
    usecode(usecode_include),
    hchtml(id = id, options = options, class = class, printjs = printjs, pretty = pretty)
  ))
  
  # write the temporary file.
  fileConn= file(tempfile)
  writeLines(c(glue::glue('<div id="{id}"></div>'), toview), fileConn)
  close(fileConn)
  
  # open the viewer.
  viewer = getOption("viewer")
  viewer(tempfile)
  
}

