#' Function to create Final model matrix
#'
#' @description
#' The function `final_model_df` is designed to create the
#' model matrix to use modelling process. It transforms each unique word in a
#' message into a variable, tallying the frequency of each word. The resulting
#' output of the function is a data frame where the initial column denotes the
#' message type, while the subsequent columns represent the words in the data
#' set.
#'
#' @param data cleaned corpus
#'
#' @param tol a positive integer value. Used to remove the columns
#' which the column sum less than tolerance.
#'
#' @return final_model_df, the data in a form of a data frame can be used for
#' modelling
#'
#' @examples
#' # cleaned corpus for `final_model_df`
#'
#' df <- list(
#'   type = c("ham", "spam", "ham", "ham", "spam"),
#'   message = c(
#'     "hey there how is your day going",
#'     "you have won a free vacation click here to claim your prize",
#'     "reminder meeting today do not forget",
#'     "just wanted to say hi and see how you are doing",
#'     "your account has been compromised click here to update your password"
#'   )
#' )
#'
#' # example data frame returned from `final_model_df`
#' final_model_df(df, 2)
#'
#' @export
final_model_df <- function(data, tol) {
  ### clean the data set and return a list of two; type and df

  if (tol < 0) {
    stop("tol should be a positive integer value")
  }

  if (ceiling(tol) != tol) {
    message("tol should be an interger value")
    tol <- ceiling(tol)
  }

  clean_data <- clean_data_modelling(data)

  ham_or_spam <- clean_data[[1]]
  df <- clean_data[[2]]

  ### identify unique words outof the messages
  unique_words <- unique(do.call(rbind, df)$word)

  len_unique_words <- length(unique_words)

  ### create a matrix and storing data
  data_matrix_model <- matrix(nrow = length(df), ncol = len_unique_words)

  ### identify positions of words
  pos <- lapply(df, function(x) which(unique_words %in% x$word))

  ### filling the matrix according to positions
  for (i in seq_along(pos)) {
    if (sum(pos[[i]]) == 0) {
      data_matrix_model[i, ] <- 0
    } else {
      data_matrix_model[i, pos[[i]]] <- df[[i]]$n
      data_matrix_model[i, -pos[[i]]] <- 0
    }
  }

  ### change column names
  colnames(data_matrix_model) <- unique_words

  ### remove columns total frequency is less than tolerance
  final_model_mat <- data_matrix_model[, colSums(data_matrix_model) > tol]

  ### create final model matrix for modelling
  final_model_df <- cbind(ham_or_spam, as.data.frame(final_model_mat))

  return(final_model_df)
}

clean_data_modelling <- function(data) {
  ### convert the list into a data frame
  df_final <- data.frame(category = data[[1]], message = data[[2]])

  df <- list()
  n <- nrow(df_final)

  # Tokanize the words, iterate over each row of df_final
  for (i in 1:n) {
    # Tokenize the text in the message_ column of the current row into new
    # column called word
    word <- ""

    new <- df_final[i, ] |>
      tidytext::unnest_tokens(word, message) |>
      dplyr::count(word)

    # Combine the category with the new data frame
    df[[i]] <- new
  }

  type <- df_final$category

  return(list(type, df))
}
