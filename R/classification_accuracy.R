count_convert_fct <- function(x) {
  # If count greater than 1 convert to 1
  x <- ifelse(x > 0, 1, 0)

  # Factorize the predictor columns
  x <- factor(x, levels = c(0, 1), labels = c("No", "Yes"))

  return(x)
}

count_convert_num <- function(x) {
  # If count greater than 1 convert to 1
  x <- ifelse(x > 0, 1, 0)

  return(x)
}

#' Naive - Bayes Classification Accuracy Measures
#'
#' @description
#' This function is designed to compute accuracy measures for email data set
#'  using Naive Bayes classification model. This function return the model,
#'  confusion matrix and accuracy measures.
#'
#' @param data list of length 2 from \link[text.analysis]{partition}
#' @param laplace description positive double controlling Laplace smoothing.
#'  The default (0) disables Laplace smoothing.
#' @param ... futher parameters from \link[e1071]{naiveBayes} function
#'
#' @importFrom e1071 naiveBayes
#'
#' @return \link[base]{list} with length 3
#'
#' @export
nb_classification <- function(data, laplace = 0, ...){

  # Convert the train set
  train <- data.frame("category" = as.factor(data$train[,1]),
                      apply(data$train[,-1], MARGIN = 2, count_convert_fct))

  # Convert the test set
  test <-  data.frame("category" = as.factor(data$test[,1]),
                      apply(data$test[,-1], MARGIN = 2, count_convert_fct))

  # Fit the Naive - Bayes model
  nb_model <- naiveBayes(category ~ ., data = train ,laplace = laplace, ...)
  nb_pred <- predict(nb_model, test)

  # Confusion matrix
  tab <- table(nb_pred,test$category)

  # Calculate accuracy measures
  Accuracy <- paste0(round(100*sum(diag(tab))/sum(tab),2),"%")
  Precision <- tab[2,2]/(tab[2,2] + tab[2,1])
  Recall <- tab[2,2]/(tab[2,2] + tab[1,2])
  F1_Score <- round(2*Precision*Recall/(Precision + Recall),2)

  list(Model = nb_model,
       Confusion_Matrix = tab,
       Accuracy_Measures = data.frame(Accuracy,
                                      Precision = round(Precision,2),
                                      Recall = round(Recall,2),
                                      F1_Score))
}

#' SVM Classification Accuracy Measures
#'
#' @description
#' This function is designed to compute accuracy measures for email data set
#'  using Support Vector Machine classification model. This function return the
#'  model, confusion matrix and accuracy measures.
#'
#' @param data list of length 2 from \link[text.analysis]{partition}
#' @param kernel the kernel used in training and predicting. You might consider
#'  changing some of the following parameters, depending on the kernel type.
#' @param gamma parameter needed for all kernels except linear
#'  (default: 1/(data dimension))
#' @param cost cost of constraints violation (default: 1)—it is the
#'  'C'- constant of the regularization term in the Lagrange formulation.
#' @param ... futher parameters from \link[e1071]{svm} function
#'
#' @importFrom e1071 svm
#'
#' @return \link[base]{list} with length 3
#'
#' @export
svm_classification <- function(data, kernel = "radial",
                               gamma = 1/ncol(data$train), cost = 1, ...){

  # Convert the train set
  train <- data.frame("category" = as.factor(data$train[,1]),
                      apply(data$train[,-1], MARGIN = 2, count_convert_num))

  # Convert the test set
  test <-  data.frame("category" = as.factor(data$test[,1]),
                      apply(data$test[,-1], MARGIN = 2, count_convert_num))

  # Fit the RBF kernel and linear kernel models
  if(kernel == "radial"){
    svm_model <- svm(category ~ ., data = train ,kernel = kernel,
                         cost = 1, gamma = 1/(ncol(data) - 1),
                         scale = FALSE)
    svm_pred <- predict(svm_model, test)

    # Confusion matrix
    tab <- table(svm_pred,test$category)
  }else if(kernel == "linear"){
    svm_model <- svm(category ~ ., data = train ,kernel = kernel,
                         scale = FALSE, cost = cost)
    svm_pred <- predict(svm_model, test)

    # Confusion matrix
    tab <- table(svm_pred,test$category)
  }

  # Calculate accuracy measures
  Accuracy <- paste0(round(100*sum(diag(tab))/sum(tab),2),"%")
  Precision <- tab[2,2]/(tab[2,2] + tab[2,1])
  Recall <- tab[2,2]/(tab[2,2] + tab[1,2])
  F1_Score <- round(2*Precision*Recall/(Precision + Recall),2)

  list(Model = svm_model,
       Confusion_Matrix = tab,
       Accuracy_Measures = data.frame(Accuracy,
                                      Precision = round(Precision,2),
                                      Recall = round(Recall,2),
                                      F1_Score))
}

