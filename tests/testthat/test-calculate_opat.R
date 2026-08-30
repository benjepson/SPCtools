library(testthat)
#library(SPCtools)

#test the structure calculate_opat returns
test_that("calculate_opat returns correct structure", {
    y <- c(5, 6, 7, 8, 9)

    out <- calculate_opat(y)

    expect_s3_class(out, "opat_limits")
    expect_true(is.numeric(out$ybar))
    expect_true(is.numeric(out$MRbar))
    expect_true(is.numeric(out$UMRL))
    expect_true(is.numeric(out$UYL))
    expect_true(is.numeric(out$LYL))
    expect_true(is.numeric(out$sigma))
    expect_true(is.numeric(out$stdev))
    expect_length(out$MR, length(y) - 1)
})

#test NULL input
test_that("NULL input fails", {
    expect_error(calculate_opat(NULL))
})

#test non atomic (input should be a vector)
test_that("non-atomic input fails", {
    expect_error(calculate_opat(list(1, 2, 3)))
})

#test non numeric input
test_that("non-numeric input fails", {
    expect_error(calculate_opat(c("a", "b", "c")))
})

#test length < 3
test_that("too few points fails", {
    expect_error(calculate_opat(c(1, 2)))
})

#test max length (had to pick a cutoff somewhere)
test_that("too many points fails", {
    expect_error(calculate_opat(rep(1, 501)))
})

#test NA values
test_that("NA values fail", {
    expect_error(calculate_opat(c(1, NA, 3)))
})

#test infinity, NAN
test_that("non-finite values fail", {
    expect_error(calculate_opat(c(1, Inf, 3)))
    expect_error(calculate_opat(c(1, -Inf, 3)))
    expect_error(calculate_opat(c(1, NaN, 3)))
})

test_that("calculate_opat matches Wheeler reference values USPC page 387", {
    y <- c(5045, 4350, 4350, 3975,
           4290, 4430, 4485, 4285,
           3980, 3925, 3645, 3760,
           3300, 3685, 3463, 5200)

    out <- calculate_opat(y)

    expect_equal(out$ybar,   4135.5,    tolerance = 1e-5)
    expect_equal(out$MRbar,  355.9333,  tolerance = 1e-5)
    expect_equal(out$UYL,    5082.283,  tolerance = 1e-5)
    expect_equal(out$LYL,    3188.717,  tolerance = 1e-5)
    expect_equal(out$UMRL,   1163.19,   tolerance = 1e-5)
})


