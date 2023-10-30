# parallel_loop_solution.r

library(tweedie)
library(ggplot2)
library(parallel)

simTweedieTest <- function(N){ 
  t.test(rtweedie(N, mu=10000, phi=100, power=1.9), mu=10000)$p.value 
}

MTweedieTests <- function(N, M, sig){ 
  sum(replicate(M, simTweedieTest(N)) < sig) / M 
}

df <- expand.grid(N = c(10, 100, 1000, 5000, 10000), M = 1000, share_reject = NA)

df$share_reject <- unlist(mclapply(1:nrow(df), function(i) {
  MTweedieTests(N=df$N[i], M=df$M[i], sig=.05)
}, mc.cores = detectCores()))
