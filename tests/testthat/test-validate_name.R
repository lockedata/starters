context("test-validate_name")

test_that("validate_name works", {
  expect_error(create_basic_project(),
               "Failed name validation: The name is required.")
  expect_error(validate_name("a"),
               "Failed name validation: The name needs to have at least two characters.")
  expect_error(validate_name(1),
               "Failed name validation: The name has to be a character.")
  expect_error(validate_name(c("Icannotchoose", "betweennames")),
    "Failed name validation: Please only provide one name."
  )
  expect_error(validate_name("2eee"),
               "Failed name validation")
  expect_error(validate_name("y-eee"),
               "Failed name validation")
  expect_silent(validate_name("starters"))
})
