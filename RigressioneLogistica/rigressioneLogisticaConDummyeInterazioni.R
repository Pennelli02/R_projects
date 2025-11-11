#Si vuole studiare l’effetto analgesico di un trattamento su pazienti anziani con
#nevralgia. La variabile risposta `e Pain relativa alla presenza o assenza di dolore.

#Variabili:
#  • Age: et`a in anni
#  • Sex: genere del paziente
#  • Duration: durata del malessere prima dell’inizio del trattamento
#  • treatment: trattamento con 3 livelli (”A”, ”B”, ”P”= placebo)
rm(list = ls())

neuralgia =
  structure(list(Treatment = structure(c(3L, 2L, 3L, 3L, 2L, 2L,
                                         1L, 2L, 2L, 1L, 1L, 1L, 2L, 1L, 3L, 1L, 3L, 1L, 3L, 2L, 2L, 1L,
                                         1L, 1L, 2L, 3L, 2L, 2L, 3L, 3L, 1L, 1L, 2L, 2L, 2L, 1L, 3L, 2L,
                                         2L, 3L, 3L, 3L, 1L, 2L, 1L, 3L, 3L, 1L, 2L, 3L, 3L, 3L, 2L, 1L,
                                         3L, 1L, 3L, 1L, 2L, 1L), .Label = c(" A", " B", " P"
                                         ), class = "factor"), Sex = structure(c(1L, 2L, 1L, 2L, 1L, 1L,
                                                                                 1L, 1L, 1L, 2L, 1L, 1L, 1L, 2L, 1L, 1L, 2L, 1L, 2L, 2L, 2L, 1L,
                                                                                 2L, 2L, 1L, 2L, 1L, 2L, 2L, 1L, 2L, 1L, 1L, 2L, 2L, 2L, 2L, 2L,
                                                                                 1L, 2L, 1L, 2L, 2L, 2L, 1L, 1L, 1L, 2L, 1L, 1L, 2L, 2L, 2L, 2L,
                                                                                 1L, 2L, 1L, 1L, 2L, 1L), .Label = c(" F", " M"), class = "factor"),
                 Age = c(68L, 74L, 67L, 66L, 67L, 77L, 71L, 72L, 76L, 71L,
                         63L, 69L, 66L, 62L, 64L, 64L, 74L, 72L, 70L, 66L, 59L, 64L,
                         70L, 69L, 78L, 83L, 69L, 75L, 77L, 79L, 70L, 69L, 65L, 70L,
                         67L, 76L, 78L, 77L, 69L, 66L, 65L, 60L, 78L, 75L, 67L, 72L,
                         70L, 75L, 65L, 68L, 68L, 67L, 70L, 65L, 67L, 67L, 72L, 74L,
                         80L, 69L), Duration = c(1L, 16L, 30L, 26L, 28L, 16L, 12L,
                                                 50L, 9L, 17L, 27L, 18L, 12L, 42L, 1L, 17L, 4L, 25L, 1L, 19L,
                                                 29L, 30L, 28L, 1L, 1L, 1L, 42L, 30L, 29L, 20L, 12L, 12L,
                                                 14L, 1L, 23L, 25L, 12L, 1L, 24L, 4L, 29L, 26L, 15L, 21L,
                                                 11L, 27L, 13L, 6L, 7L, 27L, 11L, 17L, 22L, 15L, 1L, 10L,
                                                 11L, 1L, 21L, 3L), Pain = structure(c(2L, 1L, 1L, 5L, 1L,
                                                                                       1L, 2L, 1L, 4L, 5L, 1L, 4L, 3L, 1L, 4L, 2L, 1L, 1L, 5L, 1L,
                                                                                       1L, 2L, 1L, 1L, 2L, 4L, 1L, 5L, 4L, 4L, 2L, 1L, 1L, 2L, 1L,
                                                                                       4L, 5L, 4L, 1L, 5L, 1L, 4L, 5L, 4L, 1L, 2L, 4L, 4L, 2L, 4L,
                                                                                       4L, 5L, 1L, 1L, 5L, 1L, 4L, 2L, 4L, 1L),
                                                                                     .Label = c(" No "," No ", " No ", " Yes", " Yes "),
                                                                                     class = "factor")), class = "data.frame", row.names = c(NA,
                                                                                                                                             -60L))
str(neuralgia)
attach(neuralgia)

fit <- glm(Pain ~ Treatment + Sex + Age + Duration,
           family="binomial")
summary(fit)

# L'AIC (Akaike Information Criterion) misura il compromesso tra bontà di adattamento e semplicità del modello.
# Valori più bassi indicano modelli più efficienti (miglior fit con meno complessità).
# L'AIC non ha un significato assoluto, ma serve per confrontare modelli sullo stesso dataset.

fit2 <- glm(Pain ~ Treatment + Age + Duration, family="binomial")
summary(fit2)

#Consideriamo ora un modello piu` ampio in cui consideriamo anche l’interazione
#del trattamento con altre variabili, per valutare se l’effetto del trattamento `e
#eterogeneo

fit4 <- glm(Pain ~ Treatment*Age + Duration, family="binomial")
summary(fit4)

fit5 <- glm(Pain ~ Treatment*Duration + Age, family="binomial")
summary(fit5)

#Commento: i dati sembrano non supportare l’ipotesi di trattamento eterogeneo