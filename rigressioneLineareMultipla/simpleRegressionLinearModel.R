#Simuliamo 100 osservazioni da un modello di regressione lineare semplice con
# epsilon ∼ N(0, 4) e βT = (3, −2, 2). 
#sapendo che epsilon sono V.A che indicano l'errore di predizione del modello
# βT vettore dei paramentri che sono -coefficienti di regressione parziale- 
#    perché rappresenta l’effetto di (X)j sul valore atteso di Y condizionatamente
#    a valori fissati (x¯)j di tutte le altre variabili esplicative, per ogni j = 1, . . . , k.

# impostiamo i dati

e <- rnorm(100,0,4) # genera 100 errori casuali da una normale come da specifiche
x_0 <- rep(1,100) # 100 valori uguali a 1 rappresenta l'intercetta beta0x_0
x_1 <- rnorm(100,-2,4) # primo predittore che ha 100 valori con una distribuzione normale
x_2 <- rnorm(100,3,4) # secondo predittore
x <- cbind(x_0,x_1,x_2) # creaiamo la matrice X ogni riga rappresenta un’osservazione, ogni colonna una variabile
beta <- runif(3,-2,2) # Genera 3 valori casuali da una distribuzione uniforme tra -2 e 2
y <- x%*%beta + e # Calcola la variabile dipendente (Y) come Y=Xβ+ε

# creiamo il modello di rigressione lineare
mq <- lm(y ~ x[,2] + x[,3])
summary(mq)

#Risultati nel nostro caso:
#Call:
#lm(formula = y ~ x[, 2] + x[, 3]) -->Y=β0+β1⋅x1+β2⋅x2+ε
# La funzione lm() (linear model) stima i coefficienti β tramite il metodo dei minimi quadrati (OLS).

#Residuals: --> i residui e_i= y_i-y^_i cioè le differenze tra valori osservati e valori predetti
#  Min      1Q  Median      3Q     Max 
#-6.9288 -2.6268 -0.3484  2.4947  7.1940 
#Min / Max: indicano l’intervallo di errore (da circa -6.9 a +7.2)
#1Q / Median / 3Q: mostrano la distribuzione dei residui
#Median ≈ 0: buono → significa che in media il modello non ha bias (non sovrastima né sottostima).

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)    
#(Intercept)  1.21227    0.44541   2.722  0.00770 ** 
#  x[, 2]      -0.28568    0.08943  -3.194  0.00189 ** 
#  x[, 3]       1.98374    0.08741  22.695  < 2e-16 ***
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# Colonne:
# Estimate       Stima del coefficiente β (cioè il valore stimato dal modello)
# Std. Error     Errore standard della stima (misura quanto è precisa la stima)
# t value        Statistica t = Estimate / Std.Error
# Pr(>|t|)       p-value associato al test dell’ipotesi nulla H0: β = 0

# Interpretazione dei risultati:
# (Intercept) = 1.212  
#   → Stima di β₀. Rappresenta il valore atteso di Y quando x₁ = x₂ = 0.
#     È statisticamente significativo (p = 0.0077 < 0.01).
#
# x[,2] = -0.286  
#   → Stima di β₁. A parità dell’altra variabile, un aumento di 1 unità in x₁
#     riduce Y di 0.286 unità in media.  
#     Il p-value (0.00189) mostra che è altamente significativo (p < 0.01).
#
# x[,3] = 1.984  
#   → Stima di β₂. Un aumento di 1 unità in x₂ aumenta Y di circa 1.98 unità
#     in media. È estremamente significativo (p < 2e-16).


#Residual standard error: 3.4 on 97 degrees of freedom
#Multiple R-squared:  0.8513,	Adjusted R-squared:  0.8483 
#F-statistic: 277.7 on 2 and 97 DF,  p-value: < 2.2e-16

res <- resid(mq)   # residui del modello
qqnorm(res)        # quantili teorici vs residui osservati
qqline(res, col="red", lwd=2)  # linea di riferimento

# L’obiettivo è confrontare la distribuzione dei residui del modello con una distribuzione normale teorica
# Se i punti seguono una linea retta, l’ipotesi di normalità è soddisfatta

coef<- coef(mq) # Estraiamo i coefficienti stimati dal modello lineare 'mq'
# 'coef(mq)' restituisce un vettore con:
#  - (Intercept): stima di β₀ (intercetta)
#  - x[,2]      : stima di β₁
#  - x[,3]      : stima di β₂

rbind(beta,coef) # Confrontiamo i valori veri (beta) con quelli stimati (coef)
# 'rbind()' unisce per righe due vettori o matrici.
# In questo modo possiamo vedere se le stime ottenute (coef)
# sono vicine ai parametri reali (beta) usati nella simulazione.
# Più i valori coincidono, meglio il modello ha ricostruito i parametri veri.

#->(Intercept)     x[, 2]   x[, 3]
#beta    1.451487 -0.3952724 1.899720
#coef    1.212266 -0.2856824 1.983736

