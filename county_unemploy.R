################################################################################
##
## <FILE> county_unemploy.R
## <AUTH> Benjamin Skinner
## <INIT> 25 April 2016
##
################################################################################

## clear memory
rm(list = ls())

## libraries
libs <- c('dplyr', 'readr', 'tidyr')
lapply(libs, require, character.only = TRUE)

## quick functions
`%+%` <- function(a,b) paste(a, b, sep = '')
strip_comma <- function(x) as.integer(gsub(',', '', as.character(x)))

################################################################################
## COUNTY AND STATE LEVEL UNEMPLOYMENT
################################################################################

## list of years
yr <- c(2000:2016)

## base url
baseurl <- 'http://www.bls.gov/lau/laucnty'

## column widths
widths <- c(18, 7, 6, 50, 6, 12, 13, 11, 9)

## column names
cnames <- c('lauscode', 'stfips', 'ctfips', 'name', 'year', 'labor_force',
            'employed', 'unemployed', 'unem_rate')

## init outlist
outlist <- list()

## loop through years to get all files
for(y in yr) {

    message('Retrieving and storing data from ' %+% y)

    ## convert year to two digit with leading zero
    y <- sprintf('%02d', as.integer(substr(y, 3, 4)))

    ## get url
    url <- baseurl %+%  y %+% '.txt'

    ## download raw text file
    d <- read_fwf(url,
                  col_positions = fwf_widths(widths, cnames),
                  col_types = cols(.default = "c"),
                  skip = 6)

    ## county
    d <- d %>%
        filter(!is.na(stfips)) %>%
        mutate(fips = stfips %+% ctfips,
               unem_rate = as.numeric(as.character(unem_rate)),
               name = ifelse(name == 'District of Columbia',
                             'District of Columbia, DC',
                             name)) %>%
        mutate_at(.vars = vars(labor_force, employed, unemployed),
                  .funs = funs(strip_comma(.))) %>%
        separate(name, into = c('county','stabbr'), sep = ',') %>%
        select(fips, county, stabbr, year, labor_force,
               employed, unemployed, unem_rate)

    ## store in list
    outlist[[y]] <- d
}

## combine outlist into one long dataframe; sort
df <- bind_rows(outlist) %>%
    arrange(fips, year)

## write data to disk
write_csv(df, path = 'county_unemploy.csv')

## =============================================================================
## END
################################################################################
