%% IMPORTO DATASET

T0 = readtable('DATA SET UFFICIALE.xlsx');
T2 = readtable('DATA SET UFFICIALE.xlsx','Sheet','YEAR');

opts = detectImportOptions('DATA SET UFFICIALE.xlsx');
opts = setvartype(opts,{'VenditaAuto'},'double');  %forzare lettura come 'double' al posto di 'char'

opts2 = detectImportOptions('DATA SET UFFICIALE.xlsx','Sheet','YEAR');
opts2 = setvartype(opts2,{'AnomalieSulRiscaldamento'},'double');  %forzare lettura come 'double' al posto di 'char'

T = readtable('DATA SET UFFICIALE.xlsx',opts);
T1 = readtable('DATA SET UFFICIALE.xlsx',opts2,'Sheet','YEAR');

%% RINOMINARE COLONNE
% T.Month = datetime(T.Month,"Format","dd-MM-uuuu"); in realtà non serve 
T.Properties.VariableNames = {'Rif_Mese','Emiss_C02_Carbo','Emiss_C02_GasNa','Emiss_C02_BenAe','Emiss_C02_CoODi','Emiss_C02_LiqId','Emiss_C02_CarJe','Emiss_C02_Keros','Emiss_C02_Lubri','Emiss_C02_BenMo','Emiss_C02_CokPe','Emiss_C02_CoORe','Emiss_C02_AltrP','Emiss_C02_Petro','Emiss_C02_NTotE','Produz_Carbone','Produz_GasNatur','Produz_PetrGreg','Produz_CFosTOT','Produz_Idroelet','Produz_Eolica','Produz_Biomasse','Produz_RinnoTOT','Produz_EnePrTOT','Consum_RinnoTOT','Consum_NRinnTOT','Consum_EnePrTOT','Import_EnePrTOT','Import_PetrOPEC','Consum_CFosTras','CDD','HDD','vendita_auto','Consum_petrolio_Trasp','Consum_Carb_Elettr','Consum_Carb_Indus'};

%% PLOT DATA
f1 = figure('Position',[100,100,1250,675])  %Scelta dimensioni
plot(T.Rif_Mese,T.Emiss_C02_NTotE,"LineWidth",1.3)
xlabel('Tempo [Anni]')
ylabel('Emissioni CO_{2} [mln di tonnellate]')
title('Emissioni CO_{2} per categoria. Anni: 1973-2021')
hold on
plot(T.Rif_Mese,T.Emiss_C02_Carbo,'Linewidth',1.3)
plot(T.Rif_Mese,T.Emiss_C02_GasNa,'Linewidth',1.3)
plot(T.Rif_Mese,T.Emiss_C02_Petro,'Linewidth',1.3)
ylim([0 700])
legend('Emissioni CO_{2} TOT','Emissioni CO_{2} da Carbone','Emissioni CO_{2} da Gas Naturale','Emissioni CO_{2} da Petrolio')
grid minor
saveas(f1,[pwd '\immagini\01.ConfrontoEmissioniCO2.png'])

f2 = figure('Position',[100,100,1250,675])  %Scelta dimensioni
plot(T.Rif_Mese,T.Produz_CFosTOT,'LineWidth',1.3)
xlabel('Tempo [Anni]')
ylabel('Produzione energia non rinnovabile [quadrilioni di BTU]')
title('Produzione energia non rinnovabile per categoria. Anni: 1973-2021')
hold on
plot(T.Rif_Mese,T.Produz_Carbone,'Linewidth',1.3)
plot(T.Rif_Mese,T.Produz_GasNatur,'Linewidth',1.3)
plot(T.Rif_Mese,T.Produz_PetrGreg,'Linewidth',1.3)
plot(T.Rif_Mese,T.Consum_NRinnTOT,'Linewidth',1.3)
legend('Prod. Combustibili Fossili (Non Rinnovabile) TOT','Prod. Carbone','Prod. Gas Naturale','Prod. Petrolio Greggio','Consumo Energia Non Rinnovabile TOT')
grid minor
saveas(f2,[pwd '\immagini\02.ConfrontoProduzioneNonRinnovabili.png'])

