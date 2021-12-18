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
T.Properties.VariableNames = {'Rif_Mese','Emiss_C02_Carbo','Emiss_C02_GasNa','Emiss_C02_BenAe','Emiss_C02_CoODi','Emiss_C02_LiqId','Emiss_C02_CarJe','Emiss_C02_Keros','Emiss_C02_Lubri','Emiss_C02_BenMo','Emiss_C02_CokPe','Emiss_C02_CoORe','Emiss_C02_AltrP','Emiss_C02_Petro','Emiss_C02_NTotE','Produz_Carbone','Produz_GasNatur','Produz_PetrGreg','Produz_CFosTOT','Produz_Idroelet','Produz_Eolica','Produz_Biomasse','Produz_RinnoTOT','Produz_EnePrTOT','Consum_RinnoTOT','Consum_NRinnTOT','Consum_EnePrTOT','Import_EnePrTOT','Import_PetrOPEC','Consum_CFosTras','CDD','HDD','vendita_auto','Consum_petrolio_Trasp'}

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

%% %% DOMANDA 1 --> Come varia il consumo di fonti di energia (rinnovabili e non) in relazione alla vendita di auto a combustibile fossile?
%selezione ultimi 11 anni:
T11 = T([445:end],:)
%1. grafici distribuzioni
% Grafici delle distribuzioni
f4 = figure('Position',[100,100,1250,675])
histfit(T11.vendita_auto, 20,"normal")   %CAMBIARE COLONNA CON VENDITA AUTO.
title('Distribuzione della vendita auto')
xlabel('Mln') 
ylabel('%')
saveas(f4,[pwd '\immagini\04.DistribuzioneVenditeAuto.png'])
%gli inquinanti hanno normalmente una coda dx molto lunga (tipo
%chi-quadrato)
%2. test di normalità
%Indicatori di normalità: curtosi e skewness
skewness(T11.vendita_auto)    % Asimmetria positiva
kurtosis(T11.vendita_auto)    % Platicurticità
%3. trasformazioni normalizzanti
[h,p,jbstat,critval] = jbtest(T11.vendita_auto, 0.05)   % Test al 5% --> Rigetto H0 --> non norm       ---> SICCOME TROVO 4% di p-value e la soglia è 5% rigehtto HO
[h1,p1,jbstat1,critval1] = jbtest(T11.vendita_auto, 0.01)   % Test al 1% --> Non rigetto H0 --> norm   --> IN QUESTO CASO LA soglia è 1% non posso rigettare
[h2,p2,jbstat2,critval2] = jbtest(T11.vendita_auto, 0.10)   % Test al 1% --> Non rigetto H0 --> norm   --> IN QUESTO CASO LA soglia è 1% non posso rigettare
%Lilliefors 
[h3,p3,dstat3,critval3] = lillietest(T11.vendita_auto,'Alpha',0.05)   %--> con lilliefors trovo che i dati non sono normali
% PV < 0.01 --> Rigetto H0 sia al 1% che al 5%



%(BoxCox trasf normalizzante se prima esce H1)
[transdat,lambda] = boxcox(T11.vendita_auto)
T11_vendita_auto_bc = boxcox(lambda,T11.vendita_auto);   %ho applicato lambda alla T11.vendita auto --> trovo lambda circa 1.5 allora provo il quadrato (^2)
histfit((T11_vendita_auto_bc),20,'normal')         %applico elevamento quadrato

% lambda molto vicino a 0 --> trasformazione ottima è logaritmo
% lambda tra 1 e 2 --> trasf. ideale è elevamento al quadrato
T11_vendita_auto_bc_quadr = log(T11_vendita_auto_bc);
histfit(T11_vendita_auto_bc_quadr,20,'normal')
skewness(T11_vendita_auto_bc_quadr)    % Asimmetria positiva
kurtosis(T11_vendita_auto_bc_quadr)    % Platicurticità
%valuti se è cambiato qualcosa con test normalità
[h,p,jbstat,critval] = jbtest(T11_vendita_auto_bc_quadr,0.05)   % Test al 5% --> Non rigetto H0 --> norm
[h1,p1,jbstat1,critval1] = jbtest(T11_vendita_auto_bc_quadr,0.01)   % Test al 1% --> Non rigetto H0 --> norm
[h2,p2,jbstat2,critval2] = jbtest(T11_vendita_auto_bc_quadr, 0.10)   % Test al 1% --> Non rigetto H0 --> norm   --> IN QUESTO CASO LA soglia è 1% non posso rigettare
[h3,p3,dstat3,critval3] = lillietest(T11_vendita_auto_bc_quadr,'Alpha',0.05)  % Rigetto al 5%, non rigetto al 1%




