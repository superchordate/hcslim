#' Highcharter override functions.
#'
#' These functions help with swapping highcharter to hcslim in an existing application. 
#' See https://github.com/superchordate/hcslim for more detailed documentation and examples. 
#' 
#' Author: Bryce Chamberlain
#'
#' @param options Options list using standard Highcharts options and hc_markjs to mark Javascript code. 
#'
#' @name hcslim-highcharter
#'
#' @export
highchart = function(){ return(list()) }

#' @rdname hcslim-highcharter
#' @export
hc_xAxis = function(options, ...){ hc_addoption(options, "xAxis", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_yAxis = function(options, ...){ hc_addoption(options, "yAxis", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_subtitle = function(options, ...){ hc_addoption(options, "subtitle", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_tooltip = function(options, ...){ hc_addoption(options, "tooltip", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_annotations = function(options, ...){ hc_addoption(options, "annotations", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_caption = function(options, ...){ hc_addoption(options, "caption", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_chart = function(options, ...){ hc_addoption(options, "chart", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_colorAxis = function(options, ...){ hc_addoption(options, "colorAxis", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_colors = function(options, ...){ hc_addoption(options, "colors", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_credits = function(options, ...){ hc_addoption(options, "credits", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_drilldown = function(options, ...){ hc_addoption(options, "drilldown", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_exporting = function(options, ...){ hc_addoption(options, "exporting", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_labels = function(options, ...){ hc_addoption(options, "labels", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_legend = function(options, ...){ hc_addoption(options, "legend", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_mapNavigation = function(options, ...){ hc_addoption(options, "mapNavigation", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_motion = function(options, ...){ hc_addoption(options, "motion", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_navigator = function(options, ...){ hc_addoption(options, "navigator", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_pane = function(options, ...){ hc_addoption(options, "pane", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_plotOptions = function(options, ...){ hc_addoption(options, "plotOptions", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_rangeSelector = function(options, ...){ hc_addoption(options, "rangeSelector", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_responsive = function(options, ...){ hc_addoption(options, "responsive", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_scrollbar = function(options, ...){ hc_addoption(options, "scrollbar", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_size = function(options, ...){ hc_addoption(options, "size", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_subtitle = function(options, ...){ hc_addoption(options, "subtitle", ...) }

#' @rdname hcslim-highcharter
#' @export
hc_add_series = function(options, ...){
  if(!('series' %in% names(options))) options$series = list()  
  options$series[[length(options$series) + 1]] =  list(...)
  return(options)
}

#' @rdname hcslim-highcharter
#' @export
hc_add_series_list = function(options, listofseries){
   for(i in listofseries) options = hc_addseries(options, i)
   return(options)
}

#' @rdname hcslim-highcharter
#' @export
renderHighchart = function(id, options, class='chart', prettyjs=FALSE) renderUI({ 
  if(class(id) != 'character') stop('renderHighchart works a bit differently in hcslim. See ?renderHighchart')
  return(hchtml(id=id, options=options(), class=class, prettyjs=prettyjs))
})

#' @rdname hcslim-highcharter
#' @export
highchartOutput = function(id, height = NULL, width = NULL){
  style = ''
  if(!is.null(height)) style = glue('{style}height: {height}px; ')
  if(!is.null(width)) style = glue('{style}width: {width}px; ')
  style = gsub('pxpx', 'px', style)
  return(uiOutput(id, style=style))
}

#' @rdname hcslim-highcharter
#' @export
list_parse = function(x){
  if(nrow(x)==0) return(list())
  ilist = list()
  for(i in 1:nrow(x)){
    ilist[[i]] = list()
    for(j in names(x)) ilist[[i]][[j]] = x[[j]][i]
  }
  return(ilist)
}

#' @rdname hcslim-highcharter
#' @export
list_parse2 = function(x){
  if(nrow(x)==0) return(list())
  ilist = list()
  for(i in 1:nrow(x)){
    ilist[[i]] = list()
    for(j in 1:ncol(x)) ilist[[i]][[j]] = x[[j]][i]
  }
  return(ilist)
}

#' @rdname hcslim-highcharter
#' @export
hc_addoption = function(options, name, ...){
  
  if(!(name %in% names(options))) options[[name]] = list()
  
  # get object names from the function call.
  datalist = list(...)
  
  if(name=='colors'){
    options[[name]] = unlist(datalist)
  } else {
    for(i in names(datalist)) options[[name]][[i]] = datalist[[i]]
  }
  
  return(options)
  
}

#' @rdname hcslim-highcharter
#' @export
hc_addseries = function(options, series){  
  if(!('series' %in% names(options))) options$series = list()  
  options$series[[length(options$series) + 1]] =  series
  return(options)
}

