# WSJ Plot

Make ggplot graphs that look like the Wall street Journal. 

## Functions 
- `theme_wsj()`: Sets the default theme. Use as you would any `ggplot2::theme_choice()`.
- `label_wsj()`: Formats y-axis ticks such that the top number on the graph 
has the units, and the rest of the numbers are left visually clean. This 
also removes the bottom most axis lable by default, although this can be 
overridden. Use in place of any `scales::label_choice()`.

## Quick Use 
```r 
library(ggplot2)
`%>%` <- magrittr::`%>%`

economics_long %>%
    filter(variable %in% c("psavert", "uempmed")) %>%
    ggplot(aes(date, value, color = variable)) +
    geom_line() +
    scale_y_continuous(
        labels = label_wsj(suffix = " M")
    ) +
    scale_color_discrete(
        labels = c("Series 1", "Series 2")
    ) +
    theme_wsj() +
    labs(
        title = "Some Economics Plot",
        caption = "Source: Not well documented.",
        y = ""
    )
```

## Contribute

1. From your terminal:
```bash 
$ git clone https://github.com/slee981/wsjplot.git
$ cd wsjplot 
```

2. In RStudio: 
```r
 > library(devtools)
 > load_all()              # load exported functions into memory 
 > test()                  # run tests
 > document()              # update based on roxygen2 doc strings
 > check()                 # full diagnostic tests
```