%% commento F2: 
% l'andamendo colorato in blu è la somma dei tre andamenti nella parte
% bassa del grafico e rappresenta la produzione totale di fonti di energia
% non rinnovabili. Allo stesso modo l'andamento in verde, come indicato in
% legenda, mostra l'andamento del consumo delle fonti di energia non
% rinnovabili. è immediato notare che il consumo è superiore alla
% produzione e per sopperire a questa mancanza gli stati uniti ricorrono
% all'importazione di combustibili fossili da paesi esteri membri
% dell'OPEC. Tuttavia in questi ultimi anni la produzione supera il consumo.
% gli stati uniti sono il paese che consume più petrolio al mondo, esso
% copre circa il 35% della domanda interna di energia e viene utilizzato
% soprattutto nel settore dei trasporti e dell'industria. 
% Da una prima analisi è possibile notare che dal 1975 al 2010 
% sono visibili andamenti più o meno regolari, tranne quello della produzione 
% del petrolio greggio che ha subito una lenta decrescita. Dal 2010 ai 
% giorni nostri è in decrescita la produzione di carbone in quanto il suo 
% utilizzo,soprattutto per produrre elettricità, è stato sostituito
% dall'utilizzo di liquidi derivanti dal petrolio e dall'utilizzo di fonti
% rinnovabili. La produzione di Petrolio Greggio dal 2010 ad oggi è quasi 
% duplicata; gli stati uniti sono infatti il terzo produttore al mondo di 
% greggio. Anche per quanto riguarda la produzione di gas naturale è possibile
% notare che dal 2010 ad oggil'andamento è in crescita grazie all'uso di 
% tecniche di trivellazione e di produzione più efficienti (che però producono 
% inquinamento atmosferico). Il gas naturale
% produce meno polveri sottili del carbone e dei prodotti petroliferi 
% raffinati. Ciò ha contribuito a un suo maggiore utilizzo nella produzione 
% di elettricità e nel settore dei trasporti. Tuttavia, il gas naturale è 
% fatto per lo più di metano, un potente gas a effetto serra che si disperde
% nell'atmosfera.

f3 = figure('Position',[100,100,1250,675])  %Scelta dimensioni
plot(T.Rif_Mese,T.Produz_RinnoTOT,'Linewidth',1.3)
xlabel('Tempo [Anni]')
ylabel('Produzione energia rinnovabile [quadrilioni di BTU]')
title('Produzione energia rinnovabile per categoria. Anni: 1973-2021')
hold on
plot(T.Rif_Mese,T.Produz_Idroelet,'Linewidth',1.3)
plot(T.Rif_Mese,T.Produz_Eolica,'Linewidth',1.3)
plot(T.Rif_Mese,T.Produz_Biomasse,'Linewidth',1.3)
plot(T.Rif_Mese,T.Consum_RinnoTOT,'Linewidth',1.3)
legend('Prod. Energia Rinnovabile TOT','Prod. Energia Idroelettrica','Prod. Energia Eolica','Prod. Energia da Biomassa','Consumo Energia Rinnovabile TOT')
grid minor
hold off
saveas(f3,[pwd '\immagini\03.ConfrontoProduzioneRinnovabili.png'])

%Grafico matrice di correlazione tra la crescita delle temperature e 
%provare a guardare il comando di matlab Heatmap()
%Variabili = (T2(:,[5,9,17:20])) %trasformo le colonne significative in matrice
%varNames = {'CombFos'; 'Rinnov'; 'TotCO2 USA'; 'RUSSIA'; 'CHINA';'CDD'};
%[R,PValue,H] = corrplot(Variabili,'varNames',varNames); %corr matrix

%% %% DOMANDA 1 --> Analisi della correlazione per stimare le emissioni di C02
%selezione ultimi 11 anni:
T11 = T([445:end],:);
%1. grafici distribuzioni
% Grafici delle distribuzioni
f4 = figure('Position',[100,100,1250,675])
histfit(T11.Emiss_C02_NTotE, 20,"normal")                               %sembra avere distribuzione normale
title('Distribuzione emissione C0_2 ')
xlabel('Quantità C0_2 emessa [Mln]') 
ylabel('Frequenza relativa [%]')
saveas(f4,[pwd '\immagini\04.DistribuzioneEmissioneC02.png'])
%2. indici normalità: curtosi e skewness
kurtosis(T11.Emiss_C02_NTotE)  
skewness(T11.Emiss_C02_NTotE)    
%3. test di normalità
%Jarque-Bera
[h,p,jbstat,critval] = jbtest(T11.Emiss_C02_NTotE, 0.05)   % Test al 5%   
[h1,p1,jbstat1,critval1] = jbtest(T11.Emiss_C02_NTotE, 0.01)   % Test al 1%  
[h2,p2,jbstat2,critval2] = jbtest(T11.Emiss_C02_NTotE, 0.10)   % Test al 10%
%I test ci permettono di affermare che la distribuzione è normale (2/3) 

