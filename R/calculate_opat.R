# One Point At a Time primitive calculation - basis for building more
# It's XmR, aka ImR, I call it one point at a time
# USER IS RESPONSIBLE TO MAKE SURE THE y VECTOR IS IN THEIR DESIRED ORDER!

#' @title calculate OPAT (one point at a time) limits
#' @description does the fundamental OPAT calculations for an vector input
#' @examples
#' # A simple OPAT calculation on a small dataset
#' y <- c(10, 6, 7, 12, 9)
#' opat <- calculate_opat(y)
#'
#' # Inspect the limits
#' opat$UYL
#' opat$LYL
#' opat$UMRL
#'
#' # Inspect the moving ranges
#' opat$MR



calculate_opat <- function(y) {

    # --- Validation: ensure the INPUTS are ok as far upstream as possible ---
    if (is.null(y)) {
        stop("Input cannot be NULL")
    }
    if (!is.atomic(y)) {
        stop("Input must be a numeric vector")
    }
    if (!is.numeric(y)) {
        stop("Input must be numeric")
    }
    if (length(y) < 3) {
        stop("OPAT requires at least 3 points")
    }
    if (length(y) > 500) {
        stop("OPAT does not require many points")
    }
    if (anyNA(y)) {
        stop("Input cannot contain NA")
    }
    if (!all(is.finite(y))) {
        stop("Input must contain only finite values")
    }

    # --- OPAT calculations ---
    data_name <- deparse(substitute(y))

    ybar  <- mean(y)
    MR    <- abs(diff(y))
    MRbar <- mean(MR)

    UYL   <- ybar + 2.66 * MRbar
    LYL   <- ybar - 2.66 * MRbar
    UMRL  <- 3.268 * MRbar

    sigma <- (2.66 / 3) * MRbar
    stdev <- sd(y)

    structure(
        list(
            data_name = data_name,
            ybar      = ybar,
            MRbar     = MRbar,
            UMRL      = UMRL,
            UYL       = UYL,
            LYL       = LYL,
            sigma     = sigma,
            stdev     = stdev,
            MR        = MR
        ),
        class = "opat_limits"
    )
}



