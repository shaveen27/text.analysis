#' Function to Create Word Clouds for all dataset
#'
#' @description
#' This function will explore the dataset with word clouds. It will provide a
#' visualization of the frequency of words in our corpus.
#'
#' @param corpus clean text data file
#' @param min_freq words with minimum frequency to plot (default : 1)
#' @param max_words maximum number of words should be plotted (default:30)
#'
#' @details
#' Exploring the dataset with word clouds. This will show the frequency of words
#' in our dataset. The larger the font size is in the word cloud, the more
#' frequently a word appears.
#'
#' @import tm wordcloud
#'
#' @examples
#' # raw data as a data frame
#' df_raw <- data.frame(
#'   type = c("ham", "spam", "ham", "ham", "spam"),
#'   message = c(
#'     "Hey there! how is your day going",
#'     "You have won a free vacation click here to claim your prize 2",
#'     "Reminder meeting today do not forget",
#'     "Just wanted to say hi and see how you are doing",
#'     "Your account has been compromised click here to update your password"
#'   )
#' )
#'
#' # input data list using `convert_mail_list`
#' ls <- convert_mail_list(df_raw)
#'
#' # clean raw data to get the corpus
#' ls_lower <- lower_case(ls)
#' ls_nonumber <- remove_numbers(ls_lower)
#' ls_nopunc <- remove_punctuations(ls_nonumber)
#' ls_nospace <- remove_whitespaces(ls_nopunc)
#' corpus <- remove_stopwords(ls_nospace)
#'
#' # visualize frequency of words with cleaned corpus
#'
#' wordcloud_all(corpus)
#'
#' @export

wordcloud_all <- function(corpus, min_freq = 1, max_words = 30) {
  df <- as.data.frame(table(unlist(strsplit(corpus$message, "\\s+"))))

  # use clean data: All messages
  wordcloud(
    words = df$Var1,
    freq = df$Freq,
    # minimum frequency of a word is present to show
    min.freq = min_freq,
    # maximum number of words to plot
    max.words = max_words,
    # most frequent words in the center of the wordcloud
    random.order = FALSE,
    # color font
    colors = c(
      "#00BFFF", "#836FFF", "#CAFF70", "#FF7F50", "#8B2323",
      "#fdae61", "#fee090", "#FF4040"
    )
  )
}

#' Function to Create Word Clouds for all Ham messages
#'
#' @description
#' This function will explore the "ham" dataset with word clouds. It will
#' provide a visualization of the frequency of words in our corpus.
#'
#' @param ham_set clean ham data file
#' @param min_freq words with minimum frequency to plot (default : 1)
#' @param max_words maximum number of words should be plotted (default:30)
#'
#' @details
#' Exploring the dataset with word clouds. This will show the frequency of words
#' in our "ham" dataset. The larger the font size is in the word cloud, the more
#' frequently a word appears.
#'
#' @import tm wordcloud
#'
#' @examples
#' # raw data as a data frame
#' df_raw <- data.frame(
#'   type = c("ham", "spam", "ham", "ham", "spam"),
#'   message = c(
#'     "Hey there! how is your day going",
#'     "You have won a free vacation click here to claim your prize 2",
#'     "Reminder meeting today do not forget",
#'     "Just wanted to say hi and see how you are doing",
#'     "Your account has been compromised click here to update your password"
#'   )
#' )
#'
#' # input data list using `convert_mail_list`
#' ls <- convert_mail_list(df_raw)
#'
#' # clean raw data to get the corpus
#' ls_lower <- lower_case(ls)
#' ls_nonumber <- remove_numbers(ls_lower)
#' ls_nopunc <- remove_punctuations(ls_nonumber)
#' ls_nospace <- remove_whitespaces(ls_nopunc)
#' corpus <- remove_stopwords(ls_nospace)
#'
#' # extract the ham data file
#' ham_set <- split_spamham(corpus)$Ham
#'
#' # visualize frequency of ham messages with cleaned ham data
#' wordcloud_ham(ham_set)
#'
#' @export
wordcloud_ham <- function(ham_set, min_freq = 1, max_words = 30) {
  df <- as.data.frame(table(unlist(strsplit(ham_set$message, "\\s+"))))
  # use clean data

  wordcloud(
    words = df$Var1,
    freq = df$Freq,
    # minimum frequency of a word is present to show
    min.freq = min_freq,
    # maximum number of words to plot
    max.words = max_words,
    # most frequent words in the center of the word cloud
    random.order = FALSE,
    scale = c(2.5, 0.5),
    # color font
    colors = c(
      "#4575b4", "#74add1", "#abd9e9", "#e0f3f8",
      "#fee090", "#fdae61", "#f46d43", "#d73027"
    )
  )
}

