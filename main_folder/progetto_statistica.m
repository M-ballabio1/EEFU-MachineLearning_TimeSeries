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
T.Properties.VariableNames = {'Rif_Mese','Emiss_C02_Carbo','Emiss_C02_GasNa','Emiss_C02_BenAe','Emiss_C02_CoODi','Emiss_C02_LiqId','Emiss_C02_CarJe','Emiss_C02_Keros','Emiss_C02_Lubri','Emiss_C02_BenMo','Emiss_C02_CokPe','Emiss_C02_CoORe','Emiss_C02_AltrP','Emiss_C02_Petro','Emiss_C02_NTotE','Produz_Carbone','Produz_GasNatur','Produz_PetrGreg','Produz_CFosTOT','Produz_Idroelet','Produz_Eolica','Produz_Biomasse','Produz_RinnoTOT','Produz_EnePrTOT','Consum_RinnoTOT','Consum_NRinnTOT','Consum_EnePrTOT','Import_EnePrTOT','Import_PetrOPEC','Consum_CFosTras','CDD','HDD','vendita_auto','Consum_petrolio_Trasp','Consum_Carb_Elettr','Consum_Carb_TOT'};

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
varNames = {'PEoli','PCarb','CRinn','CNRin','CFosTr','CCarE','CCarT','EmC02'};
[R,PValue,H] = corrplot(T11{:,{'Produz_Eolica','Produz_Carbone','Consum_RinnoTOT','Consum_NRinnTOT','Consum_CFosTras','Consum_Carb_Elettr','Consum_Carb_TOT','Emiss_C02_NTotE'}},'varNames',varNames)
saveas(f6,[pwd '\immagini\06.ScatterPlot_Produzioni_Consumi.png'])


%6. modello di regressione su variabili fortemente correlate
%%% REGRESSIONE LINEARE SEMPLICE
%Regressione lineare semplice: y_t = beta0 + beta1*x_t + epsilon_t
mhat = fitlm(T11,'ResponseVar','Emiss_C02_NTotE','PredictorVars','Consum_Carb_TOT')   
%%% Coefficienti stimati
mhat.Coefficients
% Intercetta significativa ad ogni livello di significatività (pv < 0.01).
% Consumo Carbone tot significativo ad ogni livello di
% significatività (pv < 0.01).
% R-squared: 0.537, modello non molto significativo utilizzando però solo
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
%I test ci permettono di affermare che la distribuzione è normale (2/4) 


%%% REGRESSIONE LINEARE MULTIPLA (prod e cons. singoli):
% Modello log-lineare: la dipendente è logaritmica, i regressori sono lineari
mhat2 = fitlm(T11,'ResponseVar','Emiss_C02_NTotE','PredictorVars',{'Produz_Eolica','Produz_Carbone','Consum_CFosTras','Produz_Biomasse','Consum_Carb_TOT'})
%%% Coefficienti stimati
mhat2.Coefficients
% Intercetta significativa (pv < 0.01)
% Altre variabili significative (pv < 0.01) --> Consum. Carb tot la più
% significativa
% R-squared: 0.731, migliore significatività del modello.

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
[h,p,jbstat,critval] = jbtest(res2, 0.05);                              % pv = 0.267 --> normalità
[h,p,jbstat,critval] = jbtest(res2, 0.01);                              % pv = 0.267 --> normalità
[h,p,dstat,critval] = lillietest(res2,'Alpha',0.05);                    % pv = 0.224 --> normalità
[h3,p3,ci3,stats3] = ttest(res2);                                       % perfettamente normale
%I test ci permettono di affermare che la distribuzione è normale (4/4) 


%%% REGRESSIONE LINEARE MULTIPLA (prod e cons. aggregati):
% Modello log-lineare: la dipendente è logaritmica, i regressori sono lineari
mhat2 = fitlm(T11,'ResponseVar','Emiss_C02_NTotE','PredictorVars',{'Produz_RinnoTOT','Consum_NRinnTOT','Consum_RinnoTOT'})
%%% Coefficienti stimati
mhat2.Coefficients
% Intercetta significativa (pv < 0.01)
% Altre variabili significative (pv < 0.01) --> Consum. NON rinnovab. tot la più
% significativa
% R-squared: 0.961, migliore significatività del modello.

