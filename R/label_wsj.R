#' Label plots like the wall street journal
#' i.e. display the units only on the top tick of the graph
#'
#' @param prefix character, the unit label to prefix on the max number of the y-axis
#' @param suffix character, the unit label to append on the max number of the y-axis
#' @param rm.bottom logical, remove the lowest number?
#' @param accuracy double, the precision for labels e.g. 1, 0.1, or 0.01
#' @param reverse logical, put label on the smallest tick instead of the largest?
#' @param ... args passed to scales::label_comma(...)
#'
#' @examples
#' library(ggplot2)
#' `%>%` <- magrittr::`%>%`
#'
#' plt <- economics_long %>%
#'   dplyr::filter(variable %in% c("psavert", "uempmed")) %>%
#'   ggplot(aes(date, value, color = variable)) +
#'   geom_line() +
#'   scale_y_continuous(
#'       labels = label_wsj(prefix = "$", suffix = " %")
#'   ) +
#'   theme_wsj() +
#'   labs(
#'     title = "Some Economics Plot",
#'     caption = "Source: Top secret."
#'   )
#'
#' @export
label_wsj <- function(
    prefix = "$",
    suffix = '',
    rm.bottom = TRUE,
    accuracy = NA,
    reverse = FALSE,
    ...
) {

    function(x) do_wsj_label(
        x, prefix, suffix, rm.bottom, accuracy, reverse, ...
    )
}

# internal calling function
do_wsj_label <- function(
    breaks, prefix, suffix, rm.bottom, accuracy, reverse, ...
) {

    # get info on the input breaks
    #
    # we can't use length because sometimes the last break mark is "NA"
    max_idx <- which.max(breaks)
    min_idx <- if (rm.bottom) 2 else 1

    max_num <- breaks[ max_idx ]
    min_num <- breaks[ min_idx ]

    if (rm.bottom) {
        nbreaks <- max_idx - 1                     # if we remove the first tick
    } else {
        nbreaks <- max_idx                         # if we keep the first tick
    }

    # format breaks with commas
    acc <- check_accuracy(accuracy, max_num, nbreaks)
    breaks_with_commas <- scales::label_comma(accuracy = acc, ...)(breaks)

    # remove bottom tick, and set min_idx in case label is reversed
    if (rm.bottom) {
        breaks_with_commas[ 1] <- ''
    }

    # add prefix and suffix with appropriate padding
    nchar_suffix <- stringr::str_length(suffix)
    breaks_with_commas <-paste0(
        breaks_with_commas, stringr::str_dup("  ", nchar_suffix)
    )

    # add label to first or last number, depending on orientation
    if (reverse) {
        breaks_with_commas[ min_idx] <- paste0(prefix, min_num, suffix)
    } else {
        breaks_with_commas[ max_idx] <- paste0(prefix, max_num, suffix)
    }

    # return new labels
    wsj_labels <- breaks_with_commas
    return(wsj_labels)
}

check_accuracy <- function(accuracy, maxnum, nbreaks) {
    accuracy <- as.double(accuracy)

    # if user DIDN'T specify, make "nice" defaults
    # if user DID specify, make sure it's a number and return
    if (is.na(accuracy)) {

        accuracy <- 1
        brk_lines <- nbreaks
        while (maxnum < brk_lines) {
            accuracy <- accuracy / 10
            brk_lines <- nbreaks * accuracy
        }
    }
    return(accuracy)
}
