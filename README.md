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
To get rid of all the complaints that didn't have a narrative, I ran a filter to keep only the rows that have a narrative because I wanted to run my sentiment analysis on these narratives.
```
consumer_complaints_narrative_filtered <- consumer_complaints %>%
  filter(Consumer.complaint.narrative != "")
```

   



