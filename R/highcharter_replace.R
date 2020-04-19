
highchart = function() list(
  title = list(text=''), 
  chart = list(animation=FALSE),
  plotOptions = list(series=list(animation=FALSE))
)
for(i in c(
  'xAxis', 'yAxis', 'subtitle', 'tooltip',  
  'annotations', 'caption', 'chart', 'colorAxis', 'colors', 'credits', 'drilldown',
  'exporting', 'labels', 'legend', 'mapNavigation', 'motion', 'navigator', 'pane', 'plotOptions', 'rangeSelector', 'responsive',
  'scrollbar', 'size', 'subtitle'
)) crun(glue('hc_{i} = function(options, ...) addoption(options, "{i}", ...) '))

addoption = function(options, name, ...){
  
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

hc_add_series = function(options, ...){  
  if('series' %ni% names(options)) options$series = list()  
  options$series[[length(options$series) + 1]] =  list(...)
  return(options)
}
hc_add_series_list = function(options, listofseries){
   for(i in listofseries) options = addseries(options, i)
   return(options)
}
addseries = function(options, series){  
  if('series' %ni% names(options)) options$series = list()  
  options$series[[length(options$series) + 1]] =  series
  return(options)
}

renderHighchart = function(id, options, class='chart') renderUI({ 
  return(hchtml(id, options(), class))
})

highchartOutput = function(id, height = NULL, width = NULL){
  style = ''
  if(!is.null(height)) style = glue('{style}height: {height}px; ')
  if(!is.null(width)) style = glue('{style}width: {width}px; ')
  style = gsub('pxpx', 'px', style)
  return(uiOutput(id, style=style))
}

list_parse = function(x){
  ilist = list()
  for(i in 1:nrow(x)){
    ilist[[i]] = list()
    for(j in names(x)) ilist[[i]][[j]] = x[[j]][i]
  }
  return(ilist)
}

list_parse2 = function(x){
  ilist = list()
  for(i in 1:nrow(x)){
    ilist[[i]] = list()
    for(j in 1:ncol(x)) ilist[[i]][[j]] = x[[j]][i]
  }
  return(ilist)
}