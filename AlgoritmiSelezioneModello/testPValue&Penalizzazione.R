rm(list = ls())
#Si vuole studiare il calore necessario per la formazione del cemento (variabili risposta) in funzione della sua composizione chimica osservata su quattro variabili
#esplicative. Si considera un data set basato su 13 osservazioni.
#  • x1: peso percentuale di 3CaO.Al2O3 nel clinker (tipo di laterizio)
#  • x2: peso percentuale di 3CaO.SiO2 nel clinker
#  • x3: peso percentuale di 4CaO.Al2O3.Fe2O3 nel clinker
#  • x4: peso percentuale di 2CaO.SiO2 nel clinker
#  • y: calore neccessario (calorie/grammi)

#la numerosit`a campionaria `e abbastanza piccola rispetto al numero delle 
#variabili coinvolte, perci`o si deve necessariamente procedere ad una selezione
#delle variabili esplicative da includere

"cement" =
  structure(list(x1 = c(7, 1, 11, 11, 7, 11, 3, 1, 2, 21, 1, 11,
                        10), x2 = c(26, 29, 56, 31, 52, 55, 71, 31, 54, 47, 40, 66, 68
                        ), x3 = c(6, 15, 8, 8, 6, 9, 17, 22, 18, 4, 23, 9, 8), x4 = c(60,
                                                                                      52, 20, 47, 33, 22, 6, 44, 22, 26, 34, 12, 12), y = c(78.5, 74.3,
                                                                                                                                            104.3, 87.6, 95.9, 109.2, 102.7, 72.5, 93.1, 115.9, 83.8, 113.3,
                                                                                                                                            109.4)), .Names = c("x1", "x2", "x3", "x4", "y"),
            class = "data.frame", row.names = c("1",
                                                "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"))
cement

#otteniamo le variabili coinvolte
y = cement$y
x1 = cement$x1
x2 = cement$x2
x3 = cement$x3
x4 = cement$x4

#attach(cement)
mq <- lm(y ~ x1 + x2 + x3 + x4)
summary(mq)

mq0 <- lm(y ~ 1)
summary(mq0)
#--------------------------------------------------------------------------------
#METODO BACKWARD con p-value
#partendo dal modello completo andiamo ogni volta ad eliminare la variabile
#a cui `e associato il p-value piu` alto

mq1 <- update(mq, .~. -x3)
# eliminiamo x3 perché possedeva il p-value più alto
summary(mq1)
#facciamo annche per x4
mq2 <- update(mq1, .~. -x4)
summary(mq2)

#abbiamo ottenuto un ottimo risultato:
# y=x1+x2

#-------------------------------------------------------------------------------
#METODO FORWARD con p-value: partendo dal modello nullo (solo intercetta) ed andiamo ogni volta ad aggiungere una variabile a cui `e associato il
#p-value piu` alto

#da quello nullo si aggiunge x1 e si valuta
mq1 <- update(mq0, .~. +x1)
summary(mq1)

#buonoprocediamo a sommare x2 
mq2 <- update(mq0, .~. +x2)
summary(mq2)

mq3 <- update(mq0, .~. +x3)
summary(mq3)

mq4 <- update(mq0, .~. +x4)
summary(mq4)

#pvalue più piccolo x4 lascio lui

mq5 <- update(mq4, .~. +x1)
summary(mq5)

mq6 <- update(mq4, .~. +x2)
summary(mq6)

mq7 <- update(mq4, .~. +x3)
summary(mq7)

# p-value vince mq5 quindi considero questo modello
mq8 <- update(mq5, .~. +x2)
summary(mq8)

mq9 <- update(mq5, .~. +x3)
summary(mq9)

# pvalue troppo alto non si procede 
#Risultato: y=x1+x4

--------------------------------------------------------------------------------
#penalizzazione Forward
#  • k = 0: si confronta la funzione di verosimiglianza, quindi sceglie sempre il
#  modello completo y ∼ x1 + x2 + x3 + x4
#  • k = 2: secondo il criterio AIC selezioniamo il modello y ∼ x1 + x2 + x4
#  • k = log(length(y)): secondo il criterio BIC selezioniamo il modello y ∼
#  x1 + x2 + x4

forw_lik <- step(mq0, scope=formula(mq), direction="forward", k=0)
forw_aic <- step(mq0, scope=formula(mq), direction="forward", k=2)
forw_bic <- step(mq0, scope=formula(mq), direction="forward",
                 k=log(length(y)))

#--------------------------------------------------
#può essere applicata anche both (direction="both") e 
#Si possono utilizzare anche procedure iterative che applicano forward e backward sulla base di diversi criteri
  #• p-value, anche in versione aggiustata per tenere conto dei test multipli, ad
    #esempio con aggiunstamento di Bonferroni
  #• AIC
  #• BIC
  #• R2 aggiustato
#Modificando alcune opzioni della funzione potrebbero anche venire risultati
#diversi rispetto alle procedure utilizzate prima

#install.packages("SignifReg")
#library(SignifReg)
# p-value
#SignifReg(mq0, scope=cement, alpha = 0.05, direction = "forward",
         # criterion = "p-value", adjust.method = "fdr", trace=FALSE)

# p-value
SignifReg(mq0, scope=cement, alpha = 0.05, direction = "forward",
          criterion = "p-value", adjust.method = "fdr", trace=FALSE)

SignifReg(mq, scope=cement, alpha = 0.05, direction = "backward",
          criterion = "p-value", adjust.method = "bonferroni", trace=FALSE)

SignifReg(mq, scope=cement, alpha = 0.05, direction = "both",
          criterion = "p-value", adjust.method = "none", trace=FALSE)

# AIC
SignifReg(mq0, scope=cement, direction = "forward", criterion =
            "AIC", trace=FALSE)

SignifReg(mq, scope=cement, direction = "backward", criterion =
            "AIC", trace=FALSE)

SignifReg(mq, scope=cement, direction = "both", criterion =
            "AIC", trace=FALSE)

# BIC
SignifReg(mq0, scope=cement, direction = "forward", criterion =
            "BIC", trace=FALSE)

SignifReg(mq, scope=cement, direction = "backward", criterion =
            "BIC", trace=FALSE)

SignifReg(mq, scope=cement, direction = "both", criterion = "BIC",
          trace=FALSE)