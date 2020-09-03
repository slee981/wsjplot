#' Make timeseries graphs look like the the Wall Street Journal
#'
#' @importFrom ggplot2 %+replace% theme_minimal theme element_blank element_text margin element_line unit
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
#'       labels = label_wsj(suffix = " M")
#'   ) +
#'   scale_color_discrete(
#'       labels = c("Series 1", "Series 2")
#'   ) +
#'   theme_wsj() +
#'   labs(
#'     title = "Some Economics Plot",
#'     caption = "Source: Top secret.",
#'     y = ""
#'   )
#'
#' @export
theme_wsj <- function() {

    theme_minimal() %+replace%
    theme(

        # axis

        # x
        axis.title.x = element_blank(),
        axis.text.x = element_text( angle = 0),
        axis.ticks.x = element_line(),
        axis.ticks.length.x = unit(4, 'pt'),

        # y
        axis.title.y = element_text(
            angle = 0,
            margin = margin(t = 0, r = 20, b = 0, l = 0)
        ),
        axis.text.y = element_text(
            hjust = 1
        ),
        axis.ticks.y = element_blank(),

        # panel
        panel.grid.minor = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.spacing = unit(.5, "lines"),

        # plot
        plot.title = element_text(
            face = "bold",
            size = 12,
            hjust = 0.5,
            margin = margin(t = 0, r = 0, b = 15, l = 0)
        ),
        plot.subtitle = element_text(
            hjust = 0.5,
            size = 9
        ),
        plot.caption = element_text(
            hjust = 0,
            size = 9,
            color = "darkgrey",
            margin = margin(
                t = 15, r = 0, b = 0, l = 0
            ),
        ),

        # facet grid strips
        strip.text.y = element_text(
            size = 8,
            margin = margin(t = 0, r = 0, b = 0, l = 0),
            angle = -90
        ),

        # legend
        legend.title = element_blank()
    )
}
