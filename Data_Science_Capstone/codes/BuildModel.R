# text mining
library(tm)
# N-GramS vector generation
library(RWeka)
# plotting figures 
library(ggplot2)
# string functions
library(stringr)

# set the working directory
setwd("F:/Courses/Coursera/Data Science Speialization/RProjects/Coursera/Data_Science_Capstone")

# read blogs data
con <- file("./data/en_US.blogs.txt", "r") 
blogs <- readLines(con) 
close(con)

# read news data
con <- file("./data/en_US.news.txt", "r")
news <- readLines(con)
close(con)

# read twitter data
con <- file("./data/en_US.twitter.txt", "r")
twitter <- readLines(con)
close(con)

# read profane words
con <- file("./data/bad_words.txt", "r") 
bad_words <- readLines(con)
close(con)

## sample the Data
set.seed(123)
blogs_sample <- sample(blogs, size=round(length(blogs)*0.01))
news_sample <- sample(news, size=round(length(news)*0.01))
twitter_sample <- sample(twitter, size=round(length(twitter)*0.01))

# save the sampled data
write.csv(blogs_sample, file="./data/en_US.blog_sample.csv")
write.csv(news_sample, file="./data/en_US.news_sample.csv")
write.csv(twitter_sample, file="./data/en_US.twitter_sample.csv")
data_merged <- c(blogs_sample, news_sample, twitter_sample)

# clean up the data
cleanUp <- function(data) {
data <- gsub("/|@|\\|", " ", data, perl = TRUE)    
data <- gsub("\xe2\x80\x99", "'", data, perl=TRUE)
data <- gsub("\u000A|\u0027|\u0060|\u0091|\u0092|\u0093|\u0094|\u2019", "'", data, perl=TRUE)
data <- iconv(data, "UTF-8", "ASCII", "?")
data <- gsub("[^[:alpha:][:space:]'-]", " ", data)
data <- gsub("(?<!\\w)[-'](?<!\\w)" , " ", data, perl=TRUE)      
                       data <- gsub("[[:space:]]+", " ", data, perl=TRUE)
                       data <- gsub("^[[:space:]]+", "", data, perl=TRUE)   
                       data <- tolower(data)    
                       return(data)
}
data_merged <- cleanUp(data_merged)

# generate the corpus
data_corpus <- Corpus(VectorSource(data_merged))

# further processing on the corpus
tm_processing <- function(data, profane) {
data <- tm_map(data, content_transformer(tolower))
data <- tm_map(data, removeNumbers)
data <- tm_map(data, removePunctuation) 
data <- tm_map(data, removeWords, profane)
data <- tm_map(data, stemDocument, language = "english")
data <- tm_map(data, stripWhitespace) 
return(data)
}
# remove profane words
data_corpus <- tm_processing(data_corpus, bad_words)

# generate the tokenizers
bi_tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
tri_tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
quad_tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))

# Uni-Gram
tdm1gram <- TermDocumentMatrix(data_corpus)
tdm1gram <- removeSparseTerms(tdm1gram, 0.999)

# Bi-Grams
tdm2gram <- TermDocumentMatrix(data_corpus, control = list(tokenize = bi_tokenizer))
tdm2gram <- removeSparseTerms(tdm2gram, 0.999)

# Tri-Grams
tdm3gram <- TermDocumentMatrix(data_corpus, control = list(tokenize = tri_tokenizer))
tdm3gram <- removeSparseTerms(tdm3gram, 0.9995)

# Quad-Grams
tdm4gram <- TermDocumentMatrix(data_corpus, control = list(tokenize = quad_tokenizer))
tdm4gram <- removeSparseTerms(tdm4gram, 0.9999)

# convert dataframe to Hash
dfToHash <- function(df) {
  hash <- new.env(hash=TRUE, parent=emptyenv())
  for (ii in rev(seq(nrow(df)))) {
    key <- gsub(" ", "_", df[ii, 'predictor'])
    value <- df[ii, 'prediction']
    #cat (key, "<-", value, "\n")
    hash[[key]] <- value
  }
  hash
}

# build n-grams prediction model
df1gram <- as.data.frame(inspect(tdm1gram))
df1gram$num <- rowSums(df1gram)
df1gram <- subset(df1gram, num > 1)
df1gram$prediction <- row.names(df1gram)
df1gram$predictor <- ""
df1gram <- subset(df1gram, select=c('predictor', 'prediction', 'num'))
df1gram <- df1gram[order(df1gram$predictor,-df1gram$num),]
row.names(df1gram) <- NULL

df2gram <- as.data.frame(inspect(tdm2gram))
df2gram$num <- rowSums(df2gram)
df2gram <- subset(df2gram, num > 1)
df2gram[c('predictor', 'prediction')] <- subset(str_match(row.names(df2gram), "(.*) ([^ ]*)"), select=c(2,3))
df2gram <- subset(df2gram, select=c('predictor', 'prediction', 'num'))
df2gram <- df2gram[order(df2gram$predictor,-df2gram$num),]
row.names(df2gram) <- NULL

predict2hash <- dfToHash(df2gram)

df3gram <- as.data.frame(inspect(tdm3gram))
df3gram$num <- rowSums(df3gram)
df3gram <- subset(df3gram, num > 1)
df3gram[c('predictor', 'prediction')] <- subset(str_match(row.names(df3gram), "(.*) ([^ ]*)"), select=c(2,3))
df3gram <- subset(df3gram, select=c('predictor', 'prediction', 'num'))
df3gram <- df3gram[order(df3gram$predictor,-df3gram$num),]
row.names(df3gram) <- NULL

predict3hash <- dfToHash(df3gram)

df4gram <- as.data.frame(inspect(tdm4gram))
df4gram$num <- rowSums(df4gram)
df4gram <- subset(df4gram, num > 1)
df4gram[c('predictor', 'prediction')] <- subset(str_match(row.names(df4gram), "(.*) ([^ ]*)"), select=c(2,3))
df4gram <- subset(df4gram, select=c('predictor', 'prediction', 'num'))
df4gram <- df4gram[order(df4gram$predictor,-df4gram$num),]
row.names(df4gram) <- NULL

predict4hash <- dfToHash(df4gram)

# save results
save(predict2hash, file='./data/predict2hash.RData')
save(predict3hash, file='./data/predict3hash.RData')
save(predict4hash, file='./data/predict4hash.RData')