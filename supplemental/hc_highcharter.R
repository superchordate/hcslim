# see https://github.com/superchordate/hcslim for more detailed documentation and examples. 

# these functions help with swapping highcharter to hcslim in an existing application. 

highchart = function(){ return(list()) }

hc_xAxis = function(options, ...){ hc_addoption(options, "xAxis", ...) }
hc_yAxis = function(options, ...){ hc_addoption(options, "yAxis", ...) }
hc_subtitle = function(options, ...){ hc_addoption(options, "subtitle", ...) }
hc_tooltip = function(options, ...){ hc_addoption(options, "tooltip", ...) }
hc_annotations = function(options, ...){ hc_addoption(options, "annotations", ...) }
hc_caption = function(options, ...){ hc_addoption(options, "caption", ...) }
hc_chart = function(options, ...){ hc_addoption(options, "chart", ...) }
hc_colorAxis = function(options, ...){ hc_addoption(options, "colorAxis", ...) }
hc_colors = function(options, ...){ hc_addoption(options, "colors", ...) }
hc_credits = function(options, ...){ hc_addoption(options, "credits", ...) }
hc_drilldown = function(options, ...){ hc_addoption(options, "drilldown", ...) }
hc_exporting = function(options, ...){ hc_addoption(options, "exporting", ...) }
hc_labels = function(options, ...){ hc_addoption(options, "labels", ...) }
hc_legend = function(options, ...){ hc_addoption(options, "legend", ...) }
hc_mapNavigation = function(options, ...){ hc_addoption(options, "mapNavigation", ...) }
hc_motion = function(options, ...){ hc_addoption(options, "motion", ...) }
hc_navigator = function(options, ...){ hc_addoption(options, "navigator", ...) }
hc_pane = function(options, ...){ hc_addoption(options, "pane", ...) }
hc_plotOptions = function(options, ...){ hc_addoption(options, "plotOptions", ...) }
hc_rangeSelector = function(options, ...){ hc_addoption(options, "rangeSelector", ...) }
hc_responsive = function(options, ...){ hc_addoption(options, "responsive", ...) }
hc_scrollbar = function(options, ...){ hc_addoption(options, "scrollbar", ...) }
hc_size = function(options, ...){ hc_addoption(options, "size", ...) }
hc_subtitle = function(options, ...){ hc_addoption(options, "subtitle", ...) }

hc_add_series = function(options, ...){
  if(!('series' %in% names(options))) options$series = list()  
  options$series[[length(options$series) + 1]] =  list(...)
  return(options)
}

hc_add_series_list = function(options, listofseries){
   for(i in listofseries) options = hc_addseries(options, i)
   return(options)
}

renderHighchart = function(id, options, class='chart', prettyjs=FALSE) renderUI({ 
  if(class(id) != 'character') stop('renderHighchart works a bit differently in hcslim. See ?renderHighchart')
  return(hchtml(id=id, options=options(), class=class, prettyjs=prettyjs))
})

highchartOutput = function(id, height = NULL, width = NULL){
  style = ''
  if(!is.null(height)) style = glue('{style}height: {height}px; ')
  if(!is.null(width)) style = glue('{style}width: {width}px; ')
  style = gsub('pxpx', 'px', style)
  return(uiOutput(id, style=style))
}

list_parse = function(x){
  if(nrow(x)==0) return(list())
  ilist = list()
  for(i in 1:nrow(x)){
    ilist[[i]] = list()
    for(j in names(x)) ilist[[i]][[j]] = x[[j]][i]
  }
  return(ilist)
}

list_parse2 = function(x){
  if(nrow(x)==0) return(list())
  ilist = list()
  for(i in 1:nrow(x)){
    ilist[[i]] = list()
    for(j in 1:ncol(x)) ilist[[i]][[j]] = x[[j]][i]
  }
  return(ilist)
}

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

hc_addseries = function(options, series){  
  if(!('series' %in% names(options))) options$series = list()  
  options$series[[length(options$series) + 1]] =  series
  return(options)
}