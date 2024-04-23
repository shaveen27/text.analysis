#' Function to visualize cleaned data.
#'
#' This function use to create visualizations for distribution of the category variable
#' and number of words for each category.
#'
#' @param data a cleaned \link[text.analysis]{email_list} object
#' @param numwords number of words need to plot for each category (default: 10)
#'
#' @importFrom graphics pie barplot
#' @importFrom grDevices rainbow
#'
#' @return pie chart for category and barcharts for each category
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
#' # Visualization
#' explore_visuals(corpus)
#'
#' @export
explore_visuals <- function(data, numwords = 10) {
  if (attr(data, "class") != "email_list") {
    stop(
      "The input must be a email_list object.",
      call. = FALSE
    )
  }

  # Construct Pie Chart for Categories
  tab <- table(data$category)
  slices <- as.vector(tab)
  lbls <- names(tab)
  pct <- round(slices / sum(slices) * 100, 2)
  lbls1 <- paste(paste(lbls, pct), "%", sep = "")
  pie(slices,
    labels = lbls1, col = rainbow(length(lbls)),
    main = "Pie Chart of Categories"
  )

  # Construct bar chart for each category
  df <- data.frame(unclass(data))

  for (i in seq_len(length(lbls))) {
    df1 <- subset(df, df$category == lbls[i])
    d <- sort(
      table(unlist(
        strsplit(df1$message, "\\s+")
      )),
      decreasing = TRUE
    )[seq_len(numwords)]
    barplot(d,
      col = "skyblue", xlab = "Word", ylab = "Count",
      main = paste0(lbls[i], " Messages")
    )
  }
}
