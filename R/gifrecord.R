#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
gifrecord <- function(message, width = NULL, height = NULL) {

  # forward options using x
  x = list(
    message = message
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'gifrecord',
    x,
    width = width,
    height = height,
    package = 'gifrecordeR'
  )
}

#' Shiny bindings for gifrecord
#'
#' Output and render functions for using gifrecord within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a gifrecord
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name gifrecord-shiny
#'
#' @export
gifrecordOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'gifrecord', width, height, package = 'gifrecordeR')
}

#' @rdname gifrecord-shiny
#' @export
renderGifrecord <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, gifrecordOutput, env, quoted = TRUE)
}
