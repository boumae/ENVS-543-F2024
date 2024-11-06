



p <- 0.36
q <- 1-p
N <- 9

Catfish <- seq(0,N)

ways_to_get <- choose(N,Catfish)

prob_of_each <- p^Catfish * q^(N-Catfish)
prob_of_each

data <- data.frame( Catfish, Frequency = ways_to_get * prob_of_each)


#binomial expansion (catfish vs. not catfish)
      #sampled a total of 9 fish, 7 of which are catfish.  
      #Your assumption is that the frequency of catfish in this part of the river is 0.36.
 p <- 0.36
 q <- 1-p
 N <- 9
 Catfish <- 7
  choose(N,Catfish) * p^Catfish * q^(N - Catfish)
  