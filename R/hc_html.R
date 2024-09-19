
#' hc_html
#'
#' Main hcslim function. Converts an R list to Highcharts options and return Highcharts JS.
#' See https://github.com/superchordate/hcslim for more detailed documentation and examples. 
#' 
#' Author: Bryce Chamberlain
#'
#' @param id HTML id of the div to put the chart in.
#' @param options Options list using standard Highcharts options and hc_markjs to mark Javascript code. 
#' @param class Type of chart. 
#' @param loadmapfromurl URL to load your base map from.
#' @param printjs Print the generated Javascript. Useful for debugging. 
#' @param pretty Output readable Javascript.
#' @param for_widget Special option for buiding an htmlwidget. Please don't change it.
#'
#' @return HTML script tag with the Javascript to create your Highcharts chart.
#' @export
hc_html = function(
  id, 
  options, 
  class = c('chart', 'mapChart', 'stockChart', 'ganttChart'),
  loadmapfromurl = NULL,
  printjs = FALSE, 
  pretty = printjs,
  for_widget = FALSE # special option for buiding an htmlwidget.
){
  
  # validate inputs.
  class = match.arg(class)
  if(grepl('[ ]', id)) stop(paste0('hcslim: Invalid id [', id, ']. Must be HTML-compatible. See https://stackoverflow.com/a/79022/4089266.'))

  # if series data is a data frame, we need to convert it to a list.
  for(i in seq_along(options$series)) if(!is.null(ncol(options$series[[i]]$data))){
    # ycategory = is.factor(options$series[[i]]$data$y) || is.character(options$series[[i]]$data$y)
    options$series[[i]]$data <- hc_dataframe_to_list(options$series[[i]]$data)
  }

  # if there is not title, add a blank one to prevent the default "Chart title"
  # if(is.null(options$title)) options$title = list(text = '')

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
  # add map download if necessary https://www.highcharts.com/docs/maps/map-collection
  if(!is.null(loadmapfromurl)){
    js = paste0('
      const topology = await fetch("', loadmapfromurl, '").then(response => response.json()); 
      Highcharts.', class, '("',id, '", {json});
    ')
    if(!for_widget){
      html = paste0('<script>(async () => {', js, '})();</script>')
    } else {
      html = paste0('(async () => {', js, '})();')
    }
  } else {
    js = paste0('Highcharts.{class}("', id, '", ', json, ');')
    if(!for_widget){
      html = paste0('<script>', js, '</script>')
    } else {
      html = js
    }
  }
  if(printjs) print(js)
  
  return(htmltools::HTML(as.character(html)))

}

#' hc_markjs
#'
#' Marks Javascript code so hc_html knows how to handle it.
#' See https://github.com/superchordate/hcslim for more detailed documentation and examples. 
#' 
#' Author: Bryce Chamberlain
#'
#' @param string Javascript code as a character.
#'
#' @return Javacript code inside "JS!{string}!" which hc_html will know what to do with.
#' @export
hc_markjs = function(string){
  return(as.character(paste0('JS!', string, '!')))
}

#' hc_addgroupedseries
#'
#' Helper to add a grouped series. 
#' See https://github.com/superchordate/hcslim for more detailed documentation and examples. 
#' 
#' Author: Bryce Chamberlain
#'
#' @param options Your starting Highcharts options.
#' @param data Data to pull from.
#' @param groupcol Character indicating the column to use for grouping. 
#' @param xcol Character indicating the column to use for the x value. 
#' @param ycol Character indicating the column to use for the y value. 
#' @param zcol Character indicating the column to use for the z value (used in Bubble charts, etc). 
#'
#' @return Modified Highcharts options with series' added.
#' @export
hc_addgroupedseries = function(options, data, groupcol, xcol, ycol, zcol = NULL){

    # validation.

      if('state' %in% names(data)) warning('
        [state] has a special usage in Highcharts. If you plan to use the column [state] you may experience issues.
        Suggest renaming to [state_abbr] or similar. 
        hcslim::addgroupedseries Warning W513.
      ')

      for(icol in c(groupcol, xcol, ycol)) if(!(icol %in% names(data))) stop(glue('
        Column [{icol}] was not found in the data. 
        hcslim::addgroupedseries Error 514.
      '))

    # select columns.
    data$x = data[[xcol]]
    data$y = data[[ycol]]
    if(!is.null(zcol)) data$z = data[[zcol]] 
    data$group = data[[groupcol]]

    # this only works if using factors so we'll convert to factors.
    data$x = factor(data$x, levels = unique(data$x)) # set levels to preserve sorting.
    data$group = factor(data$group, levels = unique(data$group)) # set levels to preserve sorting.
    data %<>% droplevels() # unused levels will create chaos later.

    # we need a complete mapping so the series' line up.
    # fill missing segments.
    data %<>% right_join( # right join to keep sorting from data. 
      expand.grid(
          x = levels(data$x),
          group = levels(data$group)
      ),
      by = c('x', 'group')
    )

    # extract categories for x axis.
    categories = levels(data$x)

    # create each series.
    if(!('series' %in% names(options))) options$series = list()
    for(jdt in split(data, data$group)) options$series[[length(options$series) + 1]] <- list(
        name = as.character(jdt$group[1]),
        data = jdt %>% 
            mutate(x = as.numeric(x) - 1) %>% 
            select(-group) %>%
            hc_dataframe_to_list()
    )

    if(!('xAxis' %in% names(options))) options$xAxis = list()
    options$xAxis$type = 'categorical'
    options$xAxis$categories = categories

    # enable the legend. 
    if(!('legend' %in% names(options))) options$legend = list()
    options$legend$enabled = TRUE

    return(options)

}

#' hc_enabletooltips
#'
#' Helper to enable tooltips on a chart. Enabling the tooltip is not intuitive because of how I've set up the defaults, so we have this function to enable them more easily.
#' I like to use enableMouseTracking = FALSE to remove distractions.
#' See https://github.com/superchordate/hcslim for more detailed documentation and examples. 
#' 
#' Author: Bryce Chamberlain
#'
#' @param options Your starting Highcharts options.
#'
#' @return Modified Highcharts options with tooltips enabled (series > enableMouseTracking > TRUE)
#' @export
hc_enabletooltips = function(options){
  if(!('plotOptions' %in% names(options))) options$plotOptions = list()
  if(!('series' %in% names(options$plotOptions))) options$plotOptions$series = list()
  options$plotOptions$series$enableMouseTracking = TRUE
  return(options)
}

# helper function to convert dataframe to a Highcharts-friendly list. 
hc_dataframe_to_list = function(x){
  if(nrow(x)==0) return(list())
  dt = lapply(split(x, 1:nrow(x)), as.list)
  names(dt) = NULL
  return(dt)
}

