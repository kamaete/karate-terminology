## Load libraries
library(pdftools)
library(stringr)
library(openxlsx)

## Read PDF
x <- pdf_ocr_text(pdf = "karate.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))
y <- y[c(18:60, 62:141, 144:160, 162:224)]

japanese <- str_split(string = y, "(?=[[:upper:]])") |>
  lapply(FUN = function(x) head(x, 2)) |> 
  lapply(FUN = function(x) paste0(x, collapse = "")) |>
  unlist()

english <- str_split(string = y, "(?=[[:upper:]])") |>
  lapply(FUN = function(x) tail(x, 1)) |> 
  unlist()

z <- data.frame(japanese, english)

## Output file
write.csv(z, "karate-terminology.csv", row.names = FALSE)
write.xlsx(z, "karate-terminology.xlsx")
