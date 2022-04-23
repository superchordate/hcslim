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
    function(module) htmltools::HTML(as.character(
      glue::glue('<script src="https://code.highcharts.com/{module}.js"></script>')
    ))
  )

}

#' Built HTML for Highchart.
#'
#' Convers options and places the Highcharts Javascript inside a script tag. Put it inside a renderUI.
#'
#' @param id The HTML DOM id to use for the element and the output key to use. Must be HTML-compatible (no spaces).
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param class "chart" in Highcharts.chart(... For Highmaps, it should be "mapChart".
#' @param printjs Print completed JS to console for troubleshooting or pasting into jsFiddle.
#' @param pretty Use pretty formatting when converting options to JSON.
#'
#' @return HTML code for calling your chart.
#' @export
#'
#' @examples
#' \dontrun{
#'
#'require(shiny)
#'require(hcslim)
#'
#'shinyApp(
#'  
#'  ui = basicPage(
#'    usecode('highcharts'),    
#'    uiOutput('mychart')
#'  ),
#'
#'  server = function(input, output) {
#'
#'    output$mychart = renderUI({ 
#'      
#'      return(hchtml('mychart', list(
#'
#'        chart = list(type = 'line'),
#'        title = list(text = 'Some Numbers'),
#'        yAxis = list(
#'            title = list(
#'                text = '123456'
#'            )
#'        ),
#'        series = list(
#'          list(
#'            name = '123',
#'            data = c(1, 2, 3)
#'          ),
#'          list(
#'            name = '456',
#'            data = c(4, 5, 6)
#'          )
#'        )
#'        
#'      )))
#'      
#'    })
#'
#'})
#'
#' }
hchtml = function(
  id, 
  options, 
  class = c('chart', 'mapChart', 'stockChart', 'ganttChart'),
  printjs = FALSE, 
  pretty = !printjs
){
  
  # validate inputs.
  class = match.arg(class)
  .checkid(id)

  # initial conversion to JSON.
  json = jsonlite::toJSON(options, auto_unbox = TRUE, pretty = pretty, force = TRUE)
  
  # format markjs code as raw JS.
  json = gsub('"JS!([^!]+)!"', '\\1', json)

  # replace bad values with null.
  json = gsub('"(NA|-Inf|Inf)"', 'null', json)

  # Highcharts needs vectors, change single numbers to vectors.
  json = gsub('categories": ?([^[,} ]+)', 'categories": [\\1]', json)
  json = gsub('data": ?([^[,} ]+)', 'data": [\\1]', json)

  # compile final Highcharts JS call.
  # option to print completed JS to console for troubleshooting or pasting into jsFiddle.
  js = glue::glue("Highcharts.{class}('{id}', {json});")
  if(printjs) print(js)
  
  return(htmltools::HTML(as.character(glue::glue('<script>{js}</script>'))))

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
  return(as.character(glue::glue('JS!{string}!')))
}
