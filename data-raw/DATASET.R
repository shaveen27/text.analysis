## code to prepare `DATASET` dataset goes here

sms_spam_collection <- read_maildf(
  "~/Documents/github/packages/text.analysis/data-raw/SMSSpamCollection",
  sep = "\t", quote = ""
)

colnames(sms_spam_collection) <- c("category", "message")
sms_spam_collection$message <- enc2utf8(sms_spam_collection$message)

usethis::use_data(sms_spam_collection, overwrite = TRUE)
