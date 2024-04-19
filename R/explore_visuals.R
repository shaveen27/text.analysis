#' Visualize Text Data Exploration Results
#'
#' Takes the results of the explore_text_data function and creates
#' visualizations.
#' It generates plots for category distribution, message lengths, and word
#' counts.
#'
#' @param results A list containing the results from the explore_text_data
#' function.
#' @import ggplot2
#' @return A list of ggplot objects representing the visualizations.
#' @export

explore_visuals <- function(results) {
  if (!is.list(results)) {
    stop(
      "The input must be a list resulting from the",
      " explore_text_data function."
    )
  }
  plots <- list()
  category_table <- data.frame(
                               Category = names(results$category_distribution),
                               Frequency =
                                 as.integer(results$category_distribution))
  category_distribution_plot <-
    ggplot2::ggplot(category_table, aes(x = "", y = "", fill =
                                          names(results$category_distribution)))
  +
    geom_bar(stat = "identity", width = 1) +
    coord_polar(theta = "y") +
    theme_void() +
    labs(title = "Category Distribution") +
    theme(
      plot.title = element_text(hjust = 0.5, margin = margin(b = 10)),
      panel.border = element_rect(color = "black", fill = NA, size = 1)
    ) +
    scale_fill_manual(values = c("#1F77B4", "lavender")) +
    theme(legend.title = element_blank()) # Remove the legend title


  # Visualization for message lengths distribution
  # For message length distribution
  message_length_plot <- ggplot2::ggplot(
    data.frame(results$message_lengths),
    aes(x = results$message_lengths)
  ) +
    geom_histogram(binwidth = 10, fill = "#1F77B4", color = "black") +
    theme_minimal() +
    labs(
      title = "Message Length Distribution", x = "Length of Messages",
      y = "Frequency "
    ) +
    theme(
      plot.title = element_text(hjust = 0.5), # Center title
      panel.border = element_rect(color = "black", fill = NA, size = 1)
    )

  # For word counts distribution
  word_count_plot <- ggplot2::ggplot(
    data.frame(results$word_counts),
    aes(x = results$word_counts)
  ) +
    geom_histogram(binwidth = 1, fill = "#1F77B4", color = "black") +
    theme_minimal() +
    labs(title = "Word Count Distribution", x = "Word Count", y = "Frequency") +
    theme(
      plot.title = element_text(hjust = 0.5), # Center title
      panel.border = element_rect(color = "black", fill = NA, size = 1)
    )


  # Combine the plots into a list and return
  plots <- list(
    category_distribution_plot = category_distribution_plot,
    message_length_plot = message_length_plot,
    word_count_plot = word_count_plot
  )

  return(plots)
}
