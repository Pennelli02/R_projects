#La prima stagione, di 26 settimane e la seconda di 30 settimane. Nella seconda
#stagione la casa aveva subito un’intervento di ristrutturazione e isolamento dei
#muri. L’idea era quella di studiare l’effetto dell’isolamento sul consumo di gas.
#Fonte: Hand, D. J., Daly, F., McConway, K., Lunn, D. and Ostrowski, E. eds
#(1993) A Handbook of Small Data Sets. Chapman & Hall, p. 69.
#Variabili
#• consumo: consumo di gas in metri cubi
#• temp: temperatura in gradi Celsius
#• isol: indicatore del trattamento (isolamento presente = 1)

rm(list = ls())
par(mfrow = c(1, 1))  # ripristina il layout standard: un grafico per finestra

data('whiteside', package='MASS') # carica il dataset 'whiteside' dal pacchetto MASS
isol = with(whiteside, as.numeric(Insul)-1) # converte la variabile Insul in numerica e la scala da 0/1
temp = with(whiteside, Temp) # estrae la variabile Temp dal dataset
consumo = with(whiteside, Gas * 28.3168466 ) # converte Gas da piedi cubi a m^3 moltiplicando per 28.3168466
str(data.frame(consumo, temp, isol))

plot(temp[isol==0],consumo[isol==0],xlab="temperatura",
     ylab="consumo", col = "red")
points(temp[isol==1],consumo[isol==1], col = "blue")

#C’`e una differenza evidente fra il caso con isolamento e senza. Valutiamo
#se il modello `e additivo o con interazione fra l’isolamento e la temperatura

#Consideriamo il modello senza interazione
#consumo = β0 + β1temp + β2isol + epsilon"

mq <- lm(consumo ~ temp + isol)
summary(mq)

#Commento dei risultati:
#  • l’effetto della temperatura e dell’isolamento sono entrambi significativi ed
#  altamente significativi
#  • la presenza di isolamento riduce il consumo di circa 44 litri per ogni livello
#  di temperatura
#  • all’aumentare di un grado di temperatura i consumi diminuiscono di circa
#  10 litri nel caso in cui non ci sia isolamento
#  • la stima di `e 10.12
#  • il coefficiente di determinazione `e 0.9063
#  • il test F `e altamente significativo
#  • il modello mostra un buon adattamento


beta <- mq$coefficients
beta

Sigma <- vcov(mq) #Matrice di varianza-covarianza dei coefficienti
Sigma

res <- mq$residuals
qqnorm(res)

fit <- mq$fitted.values
plot(temp[isol==0],consumo[isol==0], xlab="temperatura",
     ylab="consumo", col = "red")
lines(temp[isol==0],fit[isol==0], col = "red")
points(temp[isol==1],consumo[isol==1], col = "blue")
lines(temp[isol==1],fit[isol==1], col = "blue")

#Consideriamo il modello marginale che ignora l’isolamento
#consumo = β0 + β1temp + epsilon"

mq1 <- lm(consumo ~ temp)
summary(mq1)

#Commenti sui risultati:
#   • se marginalizziamo rispetto alla variabile isolamento, otteniamo un modello di regressione lineare semplice
#   • se non teniamo conto dell’isolamento, l’effetto della temperatura `e sempre
#     negativo, altamente significativo, ma minore in valore assoluto
#   • cambia anche il valore medio in caso di temperatura pari a 0 gradi, `e circa
#     155 litri di consumo contro le stime date dal modello precedente di circa
#     185 litri nel caso di temperatura 0 gradi e assenza di isolamento e di circa
#     141 nel caso di temperatura 0 gradi e presenza di isolamento
#   • il modello di regressione multipla NON E’ INVARIANTE PER MARGINALIZZAZIONE

# Consideriamo ora il modello completo con interazione
# consumo = β0 + β1temp + β2isol + β3temp ∗ isol +epsilon"

mq2 <- lm(consumo ~ temp + isol + temp*isol)
summary(mq)

summary(mq2)

#Alcuni commenti
#   • gli effetti della temperatura e dell’isolamento sono sempre negativi, ma piu` grandi in valore assoluto
#   • gli effetti della temperatura e dell’isolamento sono altamente significativi
#   • l’interazione fra isolamento e temperatura `e positiva e altamente significativa: l’effetto della temperatura cambia in caso di presenza o assenza di isolamento
#   • se c’`e isolamento, l’effetto della temperatura `e -7.8703 = (-11.1353 + 3.2650)
#   • se non c’`e isolamento, l’effetto della temperatura `e -11.1353
#   • l’incremento di un grado di temperatura riduce il consumo di circa 7 litri se c’`e isolamento e di circa 11 litri se non c’ isolamento
#   • l’isolamento riduce l’effetto della temperatura sul consumo

fit <- mq2$fitted.values
plot(temp[isol==0],consumo[isol==0], xlab="temperatura",
     ylab="consumo", col = "red")
lines(temp[isol==0],fit[isol==0], col = "red")
points(temp[isol==1],consumo[isol==1], col = "blue")
lines(temp[isol==1],fit[isol==1], col = "blue")