%Lilliefors 
[h3,p3,dstat3,critval3] = lillietest(T11.Emiss_C02_NTotE,'Alpha',0.05)   %--> con lilliefors trovo che i dati sono normali
%Il test ci conferma l'ipotesi di normalità 

%{
%(BoxCox trasf normalizzante se prima esce H1)
[transdat,lambda] = boxcox(T11.Emiss_C02_NTotE)
T11_EMISSIONI_bc = boxcox(lambda,T11.Emiss_C02_NTotE); 
histfit((T11_EMISSIONI_bc),20,'normal')        

% lambda molto vicino a 0 --> trasformazione ottima è logaritmo
% lambda tra 1 e 2 --> trasf. ideale è elevamento al quadrato
T11_emissioni_bc_quadr = (T11_EMISSIONI_bc).^2;
histfit(T11_emissioni_bc_quadr,20,'normal')
skewness(T11_emissioni_bc_quadr)    
kurtosis(T11_emissioni_bc_quadr)    
%valuti se è cambiato qualcosa con test normalità
[h,p,jbstat,critval] = jbtest(T11_emissioni_bc_quadr,0.05)   % Test al 5% 
[h1,p1,jbstat1,critval1] = jbtest(T11_emissioni_bc_quadr,0.01)   % Test al 1% 
[h2,p2,jbstat2,critval2] = jbtest(T11_emissioni_bc_quadr, 0.10)   % Test al 10% 
[h3,p3,dstat3,critval3] = lillietest(T11_emissioni_bc_quadr,'Alpha',0.05)
%}

%4. scatter plot pre regressione
% Grafici multipli affiancati 
f5 = figure
subplot(1,2,1)
set(f5,'position',[100,100,1250,675]);
scatter(T11.Emiss_C02_NTotE,T11.Produz_Carbone)
h1 = lsline
h1.Color = 'r';
h1.LineWidth = 2;
title('Emissioni C0_2 vs Produzione Carbone')
xlabel('Quantità emessa [Mln di tonnellate]') 
ylabel('Produzione Carbone [quadrilioni di BTU]')
subplot(1,2,2)
scatter(T11.Emiss_C02_NTotE,T11.Produz_Eolica)
h2 = lsline
h2.Color = 'b';
h2.LineWidth = 2;
title('Emissioni C0_2 vs Produzione Eolica') 
xlabel('Quantità emessa [Mln di tonnellate]')
ylabel('Produzione Eolica [quadrilioni di BTU]')
saveas(f5,[pwd '\immagini\05.ScatterPlot_Carbone_Eolica.png'])

%5. correlazione lineare
tt = corr(T11{:,{'Emiss_C02_NTotE','Produz_Carbone','Produz_Eolica'}})
rowNames = {'Emissioni CO_2 TOT','Prod_Carbone','Prod_Eolica'};
colNames = {'Emissioni CO_2 TOT','Prod_Carbone','Prod_Eolica'};
sTable = array2table(tt,'RowNames',rowNames,'VariableNames',colNames)  

%Scatter per più variabili con R^2
f6 = figure
set(f6,'position',[100,100,1250,675]);
varNames = {'PEoli','PCarb','CRinn','CNRin','CFosTr','CarbEL','CarbIN','EmC02'};
[R,PValue,H] = corrplot(T11{:,{'Produz_Eolica','Produz_Carbone','Consum_RinnoTOT','Consum_NRinnTOT','Consum_CFosTras','Consum_Carb_Elettr','Consum_Carb_Indus','Emiss_C02_NTotE'}},'varNames',varNames)
saveas(f6,[pwd '\immagini\06.ScatterPlot_Produzioni_Consumi.png'])


