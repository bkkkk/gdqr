library(rvest)
library(dplyr)
library(lubridate)

schedule_url <- "https://gamesdonequick.com/schedule"

schedule_page <- read_html(schedule_url)

sgdq_table <- tbl_df(html_table(schedule_page, fill = T, header = T)[[1]])

extra_info_rows <- seq(2, nrow(sgdq_table), 2)

main_frame <- sgdq_table[-extra_info_rows, ]

extra_info_frame <- sgdq_table[extra_info_rows, ]
length_col <- c(extra_info_frame$`Time & Length`, NA)
run_type_col <- c(extra_info_frame$Run, NA)

sgdq2016_schedule <- transmute(
  main_frame,
  start_time = ymd_hms(`Time & Length`),
  game = Run,
  run_type = run_type_col,
  runners = Runners,
  length = period_to_seconds(hms(length_col))
)

use_data(sgdq2016_schedule, overwrite = TRUE)