%4. scatter plot pre regressione
% VENDITA AUTO vs Consumo energia non rinnovabile
scatter(T11.vendita_auto,T11.Consum_petrolio_Trasp)    %correlazione tra i due non è altissima ma positiva
h1 = lsline
h1.Color = 'r';
h1.LineWidth = 2;

% VENDITA AUTO vs Consumo energia rinnovabile
scatter(T11.vendita_auto,T11.Consum_RinnoTOT)
lsline

% Grafici multipli affiancati  --> ho raggruppato tutto nello stesso plot
f5 = figure
subplot(1,2,1)
set(f5,'position',[100,100,1250,675]);
scatter(T11.vendita_auto,T11.Consum_NRinnTOT)
h1 = lsline
h1.Color = 'r';
h1.LineWidth = 2;
title('VENDITA AUTO vs Consumo energia non rinnovabile')
xlabel('Numero auto (Mln)') 
ylabel('Energia Non Rinnovabili [quadrilioni di BTU]')
subplot(1,2,2)
scatter(T11.vendita_auto,T11.Consum_RinnoTOT)
h2 = lsline
h2.Color = 'b';
h2.LineWidth = 2;
title('VENDITA AUTO vs Consumo energia rinnovabile') 
xlabel('Numero auto (Mln)')
ylabel('Energia Rinnovabili [quadrilioni di BTU]')
saveas(f5,[pwd '\immagini\05.ScatterPlotVenditeAuto_Energie.png'])

%5. correlazione lineare
tt = corr(T11{:,{'vendita_auto','Consum_NRinnTOT','Consum_RinnoTOT'}})  % deve essere una matrice dopo input quindi graffe
rowNames = {'Vendita_auto','Consum_NRinnTOT','Consum_RinnoTOT'};
colNames = {'Vendita_auto','Consum_NRinnTOT','Consum_RinnoTOT'};
sTable = array2table(tt,'RowNames',rowNames,'VariableNames',colNames)     %lo trasformo in una table per farlo diventare più bello

%Grafico aggregato
f6 = figure
set(f6,'position',[100,100,1250,675]);
varNames = {'PEoli','PCarb','HDD','CRinn','CNRin','carbo','EmC02'};
[R,PValue,H] = corrplot(T11{:,{'Produz_Eolica','Produz_Carbone','HDD','Consum_RinnoTOT','Consum_NRinnTOT','Emiss_C02_Carbo','Emiss_C02_NTotE'}},'varNames',varNames)
saveas(f6,[pwd '\immagini\06.MatriceCorrelazioneVenditeAuto_Energie.png'])

%6. modello di regressione su variabili fortemente correlate
%%% REGRESSIONE LINEARE SEMPLICE
%Regressione lineare semplice: y_t = beta0 + beta1*x_t + epsilon_t
mhat = fitlm(T11,'ResponseVar','Emiss_C02_NTotE','PredictorVars','Emiss_C02_Carbo')    %%% MODIFICARE PREDICTOR IN VENDITA_AUTO
%%% Coefficienti stimati
mhat.Coefficients
% Intercetta significativa ad ogni livello di significatività (pv < 0.01)
    % Ad una temperatura di 0° è associata una concentrazione di 47.405 mg/m3 
    % di NO2 
% Temperatura significativa ad ogni livello di significatività (pv < 0.01)
    % Ad un incremento di 1° di temperatura è associata una riduzione di -1.38
    % mg/m3 nelle concentrazioni di NO2
%%% Significatività complessiva del modello
anova(mhat,'summary')

%PLOT PER VERIFICARE CONFRONTO DATI VERI E STIMATI
f7 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese, T11.Emiss_C02_NTotE)
hold on
plot(T11.Rif_Mese, mhat.Fitted)
hold off
title('VENDITA AUTO reale vs stimata (fitting lineare una variabile)') 
xlabel('Anni')
ylabel('Mln automobili')
legend('Emissioni di CO2 dataset','Emissioni di C02 stimati')
saveas(f7,[pwd '\immagini\07.VenditeAuto_realeVSstimata_Regr_Sempl.png'])