%6. modello di regressione su variabili fortemente correlate
%%% REGRESSIONE LINEARE SEMPLICE
%Regressione lineare semplice: y_t = beta0 + beta1*x_t + epsilon_t
mhat = fitlm(T11,'ResponseVar','Emiss_C02_NTotE','PredictorVars','Consum_Carb_Elettr')   
%%% Coefficienti stimati
mhat.Coefficients
% Intercetta significativa ad ogni livello di significatività (pv < 0.01).
% Consumo Carbone sel settore elettrico significativo ad ogni livello di
% significatività (pv < 0.01).
% R-squared: 0.54, modello non molto significativo utilizzando però solo
% una variabile.

%%% Significatività complessiva del modello
anova(mhat,'summary')

%PLOT PER VERIFICARE CONFRONTO DATI VERI E STIMATI
f7 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese, T11.Emiss_C02_NTotE)
hold on
plot(T11.Rif_Mese, mhat.Fitted)
hold off
title('Emissioni C0_2 reali vs stimate (fitting lineare una variabile)') 
xlabel('Tempo [Mesi]')
ylabel('Quantità emessa [Mln di tonnellate]')
legend('Emissioni di CO2 dataset','Emissioni di C02 stimati')
saveas(f7,[pwd '\immagini\07.VenditeAuto_realeVSstimata_Regr_Sempl.png'])

%%% Adattamento del modello
mhat.Rsquared
% Il modello è in grado di spiegare l'30% della variabilità complessiva di Y
%%% Valori fittati dal modello: yhat_t
fit1 = mhat.Fitted             
%%% Residui di regressione: y_t - yhat_t
res1 = mhat.Residuals.Raw


%%%ANALISI dei residui
% Diagnostiche sui residui: normalità
f8 = figure()
set(f8,'position',[100,100,1250,675]);
subplot(1,2,1)
histfit(res1)
title('Distribuzione dei residui di regressione')
xlabel('Quantità emessa [Mln di tonnellate]') 
ylabel('Conteggio')

% Diagnostiche sui residui: incorrelazione tra fittati e residui
subplot(1,2,2)
scatter(fit1,res1)        
h1 = lsline
h1.Color = 'red';
h1.LineWidth = 2;
xlabel('Valori fittati'); 
ylabel('Residui di regressione');
%text(30,0.5,sprintf('rho = %0.3f',round(corr(res1,fit1),3)))
saveas(f8,[pwd '\immagini\08.Residui_Regr_Lin_EmissioniC02.png'])

% Indici normalità residui
skewness(res1)   
kurtosis(res1)                                                           %forte normalità
% Test normalità residui
[h,p,jbstat,critval] = jbtest(res1, 0.05)                               % pv = 0.0297 --> non normalità 
[h,p,jbstat,critval] = jbtest(res1, 0.01)                               % pv = 0.0297 --> normalità
[h,p,dstat,critval] = lillietest(res1,'Alpha',0.05)                     % pv = 0.001  --> non normalità
[h,p,ci,stats] = ttest(res1)                                            % normalità usando il range (ttest)
%I test ci permettono di affermare che la distribuzione è normale (3/4) 


%%% REGRESSIONE LINEARE MULTIPLA:
% Modello log-lineare: la dipendente è logaritmica, i regressori sono lineari
mhat2 = fitlm(T11,'ResponseVar','Emiss_C02_NTotE','PredictorVars',{'Produz_Eolica','Produz_Carbone','Consum_CFosTras','Produz_Biomasse','Consum_Carb_Elettr'})
%%% Coefficienti stimati
mhat2.Coefficients
% Intercetta significativa (pv < 0.01)
% Altre variabili significative (pv < 0.01) --> Consum. Carb elettr la più
% significativa
% R-squared: 0.725, migliore significatività del modello.

%confronto reali vs fitted (+ variabili)
f9 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese, T11.Emiss_C02_NTotE)
hold on
plot(T11.Rif_Mese, mhat2.Fitted)
hold off
title('Emssione C0_2 reali vs stimate (fitting lineare più variabili)') 
xlabel('Tempo [Mesi]')
ylabel('Quantità emessa [Mln di tonnellate]')
legend('Emissioni di CO2 dataset','Emissioni di C02 stimate')
saveas(f9,[pwd '\immagini\09.Emissioni_realiVSstimate_Regr_Multipla.png'])


