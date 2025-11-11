#Simuliamo un campione di dimensione 100 da un modello di regressione logistica
#con parametri β generati da una distribuzione U(−1.5, 1.5)
#Non partiamo dall'errore data la sua difficoltà ad ottenerlo
rm(list = ls())
x_0 <- rep(1,100)
x_1 <- rnorm(100, 0,1)
x <- cbind(x_0,x_1)
beta <- runif(2,-1.5,1.5)
p <- 1/(1+exp(-x%*%beta))
y <- rbinom(100, 1, prob=p) # 100 casi bernulliani

# generiamo un modello lineare generalizzato con funzione logistica
fit <- glm(y ~ x[,2], family="binomial")
summary(fit)

rbind(beta, coef(fit))

confint(fit)

#può essere resa più efficiente

#Proviamo ad aumentare la dimensione campionaria fino a 500
x_0 <- rep(1,500)
x_1 <- rnorm(500, 0,1)
x <- cbind(x_0,x_1)
p <- 1/(1+exp(-x%*%beta))
y <- rbinom(500, 1, prob=p)

fit <- glm(y ~ x[,2], family="binomial")
summary(fit)

rbind(beta, coef(fit))

# risulta più efficiente dato che fitta meglio i dati e soprattutto la rigressione logistica funziona asintoticamente
