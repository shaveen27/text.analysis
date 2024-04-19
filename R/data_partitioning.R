#' Data partitioning for train and test cross validation
#'
#' @description
#' The partition function is designed to create training and testing data
#' matrices using the model matrix generated from final_model_matrix. These
#' matrices are then used to train and validate the fitted model.
#'
#' @param model_df final data frame created using `final_model_df`
#' function
#' @param prob probability of ham/spam messages to include in the train data.
#'
#' @return a list of both train and test data sets.
#'
#' @export
partition <- function(model_df, prob) {
  if (prob > 1) {
    stop("Probability can not be exceed 1.")
  }

  ### divide the model matrix into ham and spam data
  ham_data <- model_df[model_df[, 1] == "ham", ]
  spam_data <- model_df[model_df[, 1] == "spam", ]

  ### create partition using sample
  data_partition_ham <- sample(c(1, 0),
    size = nrow(ham_data), replace = TRUE,
    prob = c(prob, 1 - prob)
  )

  data_partition_spam <- sample(c(1, 0),
    size = nrow(spam_data),
    replace = TRUE, prob = c(prob, 1 - prob)
  )

  ### train and test data

  train <- rbind(
    ham_data[data_partition_ham == 1, ],
    spam_data[data_partition_spam == 1, ]
  )

  test <- rbind(
    ham_data[data_partition_ham == 0, ],
    spam_data[data_partition_spam == 0, ]
  )

  ### return a list of two data sets
  train_test_data <- list(train = train, test = test)

  return(train_test_data)
}