anova(mhat2,'summary')
%%% Adattamento del modello
mhat2.Rsquared;
% Il modello è in grado di spiegare l'30% della variabilità complessiva di Y
%%% Valori fittati dal modello: yhat_t
fit2 = mhat2.Fitted;             
%%% Residui di regressione: y_t - yhat_t
res2 = mhat2.Residuals.Raw;

%%%ANALISI dei residui 
% Diagnostiche sui residui: normalità
f10 = figure()
set(f10,'position',[100,100,1250,675]);
subplot(1,2,1)
histfit(res2)
title('Distribuzione dei residui di regressione')
xlabel('Quantità emessa [Mln di tonnellate]') 
ylabel('Conteggio')

% Diagnostiche sui residui: incorrelazione tra fittati e residui
subplot(1,2,2)
scatter(fit2,res2)        
h1 = lsline
h1.Color = 'black';
h1.LineWidth = 2;
xlabel('Valori fittati'); 
ylabel('Residui di regressione');
%text(30,0.5,sprintf('rho = %0.3f',round(corr(res2,fit2),3)))
saveas(f10,[pwd '\immagini\10.Residui_Regr_Mul_EmissioneC02.png'])

% Indici normalità residui
skewness(res2)    
kurtosis(res2)                                                         %abbastanza vicini alla normalità
% Test normalità residui
[h,p,jbstat,critval] = jbtest(res2, 0.05);                              % pv = 0.228 --> normalità
[h,p,jbstat,critval] = jbtest(res2, 0.01);                              % pv = 0.228 --> normalità
[h,p,dstat,critval] = lillietest(res2,'Alpha',0.05)                     % pv = 0.307 --> normalità
[h3,p3,ci3,stats3] = ttest(res2)                                        % perfettamente normale
%I test ci permettono di affermare che la distribuzione è normale (4/4) 


%%% Model selection: STEPWISE regression  (in questo caso da modello vuoto a pieno)
% 1. Seleziono le colonne corrispondenti PRODUZIONE e CONSUMI
xvars = [{'Produz_Carbone'},{'Produz_GasNatur'},{'Produz_PetrGreg'},{'Produz_CFosTOT'},{'Produz_Idroelet'},{'Produz_Eolica'},{'Produz_Biomasse'},{'Produz_RinnoTOT'},{'Consum_RinnoTOT'},{'Consum_CFosTras'},{'Consum_petrolio_Trasp'},{'Consum_Carb_Elettr'},{'Consum_Carb_Indus'}];
T11_sel = T11(:,[xvars,{'Emiss_C02_NTotE'}]);
% 2. Applico algoritmo stepwise (dal modello vuoto a quello pieno)
% Divisione Predittori (X) e Variabile risposta (Y)
X = T11_sel{:,xvars};
y = T11_sel{:,'Emiss_C02_NTotE'};
[b,se,pval,in_stepwise,stats,nextstep,history] = stepwisefit(X,y,...
    'PRemove',0.15,'PEnter',0.10);                                          %penultimo rimuovo variabile se suo p-value < 15%
% 3. Valuto modello selezionato con stepwise
mhat_step = fitlm(T11_sel(:,[in_stepwise,true]),'ResponseVar','Emiss_C02_NTotE')
% 4. Osservo errore quadratico medio di previsione
disp('RMSE con stepwise model selection:')
disp(stats.rmse)

f11 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese, T11.Emiss_C02_NTotE)
hold on
plot(T11.Rif_Mese, mhat_step.Fitted)
hold off
title('Emssione C0_2 reali vs stimate (stepwise)') 
xlabel('Tempo [Mesi]')
ylabel('Quantità emessa [Mln di tonnellate]')
legend('Emissioni di CO2 dataset','Emissioni di C02 stimate')
saveas(f11,[pwd '\immagini\11.Emissioni_realiVSstimate_Stepwise.png'])

%COMMENTO MODELLO CON STEPWISE (R^2 = 0.863)


%%% Model selection: LASSO algorithm

% Lasso mediante la cross-validazione fa un ragionamento previsivo. Trovo
% quei valori penalizzati tale che la previsione è la migliore con un
% modello lineare.

