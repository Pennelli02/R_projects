#Data set relativo all’esito di un’operazione alla colonna vertebrale, la laminectomia, effettuata su un campione di 81 bambini, per correggere la cifosi Sono
#osservate 4 variabili
# • Kyphosis: variabile risposta con livelli absent=0 present=1.
# • Age, del bambino in mesi
# • Number: numero di vertebre coinvolte nell’operazione
# • Start: vertebra inziale da cui parte l’operazione

rm(list = ls())

data("kyphosis", package = 'rpart')
Kyph<-as.numeric(kyphosis$Kyphosis=="present")
attach(kyphosis)

plot(Age, Kyph) # nessuna informazione

plot(Number, Kyph) #nessuna informazione

plot(Start, Kyph) # nessuna informazione

#si nota che da questi plot non otteniamo tante informazioni
#Allora procediamo in maniera differente

fit <- glm(Kyph ~ Age, family="binomial")
summary(fit)

#notiamo che in questo caso non è significativa l'età (p_value)

fit1 <- glm(Kyph ~ Number, family="binomial")
summary(fit1)

#notiamo che invece il numero ha una maggiore influenza

fit2 <- glm(Kyph ~ Start, family="binomial")
summary(fit2)

#Consideriamo ora regressioni logistiche multiple includendo tutte le variabili
#esplicative

#   logit(Kyph) = β0 + β1Age + β2Number + β3Start

fit <- glm(Kyph ~ Age + Number + Start, family="binomial")
summary(fit)

stima <- exp(coef(fit)%*%c(1, 60,3,5))/(1+exp(coef(fit)%*%c(1, 60,3,5)))

fit1 <- glm(Kyph ~ Number + Start, family="binomial")
summary(fit1)

stima1 <- exp(coef(fit1)%*%c(1,3,5))/(1+exp(coef(fit1)%*%c(1,3,5)))

fit2 <- glm(Kyph ~ Start, family="binomial")
summary(fit2)

stima2 <- exp(coef(fit2)%*%c(1, 5))/(1+exp(coef(fit2)%*%c(1, 5)))

pstima <- fit2$fitted.values
plot(Start, Kyph)
lines(sort(Start), pstima[order(Start)], type="l", col="blue")

#Alcune Osservazioni:
#Modello Kyph ∼ Age + Number + Start
#• risultano non significative Age e Number
#• l’effetto della variabile Start `e significativo secondo il p -value
#• le stime dei parametri e degli errori standard fra modelli marginali e
#  modello congiunto sono abbastanza diverse

#Modello Kyph ∼ Number + Start
#• l’effetto di Number `e ancora non significativo al 5%
#• l’effetto di Start `e ancora significativo

#Modello Kyph ∼ Start
#• l’effetto di Start rimane significativo e negativo

# Conclusione:
# - La variabile Start è l’unica che mostra un effetto statisticamente significativo su Kyph.
# - Le variabili Age e Number non contribuiscono in modo rilevante alla spiegazione del modello.
# - Un modello semplice con la sola variabile Start risulta adeguato e interpretabile,
#   evitando complessità non necessarie.