%confronto reali vs fitted (+ variabili)
f9a = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese, T11.Emiss_C02_NTotE)
hold on
plot(T11.Rif_Mese, mhat2.Fitted)
hold off
title('Emssione C0_2 reali vs stimate (fitting lineare più variabili)') 
xlabel('Tempo [Mesi]')
ylabel('Quantità emessa [Mln di tonnellate]')
legend('Emissioni di CO2 dataset','Emissioni di C02 stimate')
saveas(f9a,[pwd '\immagini\09a.Emissioni_realiVSstimate_Regr_Multipla_aggrega.png'])


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
f10a = figure()
set(f10a,'position',[100,100,1250,675]);
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
saveas(f10a,[pwd '\immagini\10a.Residui_Regr_Mul_EmissioneC02.png'])

% Indici normalità residui
skewness(res2)    
kurtosis(res2)                                                         %abbastanza vicini alla normalità
% Test normalità residui
[h,p,jbstat,critval] = jbtest(res2, 0.05);                              % pv = 0.267 --> normalità
[h,p,jbstat,critval] = jbtest(res2, 0.01);                              % pv = 0.267 --> normalità
[h,p,dstat,critval] = lillietest(res2,'Alpha',0.05);                    % pv = 0.224 --> normalità
[h3,p3,ci3,stats3] = ttest(res2);                                       % perfettamente normale
%I test ci permettono di affermare che la distribuzione è normale (4/4) 


%%% Model selection: STEPWISE regression  (in questo caso da modello vuoto
%%% a pieno) [SOLO su singoli produzione e consumo].
% 1. Seleziono le colonne corrispondenti PRODUZIONE e CONSUMI
xvars = [{'Produz_Carbone'},{'Produz_GasNatur'},{'Produz_PetrGreg'},{'Produz_CFosTOT'},{'Produz_Idroelet'},{'Produz_Eolica'},{'Produz_Biomasse'},{'Consum_CFosTras'},{'Consum_petrolio_Trasp'},{'Consum_Carb_Elettr'},{'Consum_Carb_TOT'}];
T11_sel = T11(:,[xvars,{'Emiss_C02_NTotE'}]);
% 2. Applico algoritmo stepwise (dal modello vuoto a quello pieno)
% Divisione Predittori (X) e Variabile risposta (Y)
X = T11_sel{:,xvars};
y = T11_sel{:,'Emiss_C02_NTotE'};
[b,se,pval,in_stepwise,stats,nextstep,history] = stepwisefit(X,y,...
    'PRemove',0.15,'PEnter',0.05);                                          %penultimo rimuovo variabile se suo p-value < 15%
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
saveas(f11,[pwd '\immagini\11.Emissioni_realiVSstimate_Stepwise_singoli.png'])

%COMMENTO MODELLO CON STEPWISE (R^2 = 0.785)


%%% Model selection: LASSO algorithm

% Lasso mediante la cross-validazione fa un ragionamento previsivo. Trovo
% quei valori penalizzati tale che la previsione è la migliore con un
% modello lineare.

% 1. Elenco tutte le variabili di regressione di interesse
xvars = [{'Produz_Carbone'},{'Produz_GasNatur'},{'Produz_PetrGreg'},{'Produz_CFosTOT'},{'Produz_Idroelet'},{'Produz_Eolica'},{'Produz_Biomasse'},{'Consum_CFosTras'},{'Consum_petrolio_Trasp'},{'Consum_Carb_Elettr'},{'Consum_Carb_TOT'}];
X = T11{:,xvars};
y = T11.Emiss_C02_NTotE;

%BHAT testa 100 lambda differenti e rispetto al numero di previsori che
%sono andato a dargli. Risultato output bhat matrice 14*100
[Bhat,lasso_st]=lasso(X,y,'CV',20,'MCReps',5,...   %cv 20
                'Options',statset('UseParallel',true),...
                'PredictorNames',xvars);
% 5. Identifico le variabili selezionate con LASSO
lasso_st.IndexMinMSE                                %--> migliore modello con bhat, è il 1 lambda
%sto selezionando le variabili che vanno bene ottenute con lasso e 
in_lasso = not(Bhat(:,lasso_st.IndexMinMSE)==0);

