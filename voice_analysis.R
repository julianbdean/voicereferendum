

# packages
library(eechidna) ### https://cran.r-project.org/web/packages/eechidna/vignettes/eechidna-intro.html
library(tidyverse)

#data
data(abs2016)

# voice results from here: "https://www.theguardian.com/australia-news/ng-interactive/2023/oct/14/live-voice-referendum-results-2023-tracker-australia-yes-no-votes-by-state-australian-indigenous-voice-to-parliament-who-won-is-winning-winner-map-counts-aec-latest-result"
#.as of evening of oct 14
results <- read_excel("~/Desktop/referendum_analysis/results.xlsx")
results$Electorate <- str_trim(toupper(results$Electorate))

# wrangle and plot


results %>% select(Electorate, `Yes (%)`) %>%
  inner_join((abs2016 %>% select(DivisionNm, Indigenous)), 
                                                         by = c("Electorate" = "DivisionNm")) %>%
  ggplot() +
  geom_point(aes(x = log(Indigenous+1), y = `Yes (%)`)) +
  geom_smooth(aes(x = log(Indigenous+1), y = `Yes (%)`), method = 'lm', color = 'red') +
  geom_hline(yintercept = 50, linetype = 'dashed', color = 'blue') +
  theme_classic()


results %>% select(Electorate, `Yes (%)`) %>%  inner_join((abs2016 %>% select(DivisionNm, Indigenous)), 
                                                          by = c("Electorate" = "DivisionNm")) %>%
  ggplot() +
  geom_point(aes(x = Indigenous, y = `Yes (%)`)) +
  geom_smooth(aes(x = Indigenous, y = `Yes (%)`), method = 'lm', formula = y ~ log(x+1), color = 'red') +
  geom_hline(yintercept = 50, linetype = 'dashed', color = 'blue') +
  xlab("Indigenous share (%)") +
  theme_classic()
