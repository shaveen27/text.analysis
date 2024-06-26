#' Function to make all messages to lower case
#'
#' @description
#' The function `lower_case` is design to make character vectors of
#' \link[text.analysis]{email_list} from upper to lower case to lower case
#' character vectors.
#'
#' @param x a \link[text.analysis]{email_list} object
#'
#' @return a \link[text.analysis]{email_list} object with lower case
#' characters.
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
#' # convert all the letters to lower case
#' lower_case(ls)
#'
#' @export
lower_case <- function(x) {
  if (attr(x, "class") != "email_list") {
    stop("x should be a email_list object")
  }

  x$category <- tolower(x$category)
  x$message <- tolower(x$message)

  x
}

#' Function to remove all numbers from messages
#'
#' @description
#' The function `remove_numbers` is design to remove all numbers from
#' \link[text.analysis]{email_list} character vectors.
#'
#' @param x a \link[text.analysis]{email_list} object
#'
#' @return a \link[text.analysis]{email_list} object with only letters
#' characters.
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
#' # remove all the numbers
#' remove_numbers(ls)
#'
#' @export
remove_numbers <- function(x) {
  # Check if the list is an email_list object
  if (attr(x, "class") != "email_list") {
    stop("x should be a email_list object")
  }

  # Remove numbers
  x$category <- gsub("[[:digit:]]+", "", x$category)
  x$message <- gsub("[[:digit:]]+", "", x$message)

  x
}

#' Function to remove all punctuations from messages
#'
#' @description
#' The function `remove_punctuations` is design to remove all punctuations from
#' \link[text.analysis]{email_list} character vectors.
#'
#' @param x a \link[text.analysis]{email_list} object
#'
#' @return a \link[text.analysis]{email_list} object with only letters
#' characters.
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
#' # remove all the punctuations
#' remove_punctuations(ls)
#'
#' @export
remove_punctuations <- function(x) {
  # Check if the list is an email_list object
  if (attr(x, "class") != "email_list") {
    stop("x should be a email_list object")
  }

  # Remove punctuations
  x$category <- gsub("[[:punct:] ]+", " ", x$category)
  x$message <- gsub("[[:punct:] ]+", " ", x$message)

  x
}

#' Function to remove extra white spaces from messages
#'
#' @description
#' The function `remove_whitespaces` is design to remove all extra white spaces
#'  from \link[text.analysis]{email_list} character vectors.
#'
#' @param x a \link[text.analysis]{email_list} object
#'
#' @return a \link[text.analysis]{email_list} object with only letters
#' characters.
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
#' # remove white spaces
#' remove_whitespaces(ls)
#'
#' @export
remove_whitespaces <- function(x) {
  # Check if the list is an email_list object
  if (attr(x, "class") != "email_list") {
    stop("x should be a email_list object")
  }

  # Remove extra white spaces in the middle of a string
  x$category <- gsub("\\s+", " ", x$category)
  x$message <- gsub("\\s+", " ", x$message)

  # Remove extra white spaces in beginning or end of a string
  x$category <- gsub("^\\s+|\\s+$", "", x$category)
  x$message <- gsub("^\\s+|\\s+$", "", x$message)

  x
}

#' Function to remove stop words from messages
#'
#' @description
#' The function `remove_stopwords` is design to remove all  stop words
#'  from \link[text.analysis]{email_list} character vectors.
#'
#' @param x a \link[text.analysis]{email_list} object
#'
#' @return a \link[text.analysis]{email_list} object without stop words
#' characters.
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
#' # remove all the stop words
#' remove_stopwords(ls)
#'
#' @export
remove_stopwords <- function(x) {
  # Check if the list is an email_list object
  if (attr(x, "class") != "email_list") {
    stop("x should be a email_list object")
  }

  # Remove stop words
  message <- remove_stopword_cpp(strsplit(unclass(x)$message, " "), stopwords)

  email_list(list(category = unclass(x)$category, message = message))
}
