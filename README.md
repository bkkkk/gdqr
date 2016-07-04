# sgdq2016: Data about Summer Games Done Quick 2016

This package contains datasets associated with the gaming event [SGDQ2016](www.gamesdonequick.com). For now it only has information on the expected pre-event schedule. Once the event start I will see if I can retrieve the donations data. Maybe even add some metadata on the games.

## Installation

This package is not on CRAN. To install it from Github:

    devtools::install_github("bkkkk/sgdq2016")

## Use

To list all the datasets in the package with their documentation:

    library(sgdq2016)
    help(package = sgdq2016)

To load a dataset:

    data(sgdq2016_schedule)