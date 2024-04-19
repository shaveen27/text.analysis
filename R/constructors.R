#' Function to convert email data frame into a list
#'
#' The function `email_list` is used to encode a \link[base]{data.frame}
#'  as a email_list object.
#'
#' @param x a data frame with two columns one column for classifying emails as
#' ham/spam, and another column for the email messages
#'
#' @return returns an object of class `email_list`. This is a list with two
#' character vectors. One vector contains category of the email messages and
#' other vector contains the respective message.
#'
#' @export
email_list <- function(x) {
  validate_email_list(as_email_list(x))
}


# Constructor for email_list
as_email_list <- function(x) {
  structure(x,
    class = "email_list"
  )
}

# Validator for email_list
validate_email_list <- function(x) {
  # Check list contains 2 columns
  if (length(unclass(x)) != 2) {
    stop("email_list should be a list of two elements.",
      call. = FALSE
    )
  }
  x
}
