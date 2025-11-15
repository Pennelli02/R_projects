# Esempio do overfitting
#Generiamo i dati dal modello quadratico
  #Yi = (Xi − 0.25)^2 + 1 + espilon_i
#dove  epsilon_i ∼ N(0, 0.12)   Xi ∼ U(0, 1)

#Quindi i parametri del modello sono
  #Yi = 1.065 − 0.5Xi + X^2i + epsilon_i

rm(list = ls())

e <- rnorm(20,0,0.1)
x <- runif(20, 0, 1)
y <- ((x-0.25)^2)+1+e
curve(((x-0.25)^2+1), col="red")
points(x,y, col="blue")

mq1 <- lm(y ~ x)
summary(mq1)

mq2 <- update(mq1, .~. + I(x^2))
summary(mq2)

mq3 <- update(mq2, .~. + I(x^3))
summary(mq3)

mq5 <- update(mq3, .~. + I(x^4)+I(x^5))
summary(mq5)

mq7 <- update(mq5, .~. + I(x^6)+I(x^7))
summary(mq7)

mq9 <-update(mq7, .~. + I(x^8)+I(x^9))
summary(mq9)

mq12 <-update(mq9, .~. + I(x^10)+I(x^11)+I(x^12))
summary(mq12)

plot(x,y)
abline(mq1, col="red",lwd=3)
lines(sort(x), fitted(mq2)[order(x)], col='blue', lwd=3)
lines(sort(x), fitted(mq5)[order(x)], col='green',lwd=3)
lines(sort(x), fitted(mq7)[order(x)], col='purple',lwd=3)
lines(sort(x), fitted(mq9)[order(x)], col='yellow',lwd=3)
lines(sort(x), fitted(mq12)[order(x)], col='black', lwd=3)

#guardando il grafico si nota il fenomeno dell'overfitting (troppi parametri usati)

#Alcuni commenti:
#Confrontando i risultati delle varie regressioni polinomiali notiamo che
# • l’indice R2 aumenta con il grado k del polinomio, anche se l’incremento
  # considerevole si ha con k = 2
# • l’indice R2 aggiustato rispetto alla numerosit`a delle variabili aumenta con
#   k = 2 e poi diminuisce
# • la statistica F `e altamente significativa, ma il p- value tende ad aumentare
#   con il grado del polinomio
# • il parametro σ tende ad essere sempre piu` sovrastimato all’aumentare del
#   grado del polinomio
# • confrontando i grafici dei valori stimati si vede chiaramente che aumenta
#   la correttezza della stima di y all’aumentare del grado del polinomio
# • allo stesso tempo, all’aumentare del grado del polinomio esplode la varianza degli stimatori per cui i parametri del modello tendono a risultare non
#   significativi secondo il p-value

