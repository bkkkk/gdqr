# gdqr: Get Games Done Quick donation data

This package helps you download the donation data from the Games Done Quick events. The package
fetches the data directly from the [GDQ](http://gamesdonequick.com/) site and even contains a tidying
function to clean up the data so it's ready for analysis.

This package is in pre-Alpha stage.

## Installation

Package is not available on CRAN. To install it from Github:

    devtools::install_github("bkkkk/gdqr", ref = "develop")

## Usage

In order to obtain all data for SGDQ2015 and tidy it:

    library(gdqr)
    raw_sgdq2015 <- fetch_event_donations(event = "sgdq2015")
    tidy_sgdq2015 <- tidy_donations(raw_sgdq2015)

### Available events

At the moment the following events are available:

    event <- c("cgdq", "agdq2011", "jrdq", "sgdq2011", "agdq2012", "sgdq2012",
               "spook", "agdq2013", "sgdq2013", "agdq2014", "sgdq2014", "agdq2015",
               "sgdq2015", "agdq2016", "sgdq2016")

The `event` argument of the `fetch_*` functions in the package refers to any one of the names above.

### Dealing with pagination

The GDQ donation tracker displays a maximum of 50 donations per page. gdqr lets you download donation information from a range of pages.

The following commands will download all donations from pages 10 to 20, pages 10 and onwards, and up to page 20, respectively. 

    raw_sgdq2015 <- fetch_event_donations("sgdq2015", min_page = 10, max_page = 20)
    raw_sgdq2015 <- fetch_event_donations("sgdq2015", min_page = 10)
    raw_sgdq2015 <- fetch_event_donations("sgdq2015", max_page = 20)

Note that the donations are downloaded in time order so the first page contains the earliest donations and the last page contains the last donations made towards the end of the event.

## Todo

* [x] Add support for fetching runs data
* [ ] Add support for fetching bid data
* [ ] Add support for fetching prizes data
* [ ] Have a better way of dealing with event codenames
