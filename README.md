# Analysis and forecast of C02 emissions

Il progetto verte sulla previsione delle emissioni di C02 negli USA utilizzando differenti metodi statistici e di machine learning:

1. metodi di regressione statica (regressioni multiple, stepwise method, Lasso regression)
2. metodi autoregressivi (modelli ARIMA, GARCH, RegARIMA)
3. metodi di regressione dinamica (modelli State-space, filtro di Kalman)

A seguito viene mostrata un'analisi esplorativa delle emissioni di C02 totali e nei settori principali statiunitensi.
![01 ConfrontoEmissioniCO2](https://user-images.githubusercontent.com/78934727/151664771-baeda02e-6d81-48d4-ab08-e3927a38b7f8.png)


### 1. Metodi di regressione utilizzando LASSO:
E' stato svolta una previsione statistica utilizzando un algoritmo sofisticato chiamato Lasso che permette di calcolare i Beta della regressione utilizzando OLS penalizzati.
I risultati ottenuti utilizzando solamente variabili singole (singoli andamenti es: produzione di Petrolio) è: R^2 = 0.794 (in Cross-validazione).

![12 Emissioni_realiVSstimate_Lasso](https://user-images.githubusercontent.com/78934727/151664778-ce827a4b-9769-4ddb-89ce-1f6c59c4c3eb.png)


### 2. Previsione utilizzando modelli ARIMA considerando solamente il test set (ultimi 24 mesi):
Il risultato è fortemente influenzato dalla variabile esogena COVID-19. Il modello ottimo sul test-set è un ARIMA(2,0,2) con RMSE=24.13.

![16a ConfrontoModelli_test](https://user-images.githubusercontent.com/78934727/151664802-2e085ff0-4ef0-4502-ba30-0c0b9e61ad92.png)

### 3. Regressione dinamica ottima
Sono stati applicati modelli state-space con variabili predittive climatiche (HDD, CDD, Humidity) per stimare emissioni di C02. 
Il risultato ottimo si ottiene con una modello statico nei primi 9 anni e dinamico negli ultimi 2 anni (COVID-19) con un R^2 = 0.681

![modello_ibrido](https://user-images.githubusercontent.com/78934727/151664845-6c564487-872b-47e3-a72b-ebb228e29b5f.png)


