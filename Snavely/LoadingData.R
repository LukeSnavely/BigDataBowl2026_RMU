# Test code to push

library(tidyverse)

# tracking <- read_csv("data/train/output_2023_w01.csv") |> 
#   bind_rows(read_csv("data/train/output_2023_w02.csv")) |>
#   bind_rows(read_csv("data/train/output_2023_w03.csv")) |>
#   bind_rows(read_csv("data/train/output_2023_w04.csv")) |>
#   bind_rows(read_csv("data/train/output_2023_w05.csv")) |>
#   bind_rows(read_csv("data/train/output_2023_w06.csv")) |>
#   bind_rows(read_csv("data/train/output_2023_w07.csv")) |>
#   bind_rows(read_csv("data/train/output_2023_w08.csv")) |>
#   bind_rows(read_csv("data/train/output_2023_w09.csv")) |>  
#   bind_rows(read_csv("data/train/output_2023_w10.csv")) |>
#   bind_rows(read_csv("data/train/output_2023_w11.csv")) |>
#   bind_rows(read_csv("data/train/output_2023_w12.csv")) |>
#   bind_rows(read_csv("data/train/output_2023_w13.csv")) |>
#   bind_rows(read_csv("data/train/output_2023_w14.csv")) |>
#   bind_rows(read_csv("data/train/output_2023_w15.csv")) |>  
#   bind_rows(read_csv("data/train/output_2023_w16.csv")) |>  
#   bind_rows(read_csv("data/train/output_2023_w17.csv")) |>  
#   bind_rows(read_csv("data/train/output_2023_w18.csv"))
# 
# # # write the combined tracking data object into a parquet file
# library(arrow)
# arrow::write_parquet(tracking, "data/tracking.parquet")

tracking <- arrow::read_parquet("data/tracking.parquet")
supplement <- read_csv("data/supplementary_data.csv")

glimpse(supplement)  

supplement |> 
  count(team_coverage_type)
