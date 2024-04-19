#' Function to Create Word Clouds for all dataset
#'
#' @description
#' This function will explore the dataset with word clouds. It will provide a
#' visualization of the frequency of words in our corpus.
#'
#' @param file clean text data file
#'
#' @details
#' Exploring the dataset with word clouds. This will show the frequency of words
#' in our dataset. The larger the font size is in the word cloud, the more
#' frequently a word appears.
#'
#' @import tm wordcloud
#'
#' @export
wordcloud_all <- function(data) {
  #use clean data: All messages
  corpus <- data
  wordcloud(words = corpus$message,
            #minimum frequency of a word is present to show
            min.freq = 100,
            #most frequent words in the center of the wordcloud
            random.order = FALSE,
            #color font
            colors = c("#00BFFF", "#836FFF", "#CAFF70", "#FF7F50", "#8B2323",
                       "#fdae61", "#fee090", "#FF4040"),
            title = "Dataset Wordcloud")
}

#' Function to Create Word Clouds for all Ham messages
#'
#' @description
#' This function will explore the "ham" dataset with word clouds. It will
#' provide a visualization of the frequency of words in our corpus.
#'
#' @param ham_set clean ham data file
#'
#' @details
#' Exploring the dataset with word clouds. This will show the frequency of words
#' in our "ham" dataset. The larger the font size is in the word cloud, the more
#' frequently a word appears.
#'
#' @import tm wordcloud
#'
#' @export
wordcloud_ham <- function(ham_set) {
  #use clean data
  wordcloud(words = ham_set,
            #minimum frequency of a word is present to show
            min.freq = 50,
            #most frequent words in the center of the word cloud
            random.order = FALSE,
            #color font
            colors = c("#4575b4", "#74add1", "#abd9e9", "#e0f3f8",
                       "#fee090", "#fdae61", "#f46d43", "#d73027"),
            main = "Ham Wordcloud")
}

#' Function to Create Word Clouds for all Spam messages
#'
#' @description
#' This function will explore the "Spam" dataset with word clouds. It will
#' provide a visualization of the frequency of words in our corpus.
#'
#' @param spam_set clean spam data file
#'
#' @details
#' Exploring the dataset with word clouds. This will show the frequency of words
#' in our "Spam" dataset. The larger the font size is in the word cloud, the
#' more frequently a word appears.
#'
#' @import tm wordcloud
#'
#' @export
wordcloud_spam <- function(spam_set) {
  #use clean data
  wordcloud(words = spam_set,
            #minimum frequency of a word is present to show
            min.freq = 50,
            #most frequent words in the center of the wordcloud
            random.order = FALSE,
            #color font
            colors = c("#00BFFF", "#836FFF", "#CAFF70", "#FF7F50", "#8B2323",
                       "#fdae61", "#fee090", "#CD1076"),
            title = "Spam Wordcloud")
}

#' Function to split into spam and ham subsets
#'
#' @description
#' This function splits the corpus into two subsets: spam and ham.
#'
#' @param file corpus file
#'
#' @export
split_spamHam <- function(data) {
  #dataset: category (ham, spam) and message (texts)
  data <- data.frame(data)
  #split into spam and ham sets
  spam_set <- data.frame(message = corpus$message[corpus$category == "spam"])
  ham_set <- data.frame(message = corpus$message[corpus$category == "ham"])
}
