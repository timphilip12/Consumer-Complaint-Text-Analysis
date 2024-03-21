# Consumer Complaint Text Analysis
## Introduction
This is a repo for my findings after running a sentiment analysis on consumer complaints using the sentiment analyses bing and nrc. 
## Dictionnary
The data used was from the excel file Consumer_Complaints.csv. 
### The columns used were: 
1. Product: the type of product on which the complaint was addressed
2. Consumer.complaint.narrative: an more detailed explaination on what the complaint was
3. Consumer.ID: an unique ID for each complaint
4. State: the state in which the customer is located
## Data cleaning
1. To get rid of all the complaints that didn't have a narrative, I ran a filter to keep only the rows that have a narrative because I wanted to run my sentiment analysis on these narratives.
```
consumer_complaints_narrative_filtered <- consumer_complaints %>%
  filter(Consumer.complaint.narrative != "")
```
2. In order to run a sentiment analysis, I had to make the data tidy which means that each words from the narrative will be a row.
   ```
   tidy_consumer_complaints <- consumer_complaints_narrative_filtered %>%
     select(Complaint.ID, Consumer.complaint.narrative, Product, State) %>%
     mutate(row_number = row_number()) %>%
     unnest_tokens(word, Consumer.complaint.narrative)
   ```
## Wordcloud
As I wanted to have an idea of what words were appearing the most frequently, I created a wordcloud so I could visualize the most occuring words. I filtered out the word "xxxx" as it was occuring too many times and it isn't an actual word.

<img src="Images/Complaints cloud.png" height = 300, width = 400>

## Sentiment Analysis

### Bing analysis
I first ran a bing analysis on the data after grouping them by product type and by state. 
### Total sentiment per product using bing sentiment analysis

<img src="Images/Bing sentiment per product.png" height = 300, width = 400>

### Total sentiment per State using bing sentiment analysis

<img src="Images/Bing sentiment per State.png" height = 300, width = 800>

### nrc analysis 
Then, I ran a nrc analysis on the data using the same grouping (by product and by state).

### Total sentiment per product using nrc sentiment analysis

<img src="Images/nrc sentiment per product.png" height = 300, width = 400>

### Total sentiment per State using nrc sentiment analysis

<img src="Images/nrc sentiment per state.png" height = 300, width = 800>

## Conclusion
I can conclude that the sentiment analysis on the narrative of the consumer complaints is overall negative. For both, Bing and nrc, the result are way negative. The Bing and the nrc shapes look very similar with both sentiment per product and sentiment per state with way bigger values for the nrc. 
   



