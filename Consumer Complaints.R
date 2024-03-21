library(dplyr)
library(tidytext)
library(stringr)
library(tidyr)
library(ggplot2)
library(wordcloud)
library(RColorBrewer)
library(reshape2)

get_sentiments("bing")
get_sentiments("nrc")


setwd('C:/Users/timot/OneDrive/Augustana/Junior year/Spring semester/DATA 332/Data')

consumer_complaints <- read.csv('Consumer_Complaints.csv')


consumer_complaints_narrative_filtered <- consumer_complaints %>%
  filter(Consumer.complaint.narrative != "")


num_complaint_per_product <- consumer_complaints_narrative_filtered %>%
  group_by(Product) %>%
  summarize(count_complaints_per_product = n())


tidy_consumer_complaints <- consumer_complaints_narrative_filtered %>%
  select(Complaint.ID, Consumer.complaint.narrative, Product, State) %>%
  mutate(row_number = row_number()) %>%
  unnest_tokens(word, Consumer.complaint.narrative)

tidy_consumer_complaints %>%
  anti_join(stop_words) %>%
  filter(word != "xxxx") %>%
  count(word) %>%
  with(wordcloud(word, n, max.words = 100))

consumer_narrative_sentiment_bing <- tidy_consumer_complaints %>%
  inner_join(get_sentiments("bing"), by = "word") %>%
  count(Complaint.ID, sentiment, Product, State) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative) 


sentiment_per_product_bing <- consumer_narrative_sentiment_bing %>%
  group_by(Product) %>%
  summarize(total_sentiment = sum(sentiment))

sentiment_per_state_bing <- consumer_narrative_sentiment_bing %>%
  group_by(State) %>%
  summarize(total_sentiment = sum(sentiment))

ggplot(sentiment_per_state_bing, aes(x = State, y = total_sentiment)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Total bing Sentiment by State",
       x = "State",
       y = "Total bing sentiment") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(sentiment_per_product_bing, aes(x = Product, y = total_sentiment)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  coord_flip() +
  labs(title = "Total bing sentiment per Product",
       x = "Products",
       y = "Total bing sentiment") +
  theme_minimal()

consumer_narrative_sentiment_nrc <- tidy_consumer_complaints %>%
  inner_join(get_sentiments("nrc"), by = "word") %>%
  count(Complaint.ID, sentiment, Product, State) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment_score = joy - fear - negative - positive - sadness - surprise - trust - anger)

sentiment_per_product_nrc <- consumer_narrative_sentiment_nrc %>%
  group_by(Product) %>%
  summarize(total_sentiment = sum(sentiment_score))

sentiment_per_state_nrc <- consumer_narrative_sentiment_nrc %>%
  group_by(State) %>%
  summarize(total_sentiment = sum(sentiment_score))

ggplot(sentiment_per_product_nrc, aes(x = Product, y = total_sentiment)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  coord_flip() +
  labs(title = "Total nrc sentiment per Product",
       x = "Products",
       y = "Total nrc sentiment") +
  theme_minimal()

ggplot(sentiment_per_state_nrc, aes(x = State, y = total_sentiment)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Total nrc Sentiment by State",
       x = "State",
       y = "Total nrc sentiment") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
