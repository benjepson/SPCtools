# Note - this script is a scratchpad 11/28/24
# when I'm a bit further along we'll split functions into separate scripts

#########################################################
# XmR (single Y) methods to start

verification_data <- data.frame(

    ID = 1:16,
    ohms = c(5045, 4350, 4350, 3975,
             4290, 4430, 4485, 4285,
             3980, 3925, 3645, 3760,
             3300, 3685, 3463, 5200)
)

#### create S3 class to capture XmR results

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
calculate_control_limits <- function(data) {
    # capture the name of the input
    data_name <- deparse(substitute(data))
    # Ensure data is a numeric vector
    if (!is.numeric(data)) stop("Data must be numeric")
    # Calculate the average (Xbar)
    Xbar <- mean(data, na.rm = TRUE) # Allowing Na removal here for convenience
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


### Next......
# I created calculate control limits to work on a vector. Should I make a
# new function for working with a dataframe of X and Y vars?
# or extend this one...........
# I want to have it vectorized for easily doing multiple calculations
# But also a workflow
# I think I'll provide both

# "set_control_limits" function (name tbd)

# accept a dataframe of Xvar (time or order) and Yvar (the var to track)

# Test if Y is numeric, integer, other types?(I can't think of any) Can't be categoric, factor, date etc
#       test for NA (should I remove them or make the user do it manually?)
#        (I think maybe they remove manually, needs to be a conscious act)

# XmR, test only 1 Y value per unique X

# Test if X is either numeric or date (others?)
# Test for X NA, user needs to clean before setting limits
# test "spacing", are the X values similarly separated from each other?
    # return a message (prob) if spacing is not equal (or "close"?)
    # Some judgment calls here, like if hourly testing, do you care one is
    # 55 minutes apart, next is 63 minutes apart etc. I think message, and
    # let the user decide, so they'll at least be aware



### Future function - helpers to apply across many variables to calculate
# limits, useful for faceting and exploratory work
# proof of concept script:
data_list <- list( vector1 = c(10, 12, 9, 11, 10), vector2 = c(15, 14, 16, 15, 14) )

results <- lapply(data_list, calculate_control_limits)

dplyr::bind_rows(lapply(results, as.data.frame), .id = "data_name")

# Next steps - make more useful "convenience functions"


## Rare events
# should I include a helper function to calculate rare events charts?
# user would supply X and Y vars, then it calculates time between Y events
# then it just does normal XmR calculations

# ANOX
# Extend XmR to ANOX
# should it be a separate function, or an argument within "convenience plot"
# emphasis on ANOX for "one time" analysis, not meant for ongoing monitoring




#################################################################
###############################################################

### XbarR and ANOM methods
# calculate XbarR values
# basic function that feeds into convenience, and "Set limits" utilities
# more complex, need to consider subgroup size
# need to test subgroup size, for XbarR should i allow unequal subgroups?
# seems maybe no, they should be consistent

# ANOM is the ANOX equivalent, one time analysis (not monitoring)
# ANOM may have unequal subgroup sizes, need to test for those,
# If unequal, flag with warning or message and switch to unequal subgroup methods



