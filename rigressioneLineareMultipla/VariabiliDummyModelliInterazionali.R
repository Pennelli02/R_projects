#Consideriamo i dati di 111 adolescenti relative alle loro altezze e a quelle dei
#loro familiari (BiJma and Van der Vaart).
#Variabili:
#  • Y : altezza dell’adolescente
#  • padre: altezza del padre
#  • madre: altezza della madre
#  • femm: genere dell’adolescente (1=femmine)


rm(list = ls()) # per pulire l'ambiente
# carichiamo i valori
altezze = structure(list(Y = c(170, 175, 171, 167, 180, 169, 169, 183,
                               174, 173, 163, 199, 186, 178, 179, 175, 176, 170, 176, 180, 176,
                               193, 168, 168, 171, 188, 169, 184, 189, 173, 185, 177, 186, 190,
                               162, 174, 170, 174, 164, 182, 159, 171, 170, 187, 184, 174, 171,
                               183, 162, 172, 169.5, 179, 176, 175, 191, 189, 183, 164, 186,
                               174, 191, 179, 175, 174, 173, 185, 169, 183, 170, 185, 189, 197,
                               179, 171, 198, 180, 196, 174, 168, 170, 163, 167, 171, 165, 167,
                               176, 164, 184, 169, 185, 170, 178, 187, 158, 178, 185, 180, 171,
                               165, 189, 170, 183, 173, 160, 168, 167.25, 179, 180, 180.5, 169,
                               170.75), padre = c(180, 173, 178, 180, 190, 169, 189, 196, 182,
                                                  176, 167, 182, 183, 176, 176, 174, 181, 171, 183, 184, 165, 189,
                                                  188, 189, 175, 184, 175, 185, 177, 178, 174, 167, 178, 178, 183,
                                                  182, 183, 177, 173, 176, 183, 177, 172, 181, 177, 174, 185, 182,
                                                  176, 167, 179, 179, 182, 186, 187, 179, 179, 174, 188, 178, 184,
                                                  182, 172, 168, 182, 183, 179, 172, 191, 177, 181, 180, 182, 183,
                                                  186, 177, 187, 168, 183, 177.5, 179, 181, 176, 171, 176, 179,
                                                  180, 184, 164, 176, 183, 186, 180, 171, 189, 188, 176, 181, 173,
                                                  180, 180, 187, 176, 172, 176.5, 178.8, 180, 172.3, 177.4, 169,
                                                  176.9), madre = c(164, 165, 176, 168, 167, 169, 168, 173, 163,
                                                                    176, 168, 164, 173, 167, 176, 175, 164, 168, 170, 169, 170, 182,
                                                                    172, 170, 171, 170, 171, 164, 177, 169, 169, 171, 169, 168, 160,
                                                                    167, 163, 167, 164, 157, 160, 165, 166, 169, 163, 168, 177, 165,
                                                                    165, 155, 159, 166, 165, 164, 169, 163, 174, 160, 167, 172, 167,
                                                                    169, 168, 171, 174, 167, 170, 170, 163, 172, 165, 180, 176, 168,
                                                                    174, 168, 174, 172, 167, 153.5, 164, 161, 170, 157, 176, 168,
                                                                    160, 171, 165, 167, 160, 172, 170, 155, 167, 177, 168, 165, 162,
                                                                    169, 165, 178, 172, 162, 173, 167.5, 162, 165.7, 161.3, 160.5,
                                                                    167.5), femm = c(1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1,
                                                                                     1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1,
                                                                                     1, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0,
                                                                                     1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1,
                                                                                     1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1,
                                                                                     0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1)), row.names = c(NA, -111L
                                                                                     ), class = "data.frame")
#------------------------------------------------------------
# Spiegazione di questi attributi nel data frame 'altezze'
#------------------------------------------------------------

# row.names = c(NA, -111L)
# - Definisce i nomi delle righe del data frame.
# - NA indica che non ci sono nomi specifici assegnati dall’utente.
# - -111L indica che il data frame ha 111 righe.
#   R usa il numero negativo per memorizzare la dimensione quando genera automaticamente
#   i nomi delle righe da 1 a 111.
# → In pratica, le righe saranno numerate automaticamente da 1 a 111.

# class = "data.frame"
# - Imposta la classe dell’oggetto come data frame.
# - Questo permette di usare tutte le operazioni tipiche sui data frame:
#   subset(), head(), lm(), ecc.
# - Senza questo attributo, l’oggetto sarebbe solo una lista, 
#   e non si comporterebbe come un data frame.

# Nota pratica:
# - Normalmente, quando crei un data frame con data.frame(), R gestisce automaticamente
#   row.names e class. 
# - Qui è stato usato structure() per salvare in modo esplicito tutti gli attributi
#   dell’oggetto.

str(altezze)
attach(altezze) #Serve per rendere le colonne di un data frame direttamente accessibili come variabili

#Consideriamo il modello additivo
# E(Y |X) = β0 + β1padre + β2madre + β3femm

mq <- lm(Y ~ padre + madre + femm)
summary(mq)

#Consideriamo il modello con l’interazione
#E(Y |X) = β0+β1padre+β2madre+β3femm+β4padre∗femm+β5madre∗femm

mq1 <- lm(Y ~ padre + madre + femm + padre*femm + madre*femm)
summary(mq1)

#Consideriamo il modello additivo ridotto in cui l’effetto dell’altezza del padre e della madre `e lo stesso
#E(Y |X) = β0 + β1(padre + madre) + β2femm

genitori = padre+madre
mq2 <- lm(Y ~ genitori + femm )
summary(mq2)

e = Y - fitted.values(mq2)  # calcola i residui del modello: differenza tra valori osservati e predetti
qqnorm(e)
