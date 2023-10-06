# parallel_function_solution.r

library(tweedie)
library(ggplot2)
library(parallel)

simTweedieTest <- function(N){ 
  t.test(rtweedie(N, mu=10000, phi=100, power=1.9), mu=10000)$p.value 
}

MTweedieTests <- function(N, M, sig){ 
  sum(unlist(mclapply(1:M, function(x) simTweedieTest(N) < sig, mc.cores = detectCores()))) / M 
}

df <- expand.grid(N = c(10, 100, 1000, 5000, 10000), M = 1000, share_reject = NA)

for(i in 1:nrow(df)){
  df$share_reject[i] <- MTweedieTests(N=df$N[i], M=df$M[i], sig=.05)
}
