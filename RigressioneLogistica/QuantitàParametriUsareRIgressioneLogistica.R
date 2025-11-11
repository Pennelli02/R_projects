#Per verificare come la proporzione di difetti nel prodotto finito dipende dal
#processo produttivo usato (a temperatura normale o a bassa temperatura) `e
#stato fatto un esperimento su 22 partite di materiale tessile grezzo, ciascuna
#delle quali poteva avere una purezza diversa

rm(list = ls())

#Variabili
#• y: presenza o assenza di difetti (1/0)
#• proc: indicatore del processo (0 = standard, 1 = modificato)
#• pur: indice di purezza (da 5 (peggiore) a 9 (migliore))

#N.B. nell'ottenere il dataset bisogna stare attenti appaiati 
#(due valori della risposta per ogni partita con lo stesso indice di purezza)

pur = c(7.2, 6.3, 8.5, 7.1, 8.2, 4.6, 8.5, 6.9, 8.0, 8.0, 9.1,
        6.5, 4.9, 5.3, 7.1, 8.4, 8.5, 6.6, 9.1, 7.1, 7.5, 8.3,
        7.2, 6.3, 8.5, 7.1, 8.2, 4.6, 8.5, 6.9, 8.0, 8.0, 9.1,
        6.5, 4.9, 5.3, 7.1, 8.4, 8.5, 6.6, 9.1, 7.1, 7.5, 8.3)
y = c(0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0,
      0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0,
      0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0,
      1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0)
proc =c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)

#Stimiamo il modello di regressione logistica y ∼ pur nel caso di processo
#standard e nel caso di processo non standard

fit <- glm(y[proc==0] ~ pur[proc==0], family = binomial)
pstima <- fit$fitted.values
fit1 <- glm(y[proc==1] ~ pur[proc==1], family = binomial)
pstima1 <- fit1$fitted.values
summary(fit)
summary(fit1)

plot(pur[proc==0],y[proc==0], col="blue")
points(sort(pur[proc==0]), pstima[order(pur[proc==0])],
       type="l", col="blue")
points(pur[proc==1],y[proc==1], col="red")
points(sort(pur[proc==1]),pstima1[order(pur[proc==1])],
       type="l", col="red")

#Non un granché il modello

#Consideriamo ora il modello di regressione logistica multipla che considera anche
#la variabile dummy proc

fit2 <- glm(y ~ pur + proc, family = binomial)
summary(fit2)

#install.packages("ellipse")

ci <- confint(fit2, c(2,3)) # controlla!!!
library(ellipse) # si carica la libreria
plot(ellipse(fit2, c(2, 3)), type="l")
abline(v=c(ci[1,1], ci[1,2]), lty=2)
abline(h=c(ci[2,1], ci[2,2]), lty=2)
points(coef(fit2)[2],coef(fit2)[3], pch=18)
points(0,0)

#Commento
#• l’effetto dell’indice di purezza `e signifcativamente diverso da 0
#• il p-value osservato per la variabile proc non `e significativo, quindi
#  sembrerebbe che i dati non mostrano evidenza contro l’ipotesi H0 : β2 = 0
#• l’ellissoide di confidenza mostra che la coppia di punti β1 = 0 e β2 = 0
#  appartiene alla regione di confidenza

#Ripetiamo l’analisi ignorando la variabile proc, questa volta su tutto il campione

fit3 <- glm(y ~ pur, family = binomial)
pstima3 <- fit3$fitted.values
summary(fit3)

rbind(coef(fit),coef(fit1),coef(fit3))

plot(pur,y)
points(sort(pur), pstima3[order(pur)], type ="l")
points(sort(pur[proc==0]), pstima[order((pur[proc==0]))],
       type ="l", col="blue")
points(sort(pur[proc==1]),pstima1[order(pur[proc==1])],
       type ="l", col="red")

# Commento finale:
# - Dai modelli separati e congiunti emerge che l’indice di purezza (pur)
#   influisce significativamente sulla probabilità di avere difetti: 
#   maggiore purezza → minore probabilità di difetti.
# - Il tipo di processo (proc), invece, non risulta significativo: 
#   non si osservano differenze statisticamente rilevanti tra il processo
#   standard e quello a bassa temperatura.
# - L’ellisse di confidenza mostra che la coppia (β_pur=0, β_proc=0)
#   rientra nella regione di confidenza, confermando che l’effetto di proc
#   non è distinto da zero.
# - In conclusione, la qualità del prodotto dipende dalla purezza del materiale
#   più che dal tipo di processo utilizzato.
# - Un modello logistico semplice con sola variabile pur descrive adeguatamente i dati.