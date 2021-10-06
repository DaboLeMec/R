##genius R Package Demo for Analyzing Blue Scholars Lyrics

library(genius)
library(dplyr)
library(tidytext)
library(ggplot2)
library(wordcloud)

##list of blue Scholars Albums
artist_albums <- tribble(
  ~artist, ~album,
  "Blue Scholars", "The Long March",
  "Blue Scholars", "Bayani Redux",
  "Blue Scholars", "Blue Scholars",
  "Blue Scholars", "Cinemetropolis",
  "Blue Scholars", "OOF!"
)
##get all the lyrics for all the tracks on the albums from the genius R Package
Bluegawd <- artist_albums %>%
  add_genius(artist, album, type = "album")


##Format to one word per line
Bluegawd <- Bluegawd %>%
  unnest_tokens(word, lyric)

##Exclude stop words (And, the, but etc.)
Bluegawd <- Bluegawd %>%
  anti_join(stop_words)

##Wordcloud Plot
Bluegawd %>%
  anti_join(stop_words) %>%
  count(word) %>%
  with(wordcloud(word, n, max.words = 100))
##FacetWrap(album)

##Horizontal bar Plot for words in lyrics with >26 Occurrences
Bluegawd %>%
  count(word, sort = TRUE) %>%
  filter(n > 10) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word)) +
  geom_col() +
  labs(y = "Word",x = "Ocurrences")