% 'Test for zero slopes' = F-test sui coefficienti
% PV < 0.01 --> Modello significativo nel complesso per ogni alpha
%%% Adattamento del modello
mhat.Rsquared
% Il modello è in grado di spiegare l'84% della variabilità complessiva di Y
%%% Valori previsti/fittati/stimati: yhat_t
fit1 = mhat.Fitted;              %--------------> VALORI PREVISTI DAL MODELLO (quindi la retta)
%%% Residui di regressione: y_t - yhat_t
res1 = mhat.Residuals.Raw;

%%%ANALISI dei residui (ossia la stima degli epsilon nel modello di
%%%regressione)
% Diagnostiche sui residui: normalità
f8 = figure()
set(f8,'position',[100,100,1250,675]);
subplot(1,2,1)
histfit(res1)
title('Distribuzione dei residui di regressione')
xlabel('\mug/m^{3}') 
ylabel('Conteggio')
%%%% prima cosa che devo verificare è che i residui siano normali
%%%% (istogramma con campana e valore centrale =0)

% Diagnostiche sui residui: incorrelazione tra fittati e residui
% IMPORTANTE che non siano correlati i fittati e residui
subplot(1,2,2)
scatter(fit1,res1)         %%%%%%%%%%% INTERPRETARE IL RISULTATO
h1 = lsline
h1.Color = 'black';
h1.LineWidth = 2;
xlabel('Valori fittati'); 
ylabel('Residui di regressione');
text(30,0.5,sprintf('rho = %0.3f',round(corr(res1,fit1),3)))
saveas(f8,[pwd '\immagini\08.Residui_Regr_Lin_VenditeAuto.png'])

% controllo MEGLIO con test se sono normali i residui
skewness(res1)    % Asimmetria negativa
kurtosis(res1)    % distribuzione a campana
[h,p,jbstat,critval] = jbtest(res1, 0.05)   % PV=0.5 --> Non rigetto H0 --> norm
[h,p,dstat,critval] = lillietest(res1,'Alpha',0.05)  % PV=0.5 --> Non rigetto H0 --> norm

%posso voler vedere il p-value del test, la media dei residui e un
%intervallo di confidenza sui residui con T-TEST
[h3,p3,ci3,stats3] = ttest(res1)


%%% REGRESSIONE LINEARE MULTIPLA:
% Modello log-lineare: la dipendente è logaritmica, i regressori sono lineari
mhat2 = fitlm(T11,'ResponseVar','Emiss_C02_NTotE','PredictorVars',{'Emiss_C02_Carbo','HDD','Produz_Eolica','Produz_Carbone'})
%%% Coefficienti stimati
mhat2.Coefficients

%confronto reali vs fitted (2 variabili)
f9 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese, T11.Emiss_C02_NTotE)
hold on
plot(T11.Rif_Mese, mhat2.Fitted)
hold off
title('VENDITA AUTO reale vs stimata (fitting lineare due variabili)') 
xlabel('Anni')
ylabel('Mln automobili')
legend('Emissioni di CO2 dataset','Emissioni di C02 stimati')
saveas(f9,[pwd '\immagini\09.VenditeAuto_realeVSstimata_Regr_Multipla.png'])

anova(mhat2,'summary')
% 'Test for zero slopes' = F-test sui coefficienti
% PV < 0.01 --> Modello significativo nel complesso per ogni alpha
%%% Adattamento del modello
mhat2.Rsquared
% Il modello è in grado di spiegare l'84% della variabilità complessiva di Y
%%% Valori previsti/fittati/stimati: yhat_t
fit2 = mhat2.Fitted;              %--------------> VALORI PREVISTI DAL MODELLO (quindi la retta)
%%% Residui di regressione: y_t - yhat_t
res2 = mhat2.Residuals.Raw;

%%%ANALISI dei residui (ossia la stima degli epsilon nel modello di
%%%regressione)
% Diagnostiche sui residui: normalità
f10 = figure()
set(f10,'position',[100,100,1250,675]);
subplot(1,2,1)
histfit(res2)
title('Distribuzione dei residui di regressione')
xlabel('\mug/m^{3}') 
ylabel('Conteggio')
%%%% prima cosa che devo verificare è che i residui siano normali
%%%% (istogramma con campana e valore centrale =0)

