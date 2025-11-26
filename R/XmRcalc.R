
verification_data <- data.frame(

    ID = 1:16,
    ohms = c(5045, 4350, 4350, 3975,
             4290, 4430, 4485, 4285,
             3980, 3925, 3645, 3760,
             3300, 3685, 3463, 5200)
)

calculate_control_limits <- function(data) {

    # capture the name of the input
    data_name <- deparse(substitute(data))

    # Ensure data is a numeric vector
    if (!is.numeric(data)) stop("Data must be a numeric vector.")

    # Calculate the average (Xbar)

    Xbar <- mean(data, na.rm = TRUE)

    # Calculate the moving range

    mR <- abs(diff(data))

    # Calculate the average moving range (mRbar)

    mRbar <- mean(mR)
    URL <- 3.268 * mRbar

    # Calculate the control limits

    UNPL <- Xbar + (2.66 * mRbar)
    LNPL <- Xbar - (2.66 * mRbar)

    # and a few other things

    sigma <- (2.66/3) * mRbar
    stdev <- sd(data)

    #calculate

    # Return the calculations in a list

    return(list(
        data_name = data_name,
        Xbar = Xbar,
        mRbar = mRbar,
        URL = URL,
        UNPL = UNPL,
        LNPL = LNPL,
        sigma = sigma,
        stdev = stdev))
}

# test1 <- calculate_control_limits(verification_data$ohms)
# unlist(test1)


#### Ok try returning a S3 class with mR included
# create the class
create_control_limits <- function(data_name, Xbar, mRbar, URL, UNPL, LNPL, sigma, stdev, mR) {
    structure(list(
        data_name = data_name,
        Xbar = Xbar,
        mRbar = mRbar,
        URL = URL,
        UNPL = UNPL,
        LNPL = LNPL,
        sigma = sigma,
        stdev = stdev,
        mR = mR
        ),
        class = "control_limits"
    )
}

#### Modified function
calculate_control_limits2 <- function(data) {
    # capture the name of the input
    data_name <- deparse(substitute(data))
    # Ensure data is a numeric vector
    if (!is.numeric(data)) stop("Data must be a numeric vector.")
    # Calculate the average (Xbar)
    Xbar <- mean(data, na.rm = TRUE)
    # Calculate the moving range
    mR <- abs(diff(data))
    # Calculate the average moving range (mRbar)
    mRbar <- mean(mR)
    # Calculate the control limits
    UNPL <- Xbar + (2.66 * mRbar)
    LNPL <- Xbar - (2.66 * mRbar)
    URL <- 3.268 * mRbar
    # and a few other things
    sigma <- (2.66/3) * mRbar
    stdev <- sd(data)

    # Return the calculations in an S3 object
    create_control_limits(data_name, Xbar, mRbar, URL, UNPL, LNPL, sigma, stdev, mR)
}







data_list <- list( vector1 = c(10, 12, 9, 11, 10), vector2 = c(15, 14, 16, 15, 14) )

results <- lapply(data_list, calculate_control_limits2)

dplyr::bind_rows(lapply(results, as.data.frame), .id = "data_name")




