test_that("R functions for data cleaning work only for email-lists", {
  df <- data.frame(
    type = c("ham", "spam"),
    message = c(
      "this email finds you well",
      "hello there"
    )
  )

  ### expect error of the `lower_case` function
  expect_error(
    lower_case(df),
    "x should be a email_list object"
  )

  ### expect error of the `remove_numbers` function
  expect_error(
    remove_numbers(df),
    "x should be a email_list object"
  )

  ### expect error of the `remove_punctuations` function
  expect_error(
    remove_punctuations(df),
    "x should be a email_list object"
  )

  ### expect error of the `remove_whitespaces` function
  expect_error(
    remove_whitespaces(df),
    "x should be a email_list object"
  )

  ### expect error of the `remove_stopwords` function
  expect_error(
    remove_stopwords(df),
    "x should be a email_list object"
  )
})
