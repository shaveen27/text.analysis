#' Visualize Text Data Exploration Results
#'
#' This function use to create visualizations category distribution and
#' number of words for each category.
#'
#' @param data a cleaned \link[text.analysis]{email_list} object
#' @param numwords number of words need to plot for each category (default: 10)
#'
#' @importFrom graphics pie barplot
#' @importFrom grDevices rainbow
#'
#' @return pie chart for category and barcharts for each category
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
