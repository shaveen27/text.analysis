#' Explore Text Data for email_list
#'
#' This function performs initial exploratory data analysis on text data
#' contained within an email_list object.
#' It returns a list containing summary statistics, distributions of categories,
#' message lengths, word counts, and checks for missing values.
#'
#' @param email_list_obj An object of class `email_list`.
#' @return A list containing the results of the data exploration.
#' @export
#'
#' @importFrom dplyr %>%
#' @importFrom tidyr %>%
#'
#' @examples
#' data <- data.frame(category = c("ham", "spam"), message = c(
#'   "Hello world",
#'   "Buy now"
#' ))
#' email_data <- email_list(data)
#' explore_data(email_data)
explore_data <- function(email_list_obj) {
  # Ensure that the object is of class 'email_list'
  if (!inherits(email_list_obj, "email_list")) {
    stop("The provided object is not a valid 'email_list' object.")
  }

  # Extract the vectors from the email_list object
  categories <- email_list_obj[[1]]
  messages <- email_list_obj[[2]]

  # Data Description
  category_distribution <- table(categories)
  message_lengths <- nchar(messages)
  word_counts <- sapply(strsplit(messages, "\\s+"), length)

  # Structure of the Data
  missing_data_categories <- sum(is.na(categories))
  missing_data_messages <- sum(is.na(messages))

  # Compile results into a list
  results <- list(
    category_distribution = category_distribution,
    message_length_summary = summary(message_lengths),
    word_count_summary = summary(word_counts),
    missing_data_categories = missing_data_categories,
    missing_data_messages = missing_data_messages,
    message_lengths = message_lengths,
    word_counts = word_counts
  )

  return(results)
}