% Diagnostiche sui residui: incorrelazione tra fittati e residui
% IMPORTANTE che non siano correlati i fittati e residui
subplot(1,2,2)
scatter(fit2,res2)         %%%%%%%%%%% INTERPRETARE IL RISULTATO
h1 = lsline
h1.Color = 'black';
h1.LineWidth = 2;
xlabel('Valori fittati'); 
ylabel('Residui di regressione');
%text(30,0.5,sprintf('rho = %0.3f',round(corr(res2,fit2),3))) %CAPIRE SIGN.
saveas(f10,[pwd '\immagini\10.Residui_Regr_Mul_VenditeAuto.png'])

% controllo MEGLIO con test se sono normali i residui
skewness(res2)    % Asimmetria negativa
kurtosis(res2)    % distribuzione a campana
[h,p,jbstat,critval] = jbtest(res2, 0.05)   % PV=0.5 --> Non rigetto H0 --> norm
[h,p,dstat,critval] = lillietest(res2,'Alpha',0.05)  % PV=0.5 --> Non rigetto H0 --> norm

%posso voler vedere il p-value del test, la media dei residui e un
%intervallo di confidenza sui residui con T-TEST
[h3,p3,ci3,stats3] = ttest(res2)


%%%%%%%%% MODIFICARE DA QUESTO PUNTO.

%7. model selection
%%% Model selection: STEPWISE regression  (in questo caso da modello vuoto a pieno)
% 1. Elenco tutte le variabili di regressione di interesse
xvars = [{'Temperatura'},{'Umidita'},{'CO'},{'BC'},{'O3'},{'PM10'}];
% 2. Seleziono le colonne corrispondenti
Tm_sel = Tm(:,[xvars, {'log_NO2'}]);
% 3. Stimo modello con tutti i regressori (modello full)
mhat_full = fitlm(Tm_sel,'ResponseVar','log_NO2')
% 4. Applico algoritmo stepwise (dal modello vuoto a quello pieno)
X = Tm_sel{:,xvars};
y = Tm_sel{:,'log_NO2'};
[b,se,pval,in_stepwise,stats,nextstep,history] = stepwisefit(X,y,...
    'PRemove',0.15,'PEnter',0.10);                                          %penultimo rimuovo variabile se suo p-value < 15%
% 5. Valuto modello selezionato con stepwise ->solo con le variabile 1,4,6
mhat_step = fitlm(Tm_sel(:,[in_stepwise,true]),'ResponseVar','log_NO2')
% 6. Osservo errore quadratico medio di previsione
disp('RMSE con stepwise model selection:')
disp(stats.rmse)

%teoricamente nel modello mi seleziona come variabile significativa anche
%BLACK CARBON colonna 4, ma questa a p-value 6% e fa abbastanza schifo,
%perciò dovrei andare in PRemove e mettere 0.05


%%% Model selection: LASSO algorithm

% Lasso mediante la cross-validazione fa un ragionamento previsivo. Trovo
% quei valori penalizzati tale che la previsione è la migliore con un
% modello lineare.
% 1. Elenco tutte le variabili di regressione di interesse
xvars = [{'Temperatura'},{'Umidita'},{'CO'},{'BC'},{'O3'},{'PM10'}];
% 2. Seleziono le colonne corrispondenti
Tm_sel = Tm(:,[xvars, {'log_NO2'}]);
% 3. Stimo modello con tutti i regressori (modello full)
mhat_full = fitlm(Tm_sel,'ResponseVar','log_NO2')
% 4. Applico algoritmo LASSO con cross-validation dei parametri 20-folds
X = Tm_sel{:,xvars};
y = Tm_sel{:,'log_NO2'};
%BHAT testa 100 lambda differenti e rispetto al numero di previsori che
%sono andato a dargli. Risultato output bhat matrice 6*100
[Bhat,lasso_st]=lasso(X,y,'CV',20,'MCReps',5,...
                'Options',statset('UseParallel',true),...
                'PredictorNames',xvars);
% 5. Identifico le varaibili selezionate con LASSO
lasso_st.IndexMinMSE                                %--> migliore modello con bhat, è il 36 lambda che manda a 0 solo la 3° variabile e le altre le tiene
%sto selezionando le variabili che vanno bene ottenute con lasso e 
in_lasso = not(Bhat(:,lasso_st.IndexMinMSE)==0);
% 6. Valuto modello selezionato
mhat_lasso = fitlm(Tm_sel(:,[in_lasso(:)',true]),'ResponseVar','log_NO2')
% 7 Osservo errore di previsione associato al modello selezionato
disp('RMSE con 20-folds cross-validation:')
disp(sqrt(lasso_st.MSE(lasso_st.IndexMinMSE)))


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

