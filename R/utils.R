# Returns TRUE if a status is valid; throws error otherwise.
validateStatus <- function(status) {
  
  if (status %in% validStatuses) {
    return(TRUE)
  }
  
  stop("Invalid status: ", status, ". Valid statuses are: ",
       paste(validStatuses, collapse = ", "), ".")
}

validStatuses <- c("primary", "success", "info", "warning", "danger")


# Returns TRUE if a color is a valid color defined in AdminLTE, throws error
# otherwise.
validateColor <- function(color) {
  if (color %in% validColors) {
    return(TRUE)
  }
  
  stop("Invalid color: ", color, ". Valid colors are: ",
       paste(validColors, collapse = ", "), ".")
}

#' Valid colors
#'
#' These are valid colors for various dashboard components. Valid colors are
#' listed below.
#'
#' \itemize{
#'   \item \code{red}
#'   \item \code{yellow}
#'   \item \code{aqua}
#'   \item \code{blue}
#'   \item \code{light-blue}
#'   \item \code{green}
#'   \item \code{navy}
#'   \item \code{teal}
#'   \item \code{olive}
#'   \item \code{lime}
#'   \item \code{orange}
#'   \item \code{fuchsia}
#'   \item \code{purple}
#'   \item \code{maroon}
#'   \item \code{black}
#' }
#'
#' @usage NULL
#' @format NULL
#'
#' @keywords internal
validColors <- c("red", "yellow", "aqua", "blue", "light-blue", "green",
                 "navy", "teal", "olive", "lime", "orange", "fuchsia",
                 "purple", "maroon", "black")

#' Assert that a tag has specified properties
#' @param tag A tag object.
#' @param type The type of a tag, like "div", "a", "span".
#' @param class An HTML class.
#' @param allowUI If TRUE (the default), allow dynamic outputs generated by
#'   \code{\link[shiny]{uiOutput}} or \code{\link[shiny]{htmlOutput}}. When a
#'   dynamic output is provided, \code{tagAssert} won't try to validate the the
#'   contents.
#' @keywords internal
tagAssert <- function(tag, type = NULL, class = NULL, allowUI = TRUE) {
  if (!inherits(tag, "shiny.tag")) {
    print(tag)
    stop("Expected an object with class 'shiny.tag'.")
  }
  
  # Skip dynamic output elements
  if (allowUI &&
      (hasCssClass(tag, "shiny-html-output") ||
       hasCssClass(tag, "shinydashboard-menu-output") ||
       hasCssClass(tag, "ygdashboard-module-output"))) {
    return()
  }
  
  if (!is.null(type) && tag$name != type) {
    stop("Expected tag to be of type ", type)
  }
  
  if (!is.null(class)) {
    if (is.null(tag$attribs$class)) {
      stop("Expected tag to have class '", class, "'")
      
    } else {
      tagClasses <- strsplit(tag$attribs$class, " ")[[1]]
      if (!(class %in% tagClasses)) {
        stop("Expected tag to have class '", class, "'")
      }
    }
  }
}


"%OR%" <- function(a, b) if (!is.null(a)) a else b

# Return TRUE if a shiny.tag object has a CSS class, FALSE otherwise.
hasCssClass <- function(tag, class) {
  if (is.null(tag$attribs) || is.null(tag$attribs$class))
    return(FALSE)
  
  classes <- strsplit(tag$attribs$class, " +")[[1]]
  return(class %in% classes)
}


# Make sure a tab name is valid (there's no "." in it).
validateTabName <- function(name) {
  if (grepl(".", name, fixed = TRUE)) {
    stop("tabName must not have a '.' in it.")
  }
}