#' Function to Create Word Clouds for all Spam messages
#'
#' @description
#' This function will explore the "Spam" dataset with word clouds. It will
#' provide a visualization of the frequency of words in our corpus.
#'
#' @param spam_set clean spam data file
#' @param min_freq words with minimum frequency to plot (default : 1)
#' @param max_words maximum number of words should be plotted (default:30)
#'
#' @details
#' Exploring the dataset with word clouds. This will show the frequency of words
#' in our "Spam" dataset. The larger the font size is in the word cloud, the
#' more frequently a word appears.
#'
#' @import tm wordcloud
#'
#' @examples
#' # raw data as a data frame
#' df_raw <- data.frame(
#'   type = c("ham", "spam", "ham", "ham", "spam"),
#'   message = c(
#'     "Hey there! how is your day going",
#'     "You have won a free vacation click here to claim your prize 2",
#'     "Reminder meeting today do not forget",
#'     "Just wanted to say hi and see how you are doing",
#'     "Your account has been compromised click here to update your password"
#'   )
#' )
#'
#' df_raw
#'
#' # input data list using `convert_mail_list`
#' ls <- convert_mail_list(df_raw)
#'
#' # clean raw data to get the corpus
#' ls_lower <- lower_case(ls)
#' ls_nonumber <- remove_numbers(ls_lower)
#' ls_nopunc <- remove_punctuations(ls_nonumber)
#' ls_nospace <- remove_whitespaces(ls_nopunc)
#' corpus <- remove_stopwords(ls_nospace)
#'
#' # extract the spam data file
#' spam_set <- split_spamham(corpus)$Spam
#'
#' # visualize frequency of ham messages with cleaned ham data
#' wordcloud_spam(spam_set)
#'
#' @export
wordcloud_spam <- function(spam_set, min_freq = 1, max_words = 30) {
  df <- as.data.frame(table(unlist(strsplit(spam_set$message, "\\s+"))))

  # use clean data
  wordcloud(
    words = df$Var1,
    freq = df$Freq,
    # minimum frequency of a word is present to show
    min.freq = min_freq,
    # maximum number of words to plot
    max.words = max_words,
    # most frequent words in the center of the wordcloud
    random.order = FALSE,
    # color font
    colors = c(
      "#00BFFF", "#836FFF", "#CAFF70", "#FF7F50", "#8B2323",
      "#fdae61", "#fee090", "#CD1076"
    )
  )
}

#' Function to split into spam and ham subsets
#'
#' @description
#' This function splits the corpus into two subsets: spam and ham.
#'
#' @param data corpus file
#'
#' @examples
#' # raw data as a data frame
#' df_raw <- data.frame(
#'   type = c("ham", "spam", "ham", "ham", "spam"),
#'   message = c(
#'     "Hey there! how is your day going",
#'     "You have won a free vacation click here to claim your prize 2",
#'     "Reminder meeting today do not forget",
#'     "Just wanted to say hi and see how you are doing",
#'     "Your account has been compromised click here to update your password"
#'   )
#' )
#'
#' df_raw
#'
#' # input data list using `convert_mail_list`
#' ls <- convert_mail_list(df_raw)
#'
#' # clean raw data to get the corpus
#' ls_lower <- lower_case(ls)
#' ls_nonumber <- remove_numbers(ls_lower)
#' ls_nopunc <- remove_punctuations(ls_nonumber)
#' ls_nospace <- remove_whitespaces(ls_nopunc)
#' corpus <- remove_stopwords(ls_nospace)
#'
#' # split cleaned corpus into ham and spam data
#' split_spamham(corpus)
#'
#' @export
split_spamham <- function(data) {
  if (attr(data, "class") != "email_list") {
    stop("data should be a email_list object")
  }

  # dataset: category (ham, spam) and message (texts)
  corpus <- data

  # dataset: category (ham, spam) and message (texts)
  corpus <- data.frame(unclass(data))

  # split into spam and ham sets
  corpus_set <- data.frame(message = corpus$message)
  spam_set <- data.frame(message = corpus$message[corpus$category == "spam"])
  ham_set <- data.frame(message = corpus$message[corpus$category == "ham"])

  return(list(
    Data = corpus_set,
    Spam = spam_set,
    Ham = ham_set
  ))
}
