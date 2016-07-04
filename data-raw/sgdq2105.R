library(rvest)
library(hrbrmisc)
library(urltools)
library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)




save(raw_sgdq_donations, file = "data/sgdq2015.Rdata")


tidy_sgdq_donations <- rename(raw_sgdq_donations, donator = NameAscDsc, date = `Time ReceivedAscDsc`, amount = AmountAscDsc, comment = Comment)
tidy_sgdq_donations <- tbl_df(tidy_sgdq_donations)
tidy_sgdq_donations <- mutate(tidy_sgdq_donations, comment = if_else(comment == "Yes", TRUE, FALSE))
tidy_sgdq_donations <- mutate(tidy_sgdq_donations, amount = gsub(",", "", amount))
tidy_sgdq_donations <- mutate(tidy_sgdq_donations, amount = gsub("\\$", "", amount))
tidy_sgdq_donations <- mutate(tidy_sgdq_donations, amount = as.numeric(amount))
tidy_sgdq_donations <- mutate(tidy_sgdq_donations, date = mdy_hms(date))

cumsum_data <- donations_after_start %>%
  arrange(date) %>%
  mutate(sum = cumsum(amount))



ggplot() +
  geom_line(data = cumsum_data, aes(date, sum)) +
  geom_text(data = sgdq2016_schedule, aes(x = start_time, y = 50000, label = game), nudge_x = 10, angle = 90) +
  geom_rect(data = sgdq2016_schedule,
            aes(ymin = -Inf,
                ymax = Inf,
                xmin = lag(start_time),
                xmax = start_time,
                fill = as.factor(game)), inherit.aes = F, alpha = 0.5) +
  theme_hrbrmstr() + theme(legend.position = "")

  labs(x = "Time", y = "Total in donations [$]", title = "SGDQ 2016, the story so far",
       caption = "source: gamesdonequick.com/donations/sgdq2016")

tidy_sgdq_donations %>%
  ggplot(aes(amount, fill = comment)) + geom_histogram() + theme_hrbrmstr() +
  labs(x = "Time", y = "Total in donations [$]", title = "SGDQ 2016, the story so far",
       caption = "source: gamesdonequick.com/donations/sgdq2016")

data("sgdq2016_schedule")
