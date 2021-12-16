%% IMPORTO DATASET
T = readtable('DATA SET UFFICIALE.xlsx');
T2 = readtable('DATA SET UFFICIALE.xlsx','Sheet','YEAR');

%% RINOMINARE COLONNE
% T.Month = datetime(T.Month,"Format","dd-MM-uuuu"); in realtà non serve 
T.Properties.VariableNames = {'Rif_Mese','Emiss_C02_Carbo','Emiss_C02_GasNa','Emiss_C02_BenAe','Emiss_C02_CoODi','Emiss_C02_LiqId','Emiss_C02_CarJe','Emiss_C02_Keros','Emiss_C02_Lubri','Emiss_C02_BenMo','Emiss_C02_CokPe','Emiss_C02_CoORe','Emiss_C02_AltrP','Emiss_C02_Petro','Emiss_C02_NTotE','Produz_Carbone','Produz_GasNatur','Produz_PetrGreg','Produz_CFosTOT','Produz_Idroelet','Produz_Eolica','Produz_Biomasse','Produz_RinnoTOT','Produz_EnePrTOT','Consum_RinnoTOT','Consum_NRinnTOT','Consum_EnePrTOT','Import_EnePrTOT','Import_PetrOPEC','Consum_CFosTras','CDD','HDD','vendita_auto'}

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
saveas(f1,[pwd '\immagini\1.ConfrontoEmissioniCO2.png'])

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
saveas(f2,[pwd '\immagini\2.ConfrontoProduzioneNonRinnovabili.png'])

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
saveas(f3,[pwd '\immagini\3.ConfrontoProduzioneRinnovabili.png'])

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
histogram(T11.Emiss_C02_Carbo, 20,'Normalization','probability')   %CAMBIARE COLONNA CON VENDITA AUTO.
title('Distribuzione della vendita auto')
xlabel('Mln') 
ylabel('%')
%gli inquinanti hanno normalmente una coda dx molto lunga (tipo
%chi-quadrato)
%2. test di normalità
%Indicatori di normalità: curtosi e skewness
skewness(T11.Emiss_C02_Carbo)    % Asimmetria positiva
kurtosis(T11.Emiss_C02_Carbo)    % Platicurticità
%3. trasformazioni normalizzanti
[h,p,jbstat,critval] = jbtest(T11.Emiss_C02_Carbo, 0.05)   % Test al 5% --> Rigetto H0 --> non norm       ---> SICCOME TROVO 4% di p-value e la soglia è 5% rigehtto HO
[h1,p1,jbstat1,critval1] = jbtest(T11.Emiss_C02_Carbo, 0.01)   % Test al 1% --> Non rigetto H0 --> norm   --> IN QUESTO CASO LA soglia è 1% non posso rigettare
[h2,p2,jbstat2,critval2] = jbtest(T11.Emiss_C02_Carbo, 0.10)   % Test al 1% --> Non rigetto H0 --> norm   --> IN QUESTO CASO LA soglia è 1% non posso rigettare
%Lilliefors 
[h3,p3,dstat3,critval3] = lillietest(T11.Emiss_C02_Carbo,'Alpha',0.05)   %--> con lilliefors trovo che i dati non sono normali
% PV < 0.01 --> Rigetto H0 sia al 1% che al 5%



%(BoxCox trasf normalizzante se prima esce H1)
[transdat,lambda] = boxcox(T11.Emiss_C02_Carbo)
T11_Emiss_C02_Carbo_bc = boxcox(lambda,T11.Emiss_C02_Carbo);   %ho applicato lambda alla Tm.NO2
histogram(log(T11_Emiss_C02_Carbo_bc),20)         %applico logaritmo

