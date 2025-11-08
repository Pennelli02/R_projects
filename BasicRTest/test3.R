# ==========================================================
# Script 3: Generazione di un istogramma
# ==========================================================

# 1. Generiamo 100 numeri casuali da una distribuzione normale
set.seed(123)  # per rendere il risultato ripetibile
dati <- rnorm(100, mean = 50, sd = 10)

# 2. Calcoliamo media e deviazione standard
media <- mean(dati)
dev_std <- sd(dati)

# 3. Stampiamo i risultati
cat("Media =", round(media, 2), " | Deviazione standard =", round(dev_std, 2), "\n")

# 4. Disegniamo un istogramma
hist(dati,
     breaks = 10,
     col = "lightgreen",
     main = "Distribuzione dei dati casuali",
     xlab = "Valori",
     ylab = "Frequenza")

# 5. Aggiungiamo una linea rossa sulla media
abline(v = media, col = "red", lwd = 2)