% 6. Valuto modello selezionato
mhat_lasso = fitlm(T11_sel(:,[in_lasso(:)',true]),'ResponseVar','Emiss_C02_NTotE')
% 7 Vedo qual è il lambda che minimizza il MSE o SE
lassoPlot(Bhat,lasso_st,'PlotType','CV');
legend('show') % Show legend
% 8 Osservo errore di previsione associato al modello selezionato
disp('RMSE con 20-folds cross-validation:')
disp(sqrt(lasso_st.MSE(lasso_st.IndexMinMSE)))

f12 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese, T11.Emiss_C02_NTotE,'Color',[0.4660, 0.7540, 0.1880],'LineWidth', 1)
hold on
plot(T11.Rif_Mese, mhat_lasso.Fitted,'r','LineWidth', 1)
title('Emssione C0_2 reali vs stimate (Lasso)') 
xlabel('Tempo [Mesi]')
ylabel('Quantità emessa [Mln di tonnellate]')
legend('Emissioni di C02 test data','Emissioni di C02 fittati con Lasso')
saveas(f12,[pwd '\immagini\12.Emissioni_realiVSstimate_Lasso.png'])

%R^2 = 0.794

%%% Possibile analisi training e test applicata anche alla staepwise per
%%% fare un possibile confronto da inserire nel report

%% Rappresentazione grafica della serie storica
f12 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese,T11.Emiss_C02_NTotE)
title('Andamento delle emissioni di C0_2 da gennaio 2010 a luglio 2021')
xlabel('Tempo [Mesi]') 
ylabel('Quantità emessa [Mln di tonnellate]')

% AUTOREGRESSIVI: Caratteristiche grafiche della serie: autocorrelazioni e distribuzione
f13 = figure('Position',[100,100,1250,675])
% Serie storica
subplot(2,2,1)      
plot(T11.Rif_Mese,T11.Emiss_C02_NTotE);
title('Serie storica delle emissioni di C0_2')
% Istogramma della distribuzione
subplot(2,2,2)       
histfit(T11.Emiss_C02_NTotE,20,'Normal')
title('Istogramma della distribuzione')
% Autocorrelazioni
subplot(2,2,3)       
autocorr(T11.Emiss_C02_NTotE, 48);
title('ACF delle innovazioni')
% Autocorrelazioni parziali
subplot(2,2,4)       
parcorr(T11.Emiss_C02_NTotE, 48);
title('PACF delle innovazioni')
saveas(f13,[pwd '\immagini\13.ACF_PACF_Emissioni.png'])
% in questo caso acf si nota che è stagionale ritardo 12.
% PACF --> si nota una stagionalità ogni 12 mesi, ma varia la
% significatività varia annualmente.

% Test di Bera-Jarque di normalità - H0 = dati normali
[h,p,jbstat,critval] = jbtest(T11.Emiss_C02_NTotE)                      % normalità dei dati

% Ljung-Box test per autocorrelazione
[h,pValue,stat,cValue] = lbqtest(T11.Emiss_C02_NTotE,'lags',[6,12,18,24,30,36,42,48])   %autocorrelazione forte ai seguenti ritardi

%%Durbin-Watson test per autocorrelazione
%questo test si chiede se c'è autocorrelazione a ritardo 1.
[pValue,stat] = dwtest(T11.Emiss_C02_NTotE,ones(size(T11.Emiss_C02_NTotE,1)-1,1),'Method','exact')     %è autocorrelato ritardo 1
% pv = 0 --> Rigetto ipotesi nulla --> Valori autoregressivi

% Augmented-Dickey-Fuller test per stazionarietà
% H0 = la serie è non stazionaria
% H1 = la serie è stazionaria
[h,p,adfstat,critval] = adftest(T11.Emiss_C02_NTotE,'model','TS','lags',0:24)


%%%%% Modelli ARIMA
%%% Modello la serie storica con modelli ARIMA(p,0,q) e SARIMA((p,0,q),(P,0,Q))
% ARIMA(p,0,q): y_t = alpha1*y_t-1 + ... + alphap*y_t-p + esp_t + ...
%                           theta_1*eps_t-1 + theta_q*eps_t-q
% Modello AR(12): y_t = alpha1*y_t-1 + alpha2*y_t-2 + ... + alpha12*y_t-12 + eps_t


% Divisione dataset in training e test 
X = T11_sel(:,xvars);
X_train = X([1:115],:);
X_train_m = table2array(X_train);
X_test = X([116:end],:);
X_test_m = table2array(X_test);

y = T11_sel(:,'Emiss_C02_NTotE');
y_train = y([1:115],:);
y_train_m = table2array(y_train);
y_test = y([116:end],:);
y_test_m = table2array(y_test);

X2 = T11_sel([116:end],:);
periodo = T11.Rif_Mese;
Period_test = periodo([116:end],:);
Period_train = periodo([1:115],:);

% Utilizzo di training e test per previsione
AR12 = arima('ARLags',1:12)
EstAR12 = estimate(AR12,y_train_m,'Display','off') 
summarize(EstAR12)                                                   %mostra risultati modello
%Trovo i residui (detti anche innovazioni) dell'Arima.
innov_tr = infer(EstAR12, y_train_m, 'Y0',y_train_m(1:12));
innov_te = infer(EstAR12, y_test_m, 'Y0',y_test_m(1:12));
%fitted = y_train_m + innov_tr;
new = forecast(EstAR12,24,y_test_m);
fit_right = new+innov_te;

%%% Grafico della serie osservata e stimata/fittata
f14 = figure('Position',[100,100,1250,675])
plot(Period_train,y_train_m)
hold on
plot(Period_test,y_test_m)
plot(Period_test,fit_right)
legend('Osservata training dataset','Osservata test dataset','Fittata AR(12)')
xlabel('Tempo [Mesi]') 
ylabel('Quantità emessa [Mln di tonnellate]')
title('Serie storica osservata e fittata con AR(12)')
saveas(f14,[pwd '\immagini\14.Fitting_AR12.png'])
%%% SOVRASTIMA quasi sempre i picchi sia in positivo che negativo.
RMSE = sqrt(mean((y_test_m - fit_right).^2))  % Root Mean Squared Error = 33.31


%%%%% Modelli ARIMA
% Modello ARIMA((2,0,2)
% y_t = alpha1*y_t-1 + Alpha12*y_t-12 + eps_t

MA11 = arima(2,0,2);                                                             % AUTOREGRESSIVO DI GRADO 2, A MEDIA MOBILE DI 2
MAS11 = estimate(MA11,y_train_m,'Display','off');
summarize(MAS11);
innovMA112 = infer(MAS11, y_train_m, 'Y0',y_train_m(1:4));  
%fittedMA112 = T11.Emiss_C02_NTotE + innovMA112;
innov_te2 = infer(MAS11, y_test_m, 'Y0',y_test_m(1:4));
%fitted = y_train_m + innov_tr;
new_2 = forecast(MAS11,24,y_test_m);
fit_right2 = new_2+innov_te2;

f15 = figure('Position',[100,100,1250,675])
plot(Period_train,y_train_m)
hold on
plot(Period_test,y_test_m)
plot(Period_test,fit_right2)
xlabel('Tempo [Mesi]') 
ylabel('Quantità emessa [Mln di tonnellate]')
legend('Osservata train','Osservata test','Fittata con ARIMA')
title('Serie storica osservata e fittata con ARIMA(2,0,2)')
saveas(f15,[pwd '\immagini\15.Fitting_ARIMA.png'])

RMSE = sqrt(mean((y_test_m - fit_right2).^2))  % Root Mean Squared Error = 24.13


%%%% Metodo iterativo scelta parametri per minimizzare l'AIC e il BIC

pMax = 3;
qMax = 3;
AIC = zeros(pMax+1,qMax+1);
BIC = zeros(pMax+1,qMax+1);

for p = 0:pMax
    for q = 0:qMax
        % White noise: ARMA(0,0)
        if p == 0 & q == 0
            Mdl = arima(0,0,0);
        end
        % Moving average: ARMA(0,q)
        if p == 0 & q ~= 0
            Mdl = arima('MALags',1:q,'SARLags',12);
        end
        % Autoregressive: ARMA(p,0)
        if p ~= 0 & q == 0
            Mdl = arima('ARLags',1:p,'SARLags',12);
        end
        % Autoregressive moving average: ARMA(p,q)
        if p ~= 0 & q ~= 0
            Mdl = arima('ARLags',1:p,'MALags',1:q,'SARLags',12);
        end      
        % Stima del modello con MLE
        EstMdl = estimate(Mdl,T11.Emiss_C02_NTotE,'Display','off');
        % Salvataggio AIC e BIC
        results = summarize(EstMdl);
        AIC(p+1,q+1) = results.AIC;         % p = rows
        BIC(p+1,q+1) = results.BIC;         % q = columns
    end
end

% Confrontiamo AIC e BIC dei valori modelli stimati
minAIC = min(min(AIC))                          % minimo per riga e poi minimo per colonna della matrice AIC
[bestP_AIC,bestQ_AIC] = find(AIC == minAIC)     % posizione del modello con minimo AIC
bestP_AIC = bestP_AIC - 1; bestQ_AIC = bestQ_AIC - 1; 
minBIC = min(min(BIC))
[bestP_BIC,bestQ_BIC] = find(BIC == minBIC)
bestP_BIC = bestP_BIC - 1; bestQ_BIC = bestQ_BIC - 1; 
fprintf('%s%d%s%d%s','The model with minimum AIC is SARIMA((', bestP_AIC,',0,',bestQ_AIC,'),(12,0,0))');
fprintf('%s%d%s%d%s','The model with minimum BIC is SARIMA((', bestP_BIC,',0,',bestQ_BIC,'),(12,0,0))');
% Scegliamo il modello più parsimonioso: SARIMA((1,0,),(12,0,0))
% Parsimonioso inteso come minor numero di parametri (Rasoio di Occam)
% In generale BIC penalizza di più la verosimiglianza quindi è più 
% parsimonioso (modello più semplice con minor numero di parametri).
SARIMA_opt = arima('ARLags',1,'SARLags',12);
Est_SARIMA_opt = estimate(SARIMA_opt,T11.Emiss_C02_NTotE);
E = infer(Est_SARIMA_opt, T11.Emiss_C02_NTotE, 'Y0',T11.Emiss_C02_NTotE(1:14));
fittedSARIMA_opt = T11.Emiss_C02_NTotE + E;

fitted_test_SAR = fittedSARIMA_opt([116:end],:);

% Analisi grafica delle autocorrelazioni dei FITTATI (RIGURDARE)
RMSE = sqrt(mean((y_test_m - fitted_test_SAR).^2))  % Root Mean Squared Error = 21.08

%%% Grafico della serie osservata e stimata/fittata
f16 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese,T11.Emiss_C02_NTotE)
hold on
plot(Period_test,fitted_test_SAR)
plot(Period_test,fit_right2)
plot(Period_test,fit_right)
xlabel('Tempo [Mesi]') 
ylabel('Quantità emessa [Mln di tonnellate]')
legend('Osservata','SARIMA((1,0,1),(12,0,0))',...
    'ARIMA(1,0,3)','AR(12)')
title('Serie storica osservata e fittata con diversi modelli')
saveas(f16,[pwd '\immagini\16.ConfrontoModelli.png'])

%solo su test
f16a = figure('Position',[100,100,1250,675])
plot(Period_test,y_test_m,'LineWidth', 2)
hold on
plot(Period_test,fitted_test_SAR)
plot(Period_test,fit_right2)
plot(Period_test,fit_right)
xlabel('Tempo [Mesi]') 
ylabel('Quantità emessa [Mln di tonnellate]')
legend('Osservata','SARIMA((1,0,1),(12,0,0))',...
    'ARIMA(1,0,3)','AR(12)')
title('Serie storica osservata e fittata con diversi modelli')
saveas(f16a,[pwd '\immagini\16a.ConfrontoModelli_test.png'])

%%% Analisi grafica delle innovazioni
f17 = figure('Position',[100,100,1250,675])
subplot(2,2,1)      
plot(E);
title('Serie storica delle innovazioni')
subplot(2,2,2)       
histfit(E,20,'Normal')
title('Istogramma delle innovazioni')
subplot(2,2,3)       
autocorr(E);
title('ACF delle innovazioni')
subplot(2,2,4)       
parcorr(E);
title('PACF delle innovazioni')
saveas(f17,[pwd '\immagini\17.ACF_PACF_Sarima.png'])

% Test analitici sui residui
[h,p,jbstat,critval] = jbtest(E)
[h,pValue,stat,cValue] = lbqtest(E,'lags',[1,4,8,12])
[h,p,adfstat,critval] = adftest(E)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Autocorrelazione totale e parziale dei residui e dei residui al quadrato
% Residui E
% Residui al quadrato
E2 = E.^2;

figure(1)
subplot(2,2,1)
autocorr(E,48)
title('ACF residui filtro')
subplot(2,2,2)
parcorr(E,48)
title('PACF residui filtro')
subplot(2,2,3)
autocorr(E2,48)
title('ACF residui filtro^2')
subplot(2,2,4)
parcorr(E2,48)
title('PACF residui filtro^2')
% Residui risultano autocorrelati --> Whitening
% Residui al quadrato risultano autocorrelati --> GARCH

%% Engle's ARCH test per eteroschedasticità condizionata dei residui filtro
% https://it.mathworks.com/help/econ/engles-arch-test.html

% SIAMO INTERESSATI A MODELLARE LA VARIANZA DEI RESIDUI O IN QUESTO CASO DI UNA SERIE STORICA 

%Test di engle per l'eteroschedaticità
%[h,pValue,stat,cValue] = archtest(e2_flt)
% Rigetto H0 --> se c'è presenza di eteroschedasticità nei residui del filtro

%% Pre-whitening dei residui (elimino autocorrelazione)
arma = arima(2,0,1);
aux_arma = estimate(arma,E2);
% Residui del filtro 'depurati' dalla autocorrelazione
res = infer(aux_arma, E2,'Y0',E2(1:2));
% Residui 'depurati' al quadrato
res2 = res.^2;

%% Autocorrelazione totale e parziale dei residui depurati e dei residui 
%% depurati al quadrato
figure(1)
subplot(2,2,1)
autocorr(res)
title('ACF residui')
subplot(2,2,2)
parcorr(res)
title('PACF residui')
subplot(2,2,3)
autocorr(res2)
title('ACF residui^2')
subplot(2,2,4)
parcorr(res2)
title('PACF residui^2')

% Dopo il pre-whitening, risultano autocorrelati solamente i residui al
% quadrato, quindi possiamo applicare Garch

%% %%%%% Modellazione dell'eteroschedasticità
%% ARCH(1) = GARCH(0,1)    %solo componente autoregressiva
% Stima MLE del modello
m0 = garch(0,1)
[mhat,covM,logL] = estimate(m0,res);
condVhat = infer(mhat,res);             %estraggo residui condizionati ossia e^(2).
condVol = sqrt(condVhat);               %conditional volatility
% AIC e BIC
n = length(T11.Emiss_C02_NTotE);
[a,b] = aicbic(logL,mhat.P+mhat.Q,n)
% Plot dei valori fittati
figure
plot(T11.Rif_Mese,res)
hold on;
plot(T11.Rif_Mese,condVol)
title('Residui e inferred conditional volatility con GARCH(0,1)')
xlabel('Time')
legend('Prices','Estim. cond. volatility','Location','NorthEast')
hold off;

%%% Standardized residuals
std_res = res ./ condVol;
std_res2 = std_res .^ 2;

%%% Diagnostiche sui residui standardizzati
figure
subplot(2,2,1)
plot(std_res)
title('Standardized Residuals')
subplot(2,2,2)
histogram(std_res,10)
subplot(2,2,3)
autocorr(std_res)
subplot(2,2,4)
parcorr(std_res)

figure
subplot(2,2,1)
plot(std_res2)
title('Standardized Residuals Squared')
subplot(2,2,2)
histogram(std_res2,10)
subplot(2,2,3)
autocorr(std_res2)
subplot(2,2,4)
parcorr(std_res2)
% I residui al quadrato presentano ancora autocorrelazione ma, non
% importante come nel caso precedente.


%% GARCH(1,1)      %sia autoregressivo che media mobile (1,1)
% Stima MLE del modello
m0 = garch(1,1)
[mhat,covM,logL] = estimate(m0,res);
condVhat = infer(mhat,res);
condVol = sqrt(condVhat);
% AIC e BIC
[a,b] = aicbic(logL,mhat.P+mhat.Q,n)
% Plot dei valori fittati
figure
plot(T11.Rif_Mese,res)
hold on;
plot(T11.Rif_Mese,condVol)
title('Residui e inferred conditional volatility con GARCH(0,1)')
xlabel('Time')
legend('Prices','Estim. cond. volatility','Location','NorthEast')
hold off;
% Presenza di volatility clusters (picchi ascendenti e discendenti) ben identificati
% e regolari lungo la serie

%%% Standardized residuals
std_res = res ./ condVol;
std_res2 = std_res .^ 2;

%%% Diagnostiche sui residui standardizzati
figure
subplot(2,2,1)
plot(std_res)
title('Standardized Residuals')
subplot(2,2,2)
histogram(std_res,10)
subplot(2,2,3)
autocorr(std_res)
subplot(2,2,4)
parcorr(std_res)

figure
subplot(2,2,1)
plot(std_res2)
title('Standardized Residuals squared')
subplot(2,2,2)
histogram(std_res2,10)
subplot(2,2,3)
autocorr(std_res2)
subplot(2,2,4)
parcorr(std_res2)
% I residui standardizzati al quadrato non presentano più autocorrelazione





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%% Variabili di interesse
yy = T11.Emiss_C02_NTotE;       %variabile di risposta
xx = T11.HDD;   %variabile predittiva
xx2 = xx.^2; 
XX = [xx,xx2];
nn = length(yy);

%% %%%%% Relazione tra X e Y

%lineare non funziona molto bene
plot(xx,yy,'p')
title('HDD vs Emissioni di CO_2')
xlabel('HDD [Grado giorno]')
ylabel('Quantità emessa [Mln di tonnellate]')

%potrebbe essere qualcosa di polinomiale

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%% Analisi della temperatura con approccio regressione ordinaria %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Modello 1: Regressione con coefficiente angolare e intercetta statici

% modello di regressione a coefficienti statici
% y(t) = alpha + beta*x(t) + e(t)

lm = fitlm(xx,yy);  %qui ho usato un solo regressore R^2 = 0.571
lm
lm2 = fitlm(XX,yy);  %qui due regressori R^2
lm2

%% AGGIUNTE LISA E VANE 
figure(1)
plot(T11.Rif_Mese, yy)
hold on
plot(T11.Rif_Mese, lm.Fitted)
plot(T11.Rif_Mese, lm2.Fitted)
legend('Emissioni osservate','Emissioni fittate lineari','Emissioni fittate quadratiche')
title('Emissioni stimate con regressione lineare')

figure(2)
plot(xx,yy,'p')
title('HDD vs Emissioni di CO_2')
xlabel('HDD [Grado giorno]')
ylabel('Quantità emessa [Mln di tonnellate]')
hold on
plot(xx,lm.Fitted,'r','LineWidth',2)
plot(xx,lm2.Fitted,'g','LineWidth',2)

tt = corr(T11{:,{'Emiss_C02_NTotE','HDD'}}) %corr=0.4486
rowNames = {'Emissioni CO_2 TOT','HDD'};
colNames = {'Emissioni CO_2 TOT','HDD'};
sTable = array2table(tt,'RowNames',rowNames,'VariableNames',colNames) 

tt1=corr(T11.Emiss_C02_NTotE,xx2) %corr=5951 --> correlazione più forte con HDD^2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%% Analisi della temperatura con approccio state-space %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Modello 2: Regressione con coefficiente angolare tempo-variante e intercetta statica

% modello state space a matrici tempo-varianti
% y(t) = alpha + beta(t)*x(t) + e(t)         --> c'è una costante statica e coefficiente beta che dipende dal tempo 
% beta(t) = beta(t-1) + omega(t)             --> beta evolve come rendom walk il cui errore è un processo casuale white noise 
% alpha(t) = alpha(t-1)                      --> è una costante, non c'è errore 

%%% Setting del modello
m2 = ssm(@(params)tvp_beta_alphaconstant(params,xx,lm.Coefficients.Estimate(1),lm.Coefficients.Estimate(2)));    %beta cambia nel tempo e alfa costante; in base al caso ci sono comandi diversi 
%%% Valori iniziali per algoritmo massimizzazione
% valori iniziali di log(B) e log(D)
params0 = [0.10,log(var(lm.Residuals.Raw))];

%%% Stima MLE dei parametri
disp('Stima')
mhat2 = estimate(m2,yy,params0);
%% all'ultimo istante t la costante è x(1) 416.46 e il coefficiente angolare è x(2)  -0.005

%%% Stima degli stimati
% Filtraggio (filtering) degli stati
xfilter2 = filter(mhat2,yy);
alpha2.flt = xfilter2(:,1); %estraggo separatemente in due vettori 
beta2.flt = xfilter2(:,2);
plot(alpha2.flt) 
%ma se alfa non è tempo variante non dovrebbe essere sempre quello il
%valore stimato? teoricamente si però dal grafico si vede che man mano ci
%si spostas sulla destra (sempre più info) la stima del coefficiente tende
%a stabilizzarsi e a convergere. se esso converge modello va bene. 
% lisciamento (smoothing) degli stati
plot(beta2.flt) 
%cattura tutto l'andamento della serie storica in quanto tempovariabile; 
%ovviamnte in questo caso

xsmooth2 = smooth(mhat2,yy);
alpha2.smo = xsmooth2(:,1);
beta2.smo = xsmooth2(:,2);
plot(alpha2.smo)
%filtro del filtro (dalla fine all'inizio). lo smoother è il valore ultimo
%ed è sempre costante 
plot(beta2.smo)
%serie di prima ma più liscia 


%%% Filtraggio e lisciamento dei valori di y
% valori filtrati di y
y2_flt = alpha2.flt + beta2.flt.*xx;
e2_flt = yy - y2_flt;
mean(e2_flt)
var(e2_flt)
% valori lisciati di y
y2_smo = alpha2.smo + beta2.smo.*xx;
e2_smo = yy - y2_smo;
mean(e2_smo)
var(e2_smo)

%%% Plot della serie originale, filtrata e smussata
figure(4)
plot(T11.Rif_Mese, yy)
hold on
plot(T11.Rif_Mese, y2_flt)
plot(T11.Rif_Mese, y2_smo) 
legend('Emissioni osservate','Emissioni filtrate','Emissioni smoothed')
title('Emissioni stimate con modello State Space con slope tempo-variante con intercetta costante')
% apparentemente sembrano meglio quelle filtrate rispetto a quelle
% smussate, anche se non prendono il picco del lockdown

%%% Previsione un passo in avanti degli stati e di y
% Ad ogni tempo t, il miglior previsore lineare è il valore precedente
alpha2.forecast = [nan; alpha2.flt(1:end-1)];
beta2.forecast = [nan; beta2.flt(1:end-1)];
y2_frc = alpha2.forecast + beta2.forecast.*xx; %combino le due e creo la serie forecasting une step ahed di y 
e2_frc = yy - y2_frc; %errore di previsione
nanmean(e2_frc)
nanvar(e2_frc)

%%% Plot della serie originale e previsione un-passo-in-avanti
figure(5)
plot(yy)
hold on
plot(y2_frc);
title('Previsione un passo in avanti: state-space con slope tempo-variante con intercetta costante')
legend('Valori osservati','One-step-ahead KF')

%%% Confronto il modello statico con quello dinamico
% Fitting performance
R2_stat = lm.Rsquared.Adjusted
R2_flt2 = 1 - mean(e2_flt.^2) / var(yy)
R2_smo2 = 1 - mean(e2_smo.^2) / var(yy)
R2_frc2 = 1 - nanmean(e2_frc.^2) / var(yy)

% Forecasting performance
RMSE_lm = sqrt(lm.MSE)
RMSE_frc_m2 = sqrt(mse(e2_frc))

% Plot
figure(6)
plot(T11.Rif_Mese, yy)
hold on
plot(T11.Rif_Mese, lm.Fitted)
plot(T11.Rif_Mese, y2_flt)
plot(T11.Rif_Mese, y2_smo)
legend('Emissioni osservate','Emissioni modello lineare','Emissioni filtrata','Emissioni smoothed')
title('Emissioni stimate con modello statico e modello dinamico')

%per la parte della regressione non riusciamo a fare altro :'(
% la roba del passo pensavamo che fosse una previsione, ma in realtà parte
% solo ritardata di 1

%se il modello va bene, facciamo analisi dei residui, sceglieremo poi in
%che modo

%% Correlazione su dati annuali
tt3=corr(T1.AnomalieSulRiscaldamento, T1.TotalEnergyCO2EmissionsUSA) %corr=0.74

%Regressione lineare semplice: y_t = beta0 + beta1*x_t + epsilon_t
mhat = fitlm(T1,'ResponseVar','TotalEnergyCO2EmissionsUSA','PredictorVars','AnomalieSulRiscaldamento')   
%%% Coefficienti stimati
mhat.Coefficients
% Intercetta significativa ad ogni livello di significatività (pv < 0.01).
% Anomalie sul riscaldamento significative ad ogni livello di
% significatività (pv < 0.01).
% R-squared: 0.548, modello abbastanza significativo utilizzando però solo
% una variabile.

%%% Significatività complessiva del modello
anova(mhat,'summary')

%PLOT PER VERIFICARE CONFRONTO DATI VERI E STIMATI
f70 = figure('Position',[100,100,1250,675])
plot(T2.Years,T2.TotalEnergyCO2EmissionsUSA)
hold on
plot(T2.Years, mhat.Fitted)
hold off
title('Emissioni C0_2 reali vs stimate (fitting lineare una variabile)') 
xlabel('Tempo [Anni]')
ylabel('Quantità emessa [Mln di tonnellate]')
legend('Emissioni di CO2 dataset','Emissioni di C02 stimati')
%saveas(f7,[pwd '\immagini\07.VenditeAuto_realeVSstimata_Regr_Sempl.png'])

%%% Adattamento del modello
mhat.Rsquared
% Il modello è in grado di spiegare il 55% della variabilità complessiva di Y
%%% Valori fittati dal modello: yhat_t
fit70 = mhat.Fitted             
%%% Residui di regressione: y_t - yhat_t
res70 = mhat.Residuals.Raw

%% Da fare:
%1. Aggregazione HDD annuali
%2. regressione multipla con HDD annuale e anomalie riscaldamento annuale con
%emissione annuale C02
%3. analisi dei residui




