## code to prepare `DATASET` dataset goes here

SMSSpamCollection <- read_maildf(
  "~/Documents/github/packages/text.analysis/data-raw/SMSSpamCollection",
  sep = "\t", quote = ""
)

colnames(SMSSpamCollection) <- c("category", "message")
SMSSpamCollection$message <- enc2utf8(SMSSpamCollection$message)

usethis::use_data(SMSSpamCollection, overwrite = TRUE)