confint(mq) # Calcoliamo gli intervalli di confidenza al 95% per ciascun coefficiente stimato
# 'confint(mq)' restituisce per ogni coefficiente due limiti:
#   - 2.5%  → estremo inferiore dell’intervallo di confidenza
#   - 97.5% → estremo superiore
# L’intervallo rappresenta il range di valori plausibili per il vero β.
# Se l’intervallo NON include 0, il coefficiente è statisticamente significativo.

#->              2.5 %    97.5 %
#(Intercept)  0.3282577  2.096274
#x[, 2]      -0.4631838 -0.108181
#x[, 3]       1.8102542  2.157218

#--------------------------------
# Proviamo ora a diminuire la varianza dell’errore " epsilon∼ N(0, 1)

e <- rnorm(100,0,1)
x_0 <- rep(1,100)
x_1 <- rnorm(100,-2,4)
x_2 <- rnorm(100,3,4)
x <- cbind(x_0,x_1,x_2)
beta <- runif(3,-2,2)
y <- x%*%beta + e
mq <- lm(y~ x[,2] +x[,3])
summary(mq)

#->Call:
#  lm(formula = y ~ x[, 2] + x[, 3])

#Residuals:
#  Min       1Q   Median       3Q      Max 
#-2.33165 -0.68766 -0.04592  0.70704  2.26309 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)    
#(Intercept)  1.47227    0.12719   11.58   <2e-16 ***
#  x[, 2]       1.64697    0.02259   72.90   <2e-16 ***
#  x[, 3]       1.23683    0.02321   53.29   <2e-16 ***
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Residual standard error: 1.032 on 97 degrees of freedom
#Multiple R-squared:  0.9876,	Adjusted R-squared:  0.9873 
#F-statistic:  3849 on 2 and 97 DF,  p-value: < 2.2e-16

res <- mq$residuals
qqnorm(res)
qqline(res, col="red", lwd=2)

coef<- coef(mq)
rbind(beta,coef)

#->(Intercept)   x[, 2]   x[, 3]
#beta    1.418019 1.646345 1.232419
#coef    1.472274 1.646969 1.236826

confint(mq)

#->             2.5 %   97.5 %
#(Intercept) 1.219840 1.724707
#x[, 2]      1.602130 1.691809
#x[, 3]      1.190765 1.282886

#------------------------------------------------------------
#  Confronto: varianza dell'errore alta vs bassa
#------------------------------------------------------------

n <- 100
x_0 <- rep(1, n)
x_1 <- rnorm(n, -2, 4)
x_2 <- rnorm(n, 3, 4)
x <- cbind(x_0, x_1, x_2)

# Parametri veri del modello (β)
beta <- c(1.5, 1.6, 1.2)

#------------------------------------------------------------
# Modello 1: errore con varianza alta (σ = 2)
#------------------------------------------------------------
e1 <- rnorm(n, 0, 2)  # ε ~ N(0, 4)
y1 <- x %*% beta + e1

mq1 <- lm(y1 ~ x[,2] + x[,3])
summary(mq1)

#------------------------------------------------------------
# Modello 2: errore con varianza bassa (σ = 1)
#------------------------------------------------------------
e2 <- rnorm(n, 0, 1)  # ε ~ N(0, 1)
y2 <- x %*% beta + e2

mq2 <- lm(y2 ~ x[,2] + x[,3])
summary(mq2)

#------------------------------------------------------------
# Confronto dei coefficienti veri e stimati
#------------------------------------------------------------
rbind(
  beta_veri = beta,
  stime_var_alta = coef(mq1),
  stime_var_bassa = coef(mq2)
)

#------------------------------------------------------------
# Confronto grafico tra i due modelli
#------------------------------------------------------------
par(mfrow = c(1, 2))  # due grafici affiancati

# Grafico 1: varianza alta
plot(y1 ~ x[,2], main = "Errore con varianza ALTA (σ=2)",
     xlab = "x1", ylab = "Y", col = "darkgray", pch = 16)
abline(mq1, col = "red", lwd = 2)  # retta stimata
legend("topleft", legend = c("Retta stimata"), col = "red", lwd = 2, bty = "n")

# Grafico 2: varianza bassa
plot(y2 ~ x[,2], main = "Errore con varianza BASSA (σ=1)",
     xlab = "x1", ylab = "Y", col = "darkgray", pch = 16)
abline(mq2, col = "blue", lwd = 2)
legend("topleft", legend = c("Retta stimata"), col = "blue", lwd = 2, bty = "n")

#------------------------------------------------------------
# Commento:
# - Nel primo grafico (σ=2) i punti sono più dispersi attorno alla retta:
#   → il modello ha più rumore, le stime sono meno precise.
# - Nel secondo grafico (σ=1) i punti sono molto più vicini alla retta:
#   → gli errori sono minori, il modello è più preciso e R² aumenta.
#------------------------------------------------------------