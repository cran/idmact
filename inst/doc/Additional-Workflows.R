## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(idmact)

## -----------------------------------------------------------------------------
# Create 100 raw scores
set.seed(279)
raw_scores <- as.list(sample(1:100, 100, replace = TRUE))

# Map between raw scores and scale scores for each form

## Each form has scale scores ranging from 1 to 12
map_scale <- c(1:12)

## Each assessment has raw scores ranging from 1 - 100
map_raw_formA <- list(1:5, 6:20, 21:25, 26:40, 41:45, 46:50, 51:55,
                   56:75, 76:80, 81:85, 86:90, 91:100)

map_raw_formB <- list(1:10, 11:20, 21:30, 31:40, 41:50, 51:55, 56:65,
                   66:75, 76:85, 86:90, 91:95, 96:100)

formA <- map_elongate(map_raw = map_raw_formA,
                      map_scale = map_scale)

formB <- map_elongate(map_raw = map_raw_formB,
                      map_scale = map_scale)

df_A <- data.frame(raw = unlist(formA$map_raw),
                   scale = unlist(formA$map_scale),
                   scores = unlist(raw_scores))

df_B<- data.frame(raw = unlist(formB$map_raw),
                   scale = unlist(formB$map_scale),
                   scores = unlist(raw_scores))

## -----------------------------------------------------------------------------
resA <- idmact_subj(df = df_A,
                    raw = "scores",
                    map_raw = "raw",
                    map_scale = "scale")


resB <- idmact_subj(df = df_B,
                    raw = "scores",
                    map_raw = "raw",
                    map_scale = "scale")

## -----------------------------------------------------------------------------
cat("Form A subject level delta:", resA$deltas, "\n")
cat("Form B subject level delta:", resB$deltas)

## -----------------------------------------------------------------------------
# First make sure the information in map_raw_formA and map_raw_formB is the same
# length as the information in map_scale
map_raw_formA <- as.character(alist(1-5, 6-20, 21-25, 26-40, 41-45, 46-50, 51-55,
                   56-75, 76-80, 81-85, 86-90, 91-100))

map_raw_formB <- as.character(alist(1-10, 11-20, 21-30, 31-40, 41-50, 51-55, 56-65,
                   66-75, 76-85, 86-90, 91-95, 96-100))

# Then form the df_raw data frames
df_raw_A <- data.frame(raw = map_raw_formA,
                       scale = map_scale)
df_raw_A <- map_elongate_df(df_raw_A, "raw", "scale")

df_raw_B <- data.frame(raw = map_raw_formB,
                       scale = map_scale)
df_raw_B <- map_elongate_df(df_raw_B, "raw", "scale")

# Now the df data frame only needs to hold the raw scores
df <- data.frame(scores = unlist(raw_scores))

## -----------------------------------------------------------------------------
resA <- idmact_subj(df = df,
                    df_map = df_raw_A,
                    raw = "scores",
                    map_raw = "raw",
                    map_scale = "scale")


resB <- idmact_subj(df = df,
                    df_map = df_raw_B,
                    raw = "scores",
                    map_raw = "raw",
                    map_scale = "scale")

## -----------------------------------------------------------------------------
cat("Form A subject level delta:", resA$deltas, "\n")
cat("Form B subject level delta:", resB$deltas)

## -----------------------------------------------------------------------------
resA <- idmact_subj(df = df,
                    df_map = df_raw_A,
                    raw = "scores",
                    map_raw = "raw",
                    map_scale = "scale",
                    mcent_subj = function(x) median(x, na.rm = TRUE))


resB <- idmact_subj(df = df,
                    df_map = df_raw_B,
                    raw = "scores",
                    map_raw = "raw",
                    map_scale = "scale",
                    mcent_subj = function(x) median(x, na.rm = TRUE))

## -----------------------------------------------------------------------------
cat("Form A subject level delta:", resA$deltas, "\n")
cat("Form B subject level delta:", resB$deltas)

