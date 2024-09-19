#' hcslim Widget (Experimental)
#'
#' htmlwidget with embedded JS for easier use in Quarto, RMarkdown, RStudio, and R Shiny. 
#' See https://github.com/superchordate/hcslim for more detailed documentation and examples. 
#' 
#' Author: Bryce Chamberlain
#'
#' @param options Options list using standard Highcharts options and hc_markjs to mark Javascript code. 
#' @param width Standard argument passed to htmlwidgets::createWidget.
#' @param height Standard argument passed to htmlwidgets::createWidget.
#' @param elementId Standard argument passed to htmlwidgets::createWidget.
#' @param ... Remaining arguments are passed to hc_html.
#'
#' @return htmlwidgets widget representing your Highcharts chart. 
#' @export
hc_widget <- function(options, width = NULL, height = NULL, elementId = NULL, ...) {

  # choose an ID for the element.
  hc_widgetcount = hc_widgetcount <<- hc_widgetcount + 1
  id = paste0('hc', hc_widgetcount)

  # forward options using x
  x = list(id = id, script = hc_html(id = id, options = options, for_widget = TRUE, ...))

  # create widget
  htmlwidgets::createWidget(
    name = 'hcslim',
    x,
    width = width,
    height = height,
    package = 'hcslim',
    elementId = elementId
  )

}

#' Shiny bindings for hcslim (Experimental)
#'
#' Output and render functions for using hcslim within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a hcslim
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name hcslim-shiny
#'
#' @export
hcslimOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'hcslim', width, height, package = 'hcslim')
}

#' @rdname hcslim-shiny
#' @export
renderHcslim <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, hcslimOutput, env, quoted = TRUE)
}

hc_widgetcount = 0