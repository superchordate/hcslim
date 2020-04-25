#' Import Highcharts Libraries
#'
#' @param ... Code files to import, minimally defined. For example, to import https://code.highcharts.com/highcharts.js you'd send "highcharts". To import https://code.highcharts.com/modules/accessibility.js you'd send "modules/accessibility".
#'
#' @export
#'
#' @examples
#' \dontrun{
#' require(shiny)
#' ui = basicPage(
#'   usecode(
#'     'highcharts',
#'     'modules/exporting',
#'     'modules/export-data',
#'     'modules/accessibility'
#'   ),
#'   uiOutput('testchart')
#' )
#' }
usecode = function(...){

  hcpaths = unique(unlist(list(...)))
  #hcpaths = setdiff(hcpaths, get('.loadedpaths', envir = .hcslimvars))
  #assign('.loadedpaths', c(get('.loadedpaths', envir = .hcslimvars), hcpaths), envir = .hcslimvars)

  lapply(
    hcpaths,
    function(module) shiny::tags$script(src=glue::glue('https://code.highcharts.com/{module}.js'))
  )

}

#' Built HTML for Highchart.
#'
#' Convers options and places the Highcharts Javascript inside a script tag. Put it inside a renderUI.
#'
#' @param id The HTML DOM id to use for the element and the output key to use. Must be HTML-compatible (no spaces).
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param class "chart" in Highcharts.chart(... For Highmaps, it should be "mapChart".
#' @param pretty Use pretty formatting when converting options to JSON.
#'
#' @return HTML code for calling your chart.
#' @export
#'
#' @examples
#' \dontrun{
#' require(shiny)
#'server = function(input, output) {
#'
#'   output$testchart = renderUI({ tohc( 'testchart', list(
#'     chart = list(type = 'line'),
#'     title = list(text = 'Monthly Average Temperature'),
#'     subtitle = list(text = 'Source = WorldClimate.com'),
#'     xAxis = list(
#'       categories = c(
#'          'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 
#'          'Sep', 'Oct', 'Nov', 'Dec'
#'       )
#'     ),
#'     yAxis = list(
#'       title= list(
#'         text = 'Temperature (°C)'
#'       )
#'     ),
#'     plotOptions = list(
#'       line = list(dataLabels = list(enabled = TRUE), enableMouseTracking = FALSE)
#'    ),
#'     series = list(
#'       list(
#'         name = 'Tokyo',
#'         data = c(7.0, 6.9, 9.5, 14.5, 18.4, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6)
#'       ),
#'       list(
#'         name = 'London',
#'         data = c(3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8)
#'       )
#'     )
#'   ))
#'
#' })
#' }
#' }
hchtml = function(id, options, class=c('chart', 'mapChart', 'stockChart', 'ganttChart'), pretty=FALSE){
  
  class = match.arg(class)
  
  .checkid(id)
  
  json = jsonlite::toJSON(options, auto_unbox=TRUE, pretty=pretty, force=TRUE)
  
  json = gsub('"JS!([^!]+)!"', '\\1', json)
  json = gsub('"NA"', 'null', json)
  json = gsub('\\', '', json, fixed = TRUE)
  
  return(shiny::tags$script(HTML(glue::glue("Highcharts.{class}('{id}', {json});"))))
  
}

#' Mark JS
#' 
#' Marks Javascript code so hchtml knows how to handle it.
#'
#' @param string 
#'
#' @return string with Javascript marked.
#' @export
#'
#' @examples
markjs = function(string){
  return(glue::glue('JS!{string}!'))
}
