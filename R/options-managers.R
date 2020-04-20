#' Update Highcharts Options
#' 
#' Preserves current options while adding new ones. This isn't as exact as manually working the list, but may be convenient.
#'
#' @param options Highcharts options list.
#' @param option first-level (chart, xAxis, etc.) option to be modified.
#' @param ... Named second-level options (width, margin, etc.) to be set.
#'
#' @return List that can be passed to other functions.
#' @export
#'
#' @examples
update = function(options, option, ...){
  
  # add the first-level option if it doesn't exist yet.
  if(option %ni% names(options)) options[[option]] = list()
  
  # get the new options.
  datalist = list(...)
  
  if(option=='colors'){
    options[[option]] = unlist(datalist)
  } else {
    for(i in names(datalist)) options[[option]][[i]] = datalist[[i]]
  }
  
  return(options)

}