% lambda molto vicino a 0 --> trasformazione ottima è logaritmo
T11_log_Emiss_C02_Carbo = log(T11.Emiss_C02_Carbo);
histogram(T11_log_Emiss_C02_Carbo,20)
[h,p,jbstat,critval] = jbtest(T11_log_Emiss_C02_Carbo,0.05)   % Test al 5% --> Non rigetto H0 --> norm
[h,p,jbstat,critval] = jbtest(T11_log_Emiss_C02_Carbo,0.01)   % Test al 1% --> Non rigetto H0 --> norm
[h,p,dstat,critval] = lillietest(T11_log_Emiss_C02_Carbo,'Alpha',0.05)  % Rigetto al 5%, non rigetto al 1%




%4. scatter plot pre regressione
% VENDITA AUTO vs Consumo energia non rinnovabile
scatter(T11.Emiss_C02_NTotE,T11.Consum_NRinnTOT)    %correlazione tra i due non è altissima ma positiva
h1 = lsline
h1.Color = 'r';
h1.LineWidth = 2;

% VENDITA AUTO vs Consumo energia rinnovabile
scatter(T11.Emiss_C02_Carbo,T11.Consum_RinnoTOT)
lsline

% Grafici multipli affiancati  --> ho raggruppato tutto nello stesso plot
subplot(1,2,1)
scatter(T11.Emiss_C02_NTotE,T11.Consum_NRinnTOT)
h1 = lsline
h1.Color = 'r';
h1.LineWidth = 2;
title('VENDITA AUTO vs Consumo energia non rinnovabile')
xlabel('Numero auto (Mln)') 
ylabel('Energia Non Rinnovabili [quadrilioni di BTU]')
subplot(1,2,2)
scatter(T11.Emiss_C02_NTotE,T11.Consum_RinnoTOT)
h2 = lsline
h2.Color = 'b';
h2.LineWidth = 2;
title('VENDITA AUTO vs Consumo energia rinnovabile') 
xlabel('Numero auto (Mln)')
ylabel('Energia Rinnovabili [quadrilioni di BTU]')

%5. correlazione lineare
tt = corr(T11{:,{'Emiss_C02_NTotE','Consum_NRinnTOT','Consum_RinnoTOT'}})  % deve essere una matrice dopo input quindi graffe
rowNames = {'Emiss_C02_NTotE','Consum_NRinnTOT','Consum_RinnoTOT'};
colNames = {'Emiss_C02_NTotE','Consum_NRinnTOT','Consum_RinnoTOT'};
sTable = array2table(tt,'RowNames',rowNames,'VariableNames',colNames)     %lo trasformo in una table per farlo diventare più bello

%Grafico aggregato
varNames = {'EmC02NTotE','Consum_NRinnTOT','Consum_RinnoTOT'};
[R,PValue,H] = corrplot(T11{:,{'Emiss_C02_NTotE','Consum_NRinnTOT','Consum_RinnoTOT'}},'varNames',varNames)


%6. modello di regressione su variabili fortemente correlate
%%% REGRESSIONE LINEARE SEMPLICE
%Regressione lineare semplice: y_t = beta0 + beta1*x_t + epsilon_t
mhat = fitlm(T11,'ResponseVar','Emiss_C02_NTotE','PredictorVars','Consum_NRinnTOT')    %%% MODIFICARE PREDICTOR IN VENDITA_AUTO
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
mhat2 = fitlm(T11,'ResponseVar','Emiss_C02_NTotE','PredictorVars',{'Consum_NRinnTOT','Consum_RinnoTOT'})
%%% Coefficienti stimati
mhat2.Coefficients
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

% controllo MEGLIO con test se sono normali i residui
skewness(res2)    % Asimmetria negativa
kurtosis(res2)    % distribuzione a campana
[h,p,jbstat,critval] = jbtest(res2, 0.05)   % PV=0.5 --> Non rigetto H0 --> norm
[h,p,dstat,critval] = lillietest(res2,'Alpha',0.05)  % PV=0.5 --> Non rigetto H0 --> norm

%posso voler vedere il p-value del test, la media dei residui e un
%intervallo di confidenza sui residui con T-TEST
[h3,p3,ci3,stats3] = ttest(res2)


%7. model selection