% 1. Elenco tutte le variabili di regressione di interesse
xvars = [{'Produz_Carbone'},{'Produz_GasNatur'},{'Produz_PetrGreg'},{'Produz_CFosTOT'},{'Produz_Idroelet'},{'Produz_Eolica'},{'Produz_Biomasse'},{'Produz_RinnoTOT'},{'Consum_RinnoTOT'},{'Consum_CFosTras'},{'Consum_petrolio_Trasp'},{'Consum_Carb_Elettr'},{'Consum_Carb_Indus'}];

% Divisione dataset in training e test 
X = T11_sel(:,xvars);
X_train = X([1:111],:);
X_train_m = table2array(X_train);
X_test = X([112:end],:);
X_test_m = table2array(X_test);

y = T11_sel(:,'Emiss_C02_NTotE');
y_train = y([1:111],:);
y_train_m = table2array(y_train);
y_test = y([112:end],:);
y_test_m = table2array(y_test);

X2 = T11_sel([112:end],:);
periodo = T11.Rif_Mese;
Period = periodo([112:end],:);

% 2. Applico algoritmo stepwise (dal modello vuoto a quello pieno)
% Divisione Predittori (X) e Variabile risposta (Y)

%BHAT testa 100 lambda differenti e rispetto al numero di previsori che
%sono andato a dargli. Risultato output bhat matrice 14*100
[Bhat,lasso_st]=lasso(X_train_m,y_train_m,'CV',20,'MCReps',5,...
                'Options',statset('UseParallel',true),...
                'PredictorNames',xvars);
% 5. Identifico le variabili selezionate con LASSO
lasso_st.IndexMinMSE                                %--> migliore modello con bhat, è il 1 lambda
%sto selezionando le variabili che vanno bene ottenute con lasso e 
in_lasso = not(Bhat(:,lasso_st.IndexMinMSE)==0);

