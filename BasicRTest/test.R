# ==========================================================
# Script 2: Lettura di un file CSV e analisi semplice
# ==========================================================

# 1. Creiamo un piccolo dataset e lo salviamo in un CSV
dati <- data.frame(
  Nome = c("Anna", "Luca", "Marco", "Sara", "Elena"),
  Età = c(25, 30, 22, 28, 35),
  Altezza_cm = c(165, 180, 175, 160, 170)
)

# Salva il dataset come file CSV nella cartella di lavoro
write.csv(dati, "persone.csv", row.names = FALSE)
cat("File 'persone.csv' salvato nella directory di lavoro.\n\n")

# 2. Leggiamo il file appena salvato
dati_letti <- read.csv("persone.csv")

# 3. Mostriamo il contenuto
cat("Contenuto del file CSV:\n")
print(dati_letti)

# 4. Calcoliamo la media dell'età
media_eta <- mean(dati_letti$Età)
cat("\nEtà media:", media_eta, "\n")

# 5. Grafico dell’età
barplot(dati_letti$Età,
        names.arg = dati_letti$Nome,
        col = "skyblue",
        main = "Età delle persone",
        xlab = "Nome",
        ylab = "Età")

