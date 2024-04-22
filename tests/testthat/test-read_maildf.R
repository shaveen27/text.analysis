test_that("check whether the number of columns are greater than two", {
  df <- data.frame(
    type = c("ham", "spam"),
    message = c(
      "this email finds you well",
      "hello there"
    ),
    add_new = c(1, 0)
  )

  ### expect error of the `convert_mail_list` function
  expect_error(
    convert_mail_list(df),
    "The data set should contain two columns:"
  )
})