#' Random Forest Classification Accuracy Measures
#'
#' @description
#' This function is designed to compute accuracy measures for email data set
#'  using Random Forest classification model. This function return the model,
#'  confusion matrix and accuracy measures.
#'
#' @param data list of length 2 from \link[text.analysis]{partition}
#' @param ntree Number of trees to grow. This should not be set to too small a
#'  number, to ensure that every input row gets predicted at least a few times.
#' @param mtry Number of variables randomly sampled as candidates at each split.
#'  Note that the default values are different for classification (sqrt(p)
#'  where p is number of variables in x)
#' @param ... futher parameters from \link[randomForest]{randomForest} function
#'
#' @importFrom randomForest randomForest
#'
#' @return \link[base]{list} with length 3
#'
#' @export
rf_classification <- function(data, ntree = 500,
                              mtry = sqrt(ncol(data$train)),...){

  # Convert the train set
  train <- data.frame("category" = as.factor(data$train[,1]),
                      apply(data$train[,-1], MARGIN = 2, count_convert_fct))

  # Convert the test set
  test <-  data.frame("category" = as.factor(data$test[,1]),
                      apply(data$test[,-1], MARGIN = 2, count_convert_fct))

  # Fit the Random Forest model
  rf_model <- randomForest(category ~ ., data = train ,ntree = ntree,
                         mtry = mtry, ...)
  rf_pred <- predict(rf_model, test)

  # Confusion matrix
  tab <- table(rf_pred,test$category)

  # Calculate accuracy measures
  Accuracy <- paste0(round(100*sum(diag(tab))/sum(tab),2),"%")
  Precision <- tab[2,2]/(tab[2,2] + tab[2,1])
  Recall <- tab[2,2]/(tab[2,2] + tab[1,2])
  F1_Score <- round(2*Precision*Recall/(Precision + Recall),2)

  list(Model = rf_model,
       Confusion_Matrix = tab,
       Accuracy_Measures = data.frame(Accuracy,
                                      Precision = round(Precision,2),
                                      Recall = round(Recall,2),
                                      F1_Score))
}

#' Logistic Regression Classification Accuracy Measures
#'
#' @description
#' This function is designed to compute accuracy measures for email data set
#'  using Logistic Regression classification model. This function return the
#'  model, confusion matrix and accuracy measures.
#'
#' @param data list of length 2 from \link[text.analysis]{partition}
#' @param threshold probability for classification
#'
#' @return \link[base]{list} with length 3
#'
#' @export
log_classification <- function(data, threshold = 0.5){

  # Convert the train set
  train <- data.frame("category" = as.factor(data$train[,1]),
                      apply(data$train[,-1], MARGIN = 2, count_convert_num))

  # Convert the test set
  test <-  data.frame("category" = as.factor(data$test[,1]),
                      apply(data$test[,-1], MARGIN = 2, count_convert_num))

  # Fit the Logistic Regression model
  log_model <- glm(category ~ ., data = train, family = binomial("logit"))
  log_pred <-  ifelse(predict(log_model, test,type = "response") <= threshold,
                      as.character(sort(unique(train$category))[1]),
                      as.character(sort(unique(train$category))[2]))

  # Confusion matrix
  tab <- table(log_pred,test$category)

  # Calculate accuracy measures
  Accuracy <- paste0(round(100*sum(diag(tab))/sum(tab),2),"%")
  Precision <- tab[2,2]/(tab[2,2] + tab[2,1])
  Recall <- tab[2,2]/(tab[2,2] + tab[1,2])
  F1_Score <- round(2*Precision*Recall/(Precision + Recall),2)

  list(Model = log_model,
       Confusion_Matrix = tab,
       Accuracy_Measures = data.frame(Accuracy,
                                      Precision = round(Precision,2),
                                      Recall = round(Recall,2),
                                      F1_Score))
}

