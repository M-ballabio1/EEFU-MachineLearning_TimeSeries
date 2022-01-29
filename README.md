# Analysis and forecast of C02 emissions

Il progetto verte sulla previsione delle emissioni di C02 negli USA utilizzando differenti metodi statistici e di machine learning:

1. metodi di regressione statica (regressioni multiple, stepwise method, Lasso regression)
2. metodi autoregressivi (modelli ARIMA, GARCH, RegARIMA)
3. metodi di regressione dinamica (modelli State-space, filtro di Kalman)

A seguito viene mostrata un'analisi esplorativa delle emissioni di C02 totali e nei settori principali statiunitensi.
![emissi](https://user-images.githubusercontent.com/78934727/151664933-90a6ecfc-3ecb-47ba-8878-6df87d32a691.png)

### 1. Metodi di regressione utilizzando LASSO:
E' stato svolta una previsione statistica utilizzando un algoritmo sofisticato chiamato Lasso che permette di calcolare i Beta della regressione utilizzando OLS penalizzati.
I risultati ottenuti utilizzando solamente variabili singole (singoli andamenti es: produzione di Petrolio) è: R^2 = 0.794 (in Cross-validazione).
![lasso](https://user-images.githubusercontent.com/78934727/151664939-56131e4a-ea69-455b-8409-ce625433c8ce.png)

Il risultato ottenuto invece con predittori aggregati usando una regressione multipla, ha ottenuti risultati eccellenti con R^2=0.961
![reg_mult_aggreg](https://user-images.githubusercontent.com/78934727/151665013-e5976cf7-7387-42d9-8057-1fc89df7b8a8.png)


### 2. Previsione utilizzando modelli ARIMA considerando solamente il test set (ultimi 24 mesi):
Il risultato è fortemente influenzato dalla variabile esogena COVID-19. Il modello ottimo sul test-set è un ARIMA(2,0,2) con RMSE=24.13.
![testset](https://user-images.githubusercontent.com/78934727/151664945-628f48cb-12c1-4450-88e1-caba827f05fb.png)


### 3. Regressione dinamica ottima
Sono stati applicati modelli state-space con variabili predittive climatiche (HDD, CDD, Humidity) per stimare emissioni di C02. 
Il risultato ottimo si ottiene con una modello statico nei primi 9 anni e dinamico negli ultimi 2 anni (COVID-19) con un R^2 = 0.681
![modello_ibrido](https://user-images.githubusercontent.com/78934727/151664845-6c564487-872b-47e3-a72b-ebb228e29b5f.png)


