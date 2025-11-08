# ==========================================================
#  Semplice script di test in R
# ==========================================================

# 1. Stampa un messaggio
cat("Ciao da RStudio! 🎉\n")

# 2. Crea un piccolo vettore numerico
numeri <- c(1, 2, 3, 4, 5)

# 3. Calcola la media
media <- mean(numeri)

# 4. Mostra il risultato
cat("La media dei numeri è:", media, "\n")

# 5. Crea un semplice grafico
plot(numeri,
     type = "b",         # linee e punti
     col = "blue",       # colore
     pch = 19,           # tipo di punto
     main = "Grafico di test",
     xlab = "Indice",
     ylab = "Valore")

# 6. Aggiunge una linea orizzontale con la media
abline(h = media, col = "red", lwd = 2)
text(3, media + 0.2, paste("Media =", media), col = "red")
