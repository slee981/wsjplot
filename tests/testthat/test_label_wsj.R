library(wsjplot)

test_that("label prefix prepends to only the largest number", {
    new_lables <- label_wsj()(c(0, 10, 100))
    expect_equal(new_lables[3], "$100")
})

test_that("label will reverse to second smallest number by default", {
    new_lables <- label_wsj(reverse = TRUE)(c(0, 10, 100))
    expect_equal(new_lables[2], "$10")
})

test_that("label will reverse to smallest number with rm.bottom", {
    new_lables <- label_wsj(reverse = TRUE, rm.bottom = FALSE)(c(0, 10, 100))
    expect_equal(new_lables[1], "$0")
})

test_that("label prefix prepends to only the largest number and ignores NA", {
    new_lables <- label_wsj()(c(0, 10, 100, NA))
    expect_equal(new_lables[3], "$100")
})

test_that("default label drops the lowest number", {
    new_lables <- label_wsj()(c(5, 10, 100))
    expect_equal(new_lables[1], "")
})

test_that("default label accuracy calculation recognizes one decimal place", {
    new_lables <- label_wsj()(c(-0.5, 0, 0.5))
    expect_equal(new_lables, c("", "0.0", "$0.5"))
})

test_that("default label accuracy calculation recognizes the need for
          two decimal place based on spacing", {
    new_lables <- label_wsj()(c(-0.5, 0, 0.05, 0.1))
    expect_equal(new_lables, c("", "0.00", "0.05","$0.1"))
})

test_that("default label accuracy calculation recognizes two decimal places", {
    new_lables <- label_wsj()(c(-0.05, 0, 0.05))
    expect_equal(new_lables, c("", "0.00", "$0.05"))
})

test_that("default label accuracy calculation recognizes three decimal places", {
    new_lables <- label_wsj()(c(-0.05, 0, 0.005))
    expect_equal(new_lables, c("", "0.000", "$0.005"))
})

test_that("Suffix adds white space for spacing", {
    new_lables <- label_wsj(suffix = " M")(c(0, 5, 10))
    expect_equal(new_lables, c("    ", "5    ", "$10 M"))
})

