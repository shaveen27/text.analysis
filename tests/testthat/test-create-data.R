test_that("tolerance is applicable for creating data", {
  df <- data.frame(
    type = c("ham", "spam"),
    message = c(
      "this email finds you well",
      "hello there"
    )
  )

  ### expect error of the `final_model_df` function
  expect_error(
    final_model_df(df, -2),
    "tol should be a positive integer value"
  )

  expect_message(
    final_model_df(df, 3.2),
    "tol should be an interger value"
  )
})
