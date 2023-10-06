# Import libraries

library(tictoc)

# Custom function to capture time
capture_time <- function() {
  time_data <- toc(log = TRUE)
  return(time_data$toc - time_data$tic)
}

# Source the original solution and time it
tic()
source("scripts/Solution_now.r")
time_original <- capture_time()

# Source the parallel loop solution and time it
tic()
source("scripts/Parallel_loop_solution.r")
time_loop <- capture_time()

# Source the parallel function solution and time it
tic()
source("scripts/Parallel_function_solution.r")
time_function <- capture_time()

# Print all timings side-by-side
cat(sprintf("Original Solution: %.5f sec\n", time_original))
cat(sprintf("Parallel Loop Solution: %.5f sec\n", time_loop))
cat(sprintf("Parallel Function Solution: %.5f sec\n", time_function))

# Comment on the fastest method and the observed results
cat("Based on multiple runs, the Parallel Function Solution often comes out on top, but not consistently. This variability might be due to the time it takes to set up parallel tasks, which can sometimes counteract the speed benefits, especially for tasks that are already quite fast.")
