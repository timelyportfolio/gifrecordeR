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


gifrecord_html <- function(id, style, class, ...){
  htmltools::tagList(
    htmltools::tags$div(
      id = id, class = class, style = style, 
      style= "position: fixed; right: '5%'; top = '5%'; zIndex: 99999;",
      htmltools::tags$div(
        id = "anigif_wrapper",
        htmltools::HTML('
<div id="anigif_bar">


<div>
<img id="record" src="./lib/gifw00t-0.0.1/img/record.png" />
</div>

<div>
<img id="stop" src="./lib/gifw00t-0.0.1/img/stop.png" />
</div>

<div>
<img id="play" src="./lib/gifw00t-0.0.1/img/play.png" />
</div>

<div>
<img id="config" src="./lib/gifw00t-0.0.1/img/config.png" />
</div>

<div id="status" style="margin-top: 0px; margin-left: 5px;">
ready
</div>

</div>

<div id="anigif_settings">

<div>
<div class="label" title="Root node for recording (CSS selector)">Element to Record:</div>
<div><input type="text" id="rootNode" /></div>
</div>

<div>
<div class="label" title="How many frames to capture per second">Frames Per Second:</div>
<div><input type="text" id="framesPerSecond" /></div>
</div>

<div>
<div class="label" title="Max number of frames to record. When passing the limit earlier frames are lost, newer kept.">Limit Frames:</div>
<div><input type="text" id="onlyLastFrames" /></div>
</div>

<div>
<div class="label" title="Number of cores on your machine (to parallel gif composition)">Cores:</div>
<div><input type="text" id="cores" /></div>
</div>

<div>
<div class="label" title="Ratio between original image and generated clip (0.0-1)">Ratio:</div>
<div><input type="text" id="ratio" /></div>
</div>

<div>
<div class="label" title="Record quality">Quality:</div>
<div>
<select id="quality">
<option id="low">Low</option>
<option id="medium">Medium</option>
<option id="high">High</option>
</select>
</div>
</div>

<div>
<div class="label" title="Online will give better accuracy in image and rendering time will be faster. However sometimes, especially when you set a high frames-per-second or ratio is not 1 or there is heavy graphics, it will cause delays and flickeing while you perfrom the flow you record. ">Period Mode:</div>
<div>
<select id="period">
<option id="online">Online</option>
<option id="offline">Offline</option>
</select>
</div>
</div>

<div>
<div class="label" title="Render the element in a fixed width (usefull if the element width depends on upper stream elements whcih are not captured)">Fixed Width (Optional):</div>
<div><input type="text" id="fixedWidth" /></div>
</div>

<div style="margin-top: 15px;">
<a onclick="window.anigif_bar.saveConfig(); window.anigif_bar.closeConfig(); return false;" href="">Close</a>
</div>
</div>
'
          )
       )
    )
  )
}