% 6. Valuto modello selezionato
mhat_lasso = fitlm(X2(:,[in_lasso(:)',true]),'ResponseVar','Emiss_C02_NTotE')
% 7 Osservo errore di previsione associato al modello selezionato
disp('RMSE con 20-folds cross-validation:')
disp(sqrt(lasso_st.MSE(lasso_st.IndexMinMSE)))

%Confronto
f12 = figure('Position',[100,100,1250,675])
plot(Period, y_test.Emiss_C02_NTotE)
hold on
plot(Period, mhat_lasso.Fitted)
hold off
title('Emssione C0_2 reali vs stimate (Lasso)') 
xlabel('Tempo [Mesi]')
ylabel('Quantità emessa [Mln di tonnellate]')
legend('Emissioni di CO2 dataset','Emissioni di C02 stimate')
saveas(f12,[pwd '\immagini\12.Emissioni_realiVSstimate_Lasso.png'])


%R^2 = 0.942

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Rappresentazione grafica della serie storica
plot(gas_agr.Data,gas_agr.Agricoltura)
title('Andamento delle vendite di gasolio agricolo dal 2014 a luglio 2020')
xlabel('Mese') 
ylabel('Tonnellate')

%% AUTOREGRESSIVI: Caratteristiche grafiche della serie: autocorrelazioni e distribuzione
figure
% Serie storica
subplot(2,2,1)      
plot(T11.Rif_Mese,T11.Produz_Idroelet);
title('Serie storica delle vendite di gasolio agricolo')
% Istogramma della distribuzione
subplot(2,2,2)       
histfit(T11.Produz_Idroelet,20,'Normal')
title('Istogramma della distribuzione')
% Autocorrelazioni
subplot(2,2,3)       
autocorr(T11.Produz_Idroelet, 36);
title('ACF delle innovazioni')
% Autocorrelazioni parziali
subplot(2,2,4)       
parcorr(T11.Produz_Idroelet, 36);
title('PACF delle innovazioni')
% in questo caso pacf si nota che è stagionale ritardo 12 (che tenende ad
% affievolirsi dopo 36 mesi)

% Test di Bera-Jarque di normalità - H0 = dati normali
[h,p,jbstat,critval] = jbtest(T11.Produz_Idroelet)
% Ad un livello del 1% i dati sono normali (pv > 0.01)

% Ljung-Box test per autocorrelazione
[h,pValue,stat,cValue] = lbqtest(T11.Produz_Idroelet,'lags',[1,2,13,25,36])

%%Durbin-Watson test per autocorrelazione
%questo test si chiede se c'è autocorrelazione a ritardo 1.
[pValue,stat] = dwtest(T11.Produz_Idroelet,ones(size(T11.Produz_Idroelet,1)-1,1),'Method','exact')
% pv = 0 --> Rigetto ipotesi nulla --> Valori autoregressivi

% Augmented-Dickey-Fuller test per stazionarietà
% H0 = la serie è non stazionaria
% H1 = la serie è stazionaria
[h,p,adfstat,critval] = adftest(T11.Produz_Idroelet,'model','TS','lags',0:24)

%%%%% Modelli ARIMA
%%% Modello la serie storica con modelli ARIMA(p,0,q) e SARIMA((p,0,q),(P,0,Q))
% ARIMA(p,0,q): y_t = alpha1*y_t-1 + ... + alphap*y_t-p + esp_t + ...
%                           theta_1*eps_t-1 + theta_q*eps_t-q
% Modello AR(12): y_t = alpha1*y_t-1 + alpha2*y_t-2 + ... + alpha12*y_t-12 + eps_t

%modello AR(12) --> metodo grezzo

AR12 = arima('ARLags',1:12);
EstAR12 = estimate(AR12,T11.Produz_Idroelet,'Display','off');  % mestimate uso la massima verosomiglianza per stimare parametri
summarize(EstAR12); %mostra risultati modello
%Trovo i residui (detti anche innovazioni) dell'Arima.
innov = infer(EstAR12, T11.Produz_Idroelet, 'Y0',T11.Produz_Idroelet(1:12)); % il terzo parametro dò la serie con valori pari al numero di AR scelto in questo caso 12
fitted = T11.Produz_Idroelet + innov;  %fitted sarebbero "y cappello" calcolati in quel modo.

%%% Grafico della serie osservata e stimata/fittata
%%% SOVRASTIMA TALVOLTA I PICCHI.
figure
plot(T11.Rif_Mese,T11.Produz_Idroelet)
hold on
plot(T11.Rif_Mese,fitted)
legend('Osservata','Fittata AR(12)')
title('Serie storica osservata e fittata con AR(12)')



%%%%%


rinn_T11 = T11.Produz_RinnoTOT;
periodo = T11.Rif_Mese
train_idroel = rinn_T11([1:111],:);
test_idroel = rinn_T11([112:end],:);   %20
Period = periodo([112:end],:)

%%super-interessante

%%%%% Modelli Seasonal ARIMA
% Modello SARIMA((1,0,0),(12,0,0))
% y_t = alpha1*y_t-1 + Alpha12*y_t-12 + eps_t
SAR112 = arima('ARLags',1,'MALags',1,'SARLags',12);
EstSAR112 = estimate(SAR112,train_idroel,'Display','off');
summarize(EstSAR112);
innovSAR112 = infer(EstSAR112, T11.Produz_RinnoTOT, 'Y0',T11.Produz_RinnoTOT(1:14));   %13 perchè 12 ritardi SARIMA + 1 AR(1)
fittedSAR112 = T11.Produz_RinnoTOT + innov;

mhat = forecast(EstSAR112,28,test_idroel)

%%% Grafico della serie osservata e stimata/fittata
figure
plot(Period,test_idroel)
hold on
%plot(T11.Rif_Mese,fittedSAR112)
plot(Period,mhat)
legend('Osservata','SARIMA((1,0,0),(12,0,0))','AR(12)')
title('Serie storica osservata e fittata con SARIMA((1,0,0),(12,0,0))')

RMSE = sqrt(mean((test_idroel - mhat).^2));  % Root Mean Squared Error

%%%%%%%%% USARE ARIMA CON MA ordine 1,2,3 per differenziare la serie

MA11 = arima(2,2,2)
MAS11 = estimate(MA11,T11.Consum_RinnoTOT,'Display','off');
summarize(MAS11);
innovMA112 = infer(MAS11, T11.Consum_RinnoTOT, 'Y0',T11.Consum_RinnoTOT(1:4));   %13 perchè 12 ritardi SARIMA + 1 AR(1)
fittedMA112 = T11.Produz_Idroelet + innov;

figure
plot(T11.Rif_Mese,T11.Consum_RinnoTOT)
hold on
plot(T11.Rif_Mese,fittedMA112)
legend('Osservata','MA (1,1,0)')
title('Serie storica osservata e fittata con SARIMA((1,0,0),(12,0,0))')

