#' Function to Read Email Message Data File
#'
#' @description
#' This function is design to read data file that contains email messages.
#' Primarily this function parse a table-formatted file and convert it into a
#' list with two character vectors, where one vector corresponds to a category
#' of the mail and the other vector corresponds to the respective emails.
#'
#' @param file the file name from which the data is to be read. Each row of
#' the table is represented as one line in the file. If the file name does not
#' include an absolute path, it is assumed to be relative to the current working
#' directory obtained using \link[base]{getwd}.
#' @param header a boolean value indicating whether the file includes variable
#' names as its first line. If not provided, it is inferred from the file
#' format: the `header` is set to `TRUE` only if the first row has one fewer
#' field than the total number of columns.
#' @param sep this parameter used to separate fields in the file. Each line's
#' values are split using this character. `sep = ""`, is the default separator
#' and it defaults to 'white space', meaning one or more spaces, tabs, newlines,
#' or carriage returns.
#' @param skip an integer indicating the number of lines in the data file to
#' skip before starting to read the data.
#' @param quote specifies the quoting characters used in the file. To disable
#' quoting entirely, set `quote = ""`. Refer to scan for how embedded quotes are
#' handled. Quoting applies only to columns read as character, unless
#' `colClasses` is specified.
#' @param ... Further arguments to be passed to \link[utils]{read.table}.
#'
#' @return \link[base]{data.frame}
#'
#' @export
read_maildf <- function(file, header = FALSE, sep = "", skip = 0,
                        quote = "\"", ...) {
  # Read file using read.table function in R
  df <- utils::read.table(
    file = file, header = header, sep = sep,
    quote = quote, ...
  )
}

#' Function to convert data frame with messages to list
#'
#' @description
#' This function is design convert a data frame with  messages to `email_list`
#'  object
#'
#' @param data \link[base]{data.frame} with messages
#'
#' @return \link[text.analysis]{email_list} object
#'
#' @export
convert_mail_list <- function(data){
  # Check data set contains 2 columns
  if (ncol(data) != 2) {
    stop("The data set should contain two columns: one column for classifying
         emails as ham/spam, and another column for the email messages.",
         call. = FALSE
    )
  }

  # Make the list
  for (i in seq_len(2)) {
    if (length(unique(data[, i])) == 2) {
      category <- as.vector(data[, i])
    }

    if (length(unique(data[, i])) != 2) {
      message <- as.vector(data[, i])
    }
  }

  email_list(list(category = category, message = message))
}
