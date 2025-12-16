# Modelli Statistici in R

## Descrizione del Progetto

Raccolta di script R per l'analisi statistica e la modellazione predittiva, sviluppati durante il corso di Statistica. Il progetto include implementazioni pratiche di regressione lineare, regressione logistica, algoritmi di selezione del modello e analisi di dataset reali.

## Obiettivi

- Implementare modelli di regressione lineare semplice e multipla
- Applicare regressione logistica per variabili binarie
- Utilizzare algoritmi di selezione delle variabili (Forward, Backward, Stepwise)
- Analizzare fenomeni di overfitting e tecniche di penalizzazione
- Visualizzare e interpretare risultati statistici

## Struttura del Progetto
```
├── BasicRTest/                           # Script introduttivi
│   ├── test.R                           # Lettura CSV e analisi base
│   ├── test2.R                          # Grafici e statistiche descrittive
│   └── test3.R                          # Distribuzioni e istogrammi
│
├── rigressioneLineareMultipla/          # Regressione lineare multipla
│   ├── simpleRegressionLinearModel.R    # Simulazioni e confronti
│   ├── ImportDataset.R                  # Analisi dataset whiteside
│   └── VariabiliDummyModelliInterazionali.R  # Dummy e interazioni
│
├── RigressioneLogistica/                # Regressione logistica
│   ├── SimulazioneModelloRigressioneLineare.R
│   ├── TestModelloRigressioneSuDataset.R
│   ├── QuantitàParametriUsareRIgressioneLogistica.R
│   └── rigressioneLogisticaConDummyeInterazioni.R
│
├── AlgoritmiSelezioneModello/           # Selezione variabili
│   ├── Overfitting.R                    # Esempi di overfitting
│   └── testPValue&Penalizzazione.R      # Forward/Backward/AIC/BIC
│
└── README.md
```

## Contenuti Principali

### 1. Regressione Lineare Multipla

**Modello**: `Y = β₀ + β₁X₁ + β₂X₂ + ... + βₖXₖ + ε`

#### Script Principali

- **simpleRegressionLinearModel.R**
  - Simulazione di modelli lineari con errori gaussiani
  - Confronto tra varianza alta e bassa dell'errore
  - Validazione tramite Q-Q plot e intervalli di confidenza

- **ImportDataset.R** (Dataset: Whiteside)
  - Analisi del consumo di gas in funzione di temperatura e isolamento
  - Modelli additivi vs. modelli con interazione
  - Visualizzazione degli effetti di interazione

- **VariabiliDummyModelliInterazionali.R** (Dataset: Altezze)
  - Regressione con variabili dummy (genere)
  - Modelli con interazioni tra variabili continue e categoriche
  - Test di significatività dei coefficienti

### 2. Regressione Logistica

**Modello**: `logit(P(Y=1)) = β₀ + β₁X₁ + ... + βₖXₖ`

#### Script Principali

- **SimulazioneModelloRigressioneLineare.R**
  - Generazione dati da modello logistico
  - Studio dell'effetto della dimensione campionaria (n=100 vs n=500)
  - Proprietà asintotiche degli stimatori

- **TestModelloRigressioneSuDataset.R** (Dataset: Kyphosis)
  - Predizione presenza di difetti post-operazione
  - Confronto modelli con diverse combinazioni di predittori
  - Selezione del modello ottimale

- **QuantitàParametriUsareRIgressioneLogistica.R** (Dataset: Textile)
  - Analisi dell'effetto del processo produttivo sui difetti
  - Confronto tra modelli separati e congiunti
  - Ellissi di confidenza per parametri multipli

- **rigressioneLogisticaConDummyeInterazioni.R** (Dataset: Neuralgia)
  - Modelli con variabili categoriche multi-livello (Treatment: A, B, P)
  - Test di interazioni per eterogeneità del trattamento
  - Interpretazione tramite AIC

### 3. Algoritmi di Selezione del Modello

#### Overfitting.R
- Esempio pratico di overfitting con polinomi di grado crescente
- Visualizzazione del fenomeno
- Analisi di R², R² aggiustato, statistica F

**Modello simulato**: `Y = (X - 0.25)² + 1 + ε`, con `ε ~ N(0, 0.1²)`

**Polinomi testati**: da grado 1 fino a grado 12

#### testPValue&Penalizzazione.R (Dataset: Cement)

Implementazione di 3 metodi di selezione:

**1. Selezione tramite p-value**
- **Backward**: partenza dal modello completo, eliminazione variabile con p-value massimo
- **Forward**: partenza dal modello nullo, aggiunta variabile con p-value minimo
- **Both**: combinazione di forward e backward

**2. Penalizzazione con criteri di informazione**
- **AIC** (Akaike): `AIC = -2log(L) + 2k` (k=2)
- **BIC** (Bayesian): `BIC = -2log(L) + k·log(n)` (k=log(n))
- **Verosimiglianza**: senza penalizzazione (k=0)

**3. Libreria SignifReg**
- Test multipli con aggiustamento Bonferroni/FDR
- Procedure automatiche con diversi criteri

## Installazione

### Prerequisiti
```r
# R version 4.0.0 o superiore
# RStudio (opzionale ma consigliato)
```
## Visualizzazioni

Il progetto include vari tipi di grafici:
- **Scatter plot** con rette di regressione
- **Q-Q plot** per normalità residui
- **Curve logistiche** con probabilità stimate
- **Ellissi di confidenza** per parametri bivariati
- **Grafici diagnostici** per assunzioni del modello

## Licenza
MIT

---

