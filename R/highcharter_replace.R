#' Highchart Replacement: highchart
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @return List that can be passed to other functions.
#' @export
#'
highchart = function(){ return(list()) }

#' Highchart Replacement: hc_xAxis
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_xAxis = function(options, ...){ hc_addoption(options, "xAxis", ...) }

#' Highchart Replacement: hc_yAxis
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_yAxis = function(options, ...){ hc_addoption(options, "yAxis", ...) }

#' Highchart Replacement: hc_subtitle
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_subtitle = function(options, ...){ hc_addoption(options, "subtitle", ...) }

#' Highchart Replacement: hc_tooltip
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_tooltip = function(options, ...){ hc_addoption(options, "tooltip", ...) }

#' Highchart Replacement: hc_annotations
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_annotations = function(options, ...){ hc_addoption(options, "annotations", ...) }

#' Highchart Replacement: hc_caption
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_caption = function(options, ...){ hc_addoption(options, "caption", ...) }

#' Highchart Replacement: hc_chart
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_chart = function(options, ...){ hc_addoption(options, "chart", ...) }

#' Highchart Replacement: hc_colorAxis
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_colorAxis = function(options, ...){ hc_addoption(options, "colorAxis", ...) }

#' Highchart Replacement: hc_colors
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_colors = function(options, ...){ hc_addoption(options, "colors", ...) }

#' Highchart Replacement: hc_credits
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_credits = function(options, ...){ hc_addoption(options, "credits", ...) }

#' Highchart Replacement: hc_drilldown
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_drilldown = function(options, ...){ hc_addoption(options, "drilldown", ...) }

#' Highchart Replacement: hc_exporting
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_exporting = function(options, ...){ hc_addoption(options, "exporting", ...) }

#' Highchart Replacement: hc_labels
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_labels = function(options, ...){ hc_addoption(options, "labels", ...) }

#' Highchart Replacement: hc_legend
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_legend = function(options, ...){ hc_addoption(options, "legend", ...) }

#' Highchart Replacement: hc_mapNavigation
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_mapNavigation = function(options, ...){ hc_addoption(options, "mapNavigation", ...) }

#' Highchart Replacement: hc_motion
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_motion = function(options, ...){ hc_addoption(options, "motion", ...) }

#' Highchart Replacement: hc_navigator
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_navigator = function(options, ...){ hc_addoption(options, "navigator", ...) }

#' Highchart Replacement: hc_pane
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_pane = function(options, ...){ hc_addoption(options, "pane", ...) }

#' Highchart Replacement: hc_plotOptions
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_plotOptions = function(options, ...){ hc_addoption(options, "plotOptions", ...) }

#' Highchart Replacement: hc_rangeSelector
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_rangeSelector = function(options, ...){ hc_addoption(options, "rangeSelector", ...) }

#' Highchart Replacement: hc_responsive
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_responsive = function(options, ...){ hc_addoption(options, "responsive", ...) }

#' Highchart Replacement: hc_scrollbar
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_scrollbar = function(options, ...){ hc_addoption(options, "scrollbar", ...) }

#' Highchart Replacement: hc_size
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_size = function(options, ...){ hc_addoption(options, "size", ...) }

#' Highchart Replacement: hc_subtitle
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_subtitle = function(options, ...){ hc_addoption(options, "subtitle", ...) }

#' Highchart Replacement: hc_add_series
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param ... Option key/value pairs passed to hc_addoption.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_add_series = function(options, ...){
  if('series' %ni% names(options)) options$series = list()  
  options$series[[length(options$series) + 1]] =  list(...)
  return(options)
}

#' Highchart Replacement: hc_add_series_list
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param options Highcharts options for the chart. Includes data, chart type, etc.
#' @param listofseries List of data for one or more series'.
#'
#' @return List that can be passed to other functions.
#' @export
#'
hc_add_series_list = function(options, listofseries){
   for(i in listofseries) options = hc_addseries(options, i)
   return(options)
}

#' Highchart Replacement: renderHighchart
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param id The HTML DOM id to use for the element and the output key to use. Must be HTML-compatible (no spaces).
#' @param options Function that builds Highcharts options for the chart.
#' @param class "chart" in Highcharts.chart(... For Highmaps, it should be "mapChart".
#' @param prettyjs Use pretty formatting when converting options to JSON.
#'
#' @return Render object
#' @export
#'
#' @examples
#' \dontrun{
#'  renderHighchart('mychart', function(){
#'    # code to build options here (including series data).
#'  })
#' }
renderHighchart = function(id, options, class='chart', prettyjs=FALSE) renderUI({ 
  if(class(id) != 'character') stop('renderHighchart works a bit differently in hcslim. See ?renderHighchart')
  return(hchtml(id=id, options=options(), class=class, prettyjs=prettyjs))
})

#' Highchart Replacement: highchartOutput
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param id output ID used in R Shiny.
#' @param height desired height of the chart.
#' @param width desired width of the chart.
#'
#' @return Output object
#' @export
#'
highchartOutput = function(id, height = NULL, width = NULL){
  style = ''
  if(!is.null(height)) style = glue('{style}height: {height}px; ')
  if(!is.null(width)) style = glue('{style}width: {width}px; ')
  style = gsub('pxpx', 'px', style)
  return(uiOutput(id, style=style))
}

#' Highchart Replacement: list_parse
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param x Data frame to be converted.
#'
#' @return List representation of data.
#' @export
#'
list_parse = function(x){
  if(nrow(x)==0) return(list())
  ilist = list()
  for(i in 1:nrow(x)){
    ilist[[i]] = list()
    for(j in names(x)) ilist[[i]][[j]] = x[[j]][i]
  }
  return(ilist)
}

#' Highchart Replacement: list_parse2
#' 
#' Added to make code written with Highcharter work with hcslim.
#'
#' @param x Data frame to be converted.
#'
#' @return List representation of data.
#' @export
#'
list_parse2 = function(x){
  if(nrow(x)==0) return(list())
  ilist = list()
  for(i in 1:nrow(x)){
    ilist[[i]] = list()
    for(j in 1:ncol(x)) ilist[[i]][[j]] = x[[j]][i]
  }
  return(ilist)
}

# helper functions;
hc_addoption = function(options, name, ...){
  
  if(name %ni% names(options)) options[[name]] = list()
  
  # get object names from the function call.
  datalist = list(...)
  
  if(name=='colors'){
    options[[name]] = unlist(datalist)
  } else {
    for(i in names(datalist)) options[[name]][[i]] = datalist[[i]]
  }
  
  return(options)
  
}
hc_addseries = function(options, series){  
  if('series' %ni% names(options)) options$series = list()  
  options$series[[length(options$series) + 1]] =  series
  return(options)
}