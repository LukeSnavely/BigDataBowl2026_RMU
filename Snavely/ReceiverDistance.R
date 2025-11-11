library(tidyverse)

post_throw <- arrow::read_parquet("data/post_throw_tracking.parquet")
pre_throw <- arrow::read_parquet("data/pre_throw_tracking.parquet")
supplement <- read_csv("data/supplementary_data.csv")

# Custom playID and gameID
pre_throw <- pre_throw |> 
  mutate(unique_id = paste(game_id, play_id))

# Filtering for QBs
qb_time <- pre_throw |> 
  filter(player_position == "QB")

# Finding out how long QBs hold onto the ball
qb_frames <- qb_time |> 
  group_by(game_id, play_id, nfl_id) |> 
  summarize(num_of_frames = max(frame_id)) |>
  ungroup() |> 
  left_join(select(supplement, game_id, play_id, route_of_targeted_receiver, play_description, quarter, dropback_type))

# Finding out how long a QB holds onto the ball for each play
time_by_play <- qb_frames |> 
  group_by(route_of_targeted_receiver) |> 
  summarize(mean_time = mean(num_of_frames)) |> 
  ungroup()

# Why are these screens/slants long plays? Look at Everett catch gameID 2023121400, playID 551
screens_slants <- qb_frames |> 
  filter(route_of_targeted_receiver %in% c("SCREEN", "SLANT"),
         num_of_frames >= 35)

# Filtering for "broken" players
broken <- qb_frames |> 
  filter(num_of_frames >= 35) |> 
  mutate(unique_id = paste(game_id, play_id))

# Plays we want to look at
extended_plays <- pre_throw |> 
  filter(unique_id %in% broken$unique_id)

# Normalizing the playing field (all plays go in the same direction)
extended_plays <- extended_plays |>
  mutate(
    # Plays will always go from left to right
    x = ifelse(play_direction == "left", 120 - x, x),
    y = ifelse(play_direction == "left", 160 / 3 - y, y),
    # flip player direction and orientation
    dir = ifelse(play_direction == "left", dir + 180, dir),
    dir = ifelse(dir > 360, dir - 360, dir),
    o = ifelse(play_direction == "left", o + 180, o),
    o = ifelse(o > 360, o - 360, o)
  )
