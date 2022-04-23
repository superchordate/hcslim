
addgroupedseries = function(options, data, groupcol, xcol, ycol){

    # validation.

      if('state' %in% names(data)) warning('
        [state] has a special usage in Highcharts. If you plan to use the column [state] you may experience issues.
        Suggest renaming to [state_abbr] or similar. 
        hcslim::addgroupedseries Warning W513.
      ')

      for(icol in c(groupcol, xcol, ycol)) if(icol %ni% names(data)) stop(glue('
        Column [{icol}] was not found in the data. 
        hcslim::addgroupedseries Error 514.
      '))

    # select columns.
    data$x = data[[xcol]]
    data$y = data[[ycol]]
    data$group = data[[groupcol]]

    # this only works if using factors so we'll convert to factors.
    data$x %<>% as.factor()
    data$group %<>% as.factor() 
    data %<>% droplevels() # unused levels will create chaos later.

    # we need a complete mapping so the series' line up.
    # fill missing segments.
    data = expand.grid(
        x = sort(unique(data$x)),
        group = sort(unique(data$group))
    ) %>% 
    left_join(data, by = c('x', 'group'))

    # extract categories for x axis.
    categories = as.character(unique(data$x))

    # create each series.
    series = list()
    for(jdt in split(data, data$group)) series[[length(series) + 1]] <- list(
        name = as.character(jdt$group[1]),
        data = jdt %>% 
            mutate(x = as.numeric(x) - 1) %>% 
            select(-group) %>%
            list_parse()
    )

    options %<>% addoption('series', series)
    options %<>% addoption('xAxis', list(
        type = 'categorical',
        categories = categories
    ))

    return(options)

}

