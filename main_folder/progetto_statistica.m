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
T.Properties.VariableNames = {'Rif_Mese','Emiss_C02_Carbo','Emiss_C02_GasNa','Emiss_C02_BenAe','Emiss_C02_CoODi','Emiss_C02_LiqId','Emiss_C02_CarJe','Emiss_C02_Keros','Emiss_C02_Lubri','Emiss_C02_BenMo','Emiss_C02_CokPe','Emiss_C02_CoORe','Emiss_C02_AltrP','Emiss_C02_Petro','Emiss_C02_NTotE','Produz_Carbone','Produz_GasNatur','Produz_PetrGreg','Produz_CFosTOT','Produz_Idroelet','Produz_Eolica','Produz_Biomasse','Produz_RinnoTOT','Produz_EnePrTOT','Consum_RinnoTOT','Consum_NRinnTOT','Consum_EnePrTOT','Import_EnePrTOT','Import_PetrOPEC','Consum_CFosTras','CDD','HDD','vendita_auto','Consum_petrolio_Trasp','Consum_Carb_Elettr','Consum_Carb_TOT'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% ANALISI ESPLORATIVA %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

f2 = figure('Position',[100,100,1250,675]) 
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

f3 = figure('Position',[100,100,1250,675])  
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

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% DOMANDA 1 --> Analisi della correlazione per stimare le emissioni di C02 %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%selezione ultimi 11 anni:
T11 = T([445:end],:);

% 1. Grafici delle distribuzioni
f4 = figure('Position',[100,100,1250,675])
histfit(T11.Emiss_C02_NTotE, 20,"normal")                               
title('Distribuzione emissione C0_2 ')
xlabel('Quantità C0_2 emessa [Mln]') 
ylabel('Frequenza relativa [%]')
saveas(f4,[pwd '\immagini\04.DistribuzioneEmissioneC02.png'])

%2. Indici normalità: curtosi e skewness
kurtosis(T11.Emiss_C02_NTotE)  
skewness(T11.Emiss_C02_NTotE)    

%3. Test di normalità
%Jarque-Bera
[h,p,jbstat,critval] = jbtest(T11.Emiss_C02_NTotE, 0.05)   % Test al 5%   
[h1,p1,jbstat1,critval1] = jbtest(T11.Emiss_C02_NTotE, 0.01)   % Test al 1%  
[h2,p2,jbstat2,critval2] = jbtest(T11.Emiss_C02_NTotE, 0.10)   % Test al 10%
%I test ci permettono di affermare che la distribuzione è normale (2/3) 

%Lilliefors 
[h3,p3,dstat3,critval3] = lillietest(T11.Emiss_C02_NTotE,'Alpha',0.05)   
%Il test ci conferma l'ipotesi di normalità 

%{
(BoxCox trasf normalizzante se prima esce H1)

[transdat,lambda] = boxcox(T11.Emiss_C02_NTotE)
T11_EMISSIONI_bc = boxcox(lambda,T11.Emiss_C02_NTotE); 
histfit((T11_EMISSIONI_bc),20,'normal')        

lambda molto vicino a 0 --> trasformazione ottima è logaritmo
lambda tra 1 e 2 --> trasf. ideale è elevamento al quadrato
T11_emissioni_bc_quadr = (T11_EMISSIONI_bc).^2;
histfit(T11_emissioni_bc_quadr,20,'normal')
skewness(T11_emissioni_bc_quadr)    
kurtosis(T11_emissioni_bc_quadr)    
valuti se è cambiato qualcosa con test normalità
[h,p,jbstat,critval] = jbtest(T11_emissioni_bc_quadr,0.05)   % Test al 5% 
[h1,p1,jbstat1,critval1] = jbtest(T11_emissioni_bc_quadr,0.01)   % Test al 1% 
[h2,p2,jbstat2,critval2] = jbtest(T11_emissioni_bc_quadr, 0.10)   % Test al 10% 
[h3,p3,dstat3,critval3] = lillietest(T11_emissioni_bc_quadr,'Alpha',0.05)
%}

%4. Scatter plot pre regressione
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

%5. Correlazione lineare
tt = corr(T11{:,{'Emiss_C02_NTotE','Produz_Carbone','Produz_Eolica'}})
rowNames = {'Emissioni CO_2 TOT','Prod_Carbone','Prod_Eolica'};
colNames = {'Emissioni CO_2 TOT','Prod_Carbone','Prod_Eolica'};
sTable = array2table(tt,'RowNames',rowNames,'VariableNames',colNames); 

% Scatter per più variabili con R^2
f6 = figure
set(f6,'position',[100,100,1250,675]);
varNames = {'PEoli','PCarb','CRinn','CNRin','CFosTr','CCarE','CCarT','EmC02'};
[R,PValue,H] = corrplot(T11{:,{'Produz_Eolica','Produz_Carbone','Consum_RinnoTOT','Consum_NRinnTOT','Consum_CFosTras','Consum_Carb_Elettr','Consum_Carb_TOT','Emiss_C02_NTotE'}},'varNames',varNames)
saveas(f6,[pwd '\immagini\06.ScatterPlot_Produzioni_Consumi.png'])


%6. Regressione semplice
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

%Plot per verificare confronto tra dati veri e stimati
f7 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese, T11.Emiss_C02_NTotE)
hold on
plot(T11.Rif_Mese, mhat.Fitted)
hold off
title('Emissioni C0_2 reali vs stimate (fitting lineare una variabile)') 
xlabel('Tempo [Mesi]')
ylabel('Quantità emessa [Mln di tonnellate]')
legend('Emissioni di CO2 dataset','Emissioni di C02 stimati')
saveas(f7,[pwd '\immagini\07.Emissioni_realeVSstimata_Regr_Sempl.png'])

%%% Adattamento del modello
mhat.Rsquared
% Il modello è in grado di spiegare il 53,7% della variabilità complessiva di Y
%%% Valori fittati dal modello
fit1 = mhat.Fitted             
%%% Residui di regressione
res1 = mhat.Residuals.Raw

%%%Analisi dei residui
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
saveas(f8,[pwd '\immagini\08.Residui_Regr_Lin_EmissioniC02.png'])

% Indici normalità residui
skewness(res1)   
kurtosis(res1)                                                          %forte normalità
% Test normalità residui
[h,p,jbstat,critval] = jbtest(res1, 0.05)                               % pv = 0.0284 --> non normalità 
[h,p,jbstat,critval] = jbtest(res1, 0.01)                               % pv = 0.0284 --> normalità
[h,p,dstat,critval] = lillietest(res1,'Alpha',0.05)                     % pv = 0.001  --> non normalità
[h,p,ci,stats] = ttest(res1)                                            % normalità usando il range (ttest)
%I test ci permettono di affermare che la distribuzione è normale (2/4) 


%%% 7. Regressione lineare multipla
%%7.1 Produzione e consumi aggregati
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
% Il modello è in grado di spiegare l'96,1% della variabilità complessiva di Y
%%% Valori fittati dal modello: yhat_t
fit2 = mhat2.Fitted;             
%%% Residui di regressione: y_t - yhat_t
res2 = mhat2.Residuals.Raw;

%%%Analisi dei residui 
% Diagnostiche sui residui: normalità
f10a = figure()
set(f10a,'position',[100,100,1250,675]);
subplot(1,2,1)
histfit(res2)
title('Distribuzione dei residui di regressione')
xlabel('Quantità emessa [Mln di tonnellate]') 
ylabel('Conteggio')

% Diagnostiche sui residui
subplot(1,2,2)
scatter(fit2,res2)        
h1 = lsline
h1.Color = 'black';
h1.LineWidth = 2;
xlabel('Valori fittati'); 
ylabel('Residui di regressione');
%text(30,0.5,sprintf('rho = %0.3f',round(corr(res2,fit2),3)))
saveas(f10a,[pwd '\immagini\10a.Residui_Regr_Mul_EmissioneC02_aggregati.png'])

% Indici normalità residui
skewness(res2)    
kurtosis(res2)                                                         %abbastanza vicini alla normalità
% Test normalità residui
[h,p,jbstat,critval] = jbtest(res2, 0.05)                              % pv = 0.5 --> normalità
[h,p,jbstat,critval] = jbtest(res2, 0.01);                              % pv = 0.5 --> normalità
[h,p,dstat,critval] = lillietest(res2,'Alpha',0.05)                    % pv = 0.5 --> normalità
[h3,p3,ci3,stats3] = ttest(res2);                                       % perfettamente normale
%I test ci permettono di affermare che la distribuzione è normale (4/4) 

% 7.2 Produzione e consumi singoli
mhat9 = fitlm(T11,'ResponseVar','Emiss_C02_NTotE','PredictorVars',{'Produz_Eolica','Produz_Carbone','Consum_CFosTras','Produz_Biomasse','Consum_Carb_TOT'})
%%% Coefficienti stimati
mhat9.Coefficients
% Intercetta significativa (pv < 0.01)
% Altre variabili significative (pv < 0.01) --> Consum. Carb tot la più
% significativa
% R-squared: 0.731, migliore significatività del modello.

%confronto reali vs fitted
f9 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese, T11.Emiss_C02_NTotE)
hold on
plot(T11.Rif_Mese, mhat9.Fitted)
hold off
title('Emssione C0_2 reali vs stimate (fitting lineare più variabili)') 
xlabel('Tempo [Mesi]')
ylabel('Quantità emessa [Mln di tonnellate]')
legend('Emissioni di CO2 dataset','Emissioni di C02 stimate')
saveas(f9,[pwd '\immagini\09.Emissioni_realiVSstimate_Regr_Multipla_singoli.png'])

anova(mhat9,'summary')
%%% Adattamento del modello
mhat9.Rsquared;
%%% Valori fittati dal modello
fit9 = mhat9.Fitted;             
%%% Residui di regressione
res9 = mhat9.Residuals.Raw;

%%%Analisi dei residui 
% Diagnostiche sui residui: normalità
f10 = figure()
set(f10,'position',[100,100,1250,675]);
subplot(1,2,1)
histfit(res9)
title('Distribuzione dei residui di regressione')
xlabel('Quantità emessa [Mln di tonnellate]') 
ylabel('Conteggio')

% Diagnostiche sui residui: incorrelazione tra fittati e residui
subplot(1,2,2)
scatter(fit9,res9)        
h1 = lsline
h1.Color = 'black';
h1.LineWidth = 2;
xlabel('Valori fittati'); 
ylabel('Residui di regressione');
saveas(f10,[pwd '\immagini\10.Residui_Regr_Mul_EmissioneC02_singoli.png'])

% Indici normalità residui
skewness(res9)    
kurtosis(res9)                                                         %abbastanza vicini alla normalità
% Test normalità residui
[h,p,jbstat,critval] = jbtest(res9, 0.05)                              % pv = 0.2678 --> normalità
[h,p,jbstat,critval] = jbtest(res9, 0.01)                              % pv = 0.2678 --> normalità
[h,p,dstat,critval] = lillietest(res9,'Alpha',0.05)                    % pv = 0.2249 --> normalità
[h3,p3,ci3,stats3] = ttest(res9)                                       % perfettamente normale
%I test ci permettono di affermare che la distribuzione è normale (4/4) 


%%% 8. Model selection
% 8.1 STEPWISE regression  (in questo caso da modello vuoto
% a pieno) [SOLO su singoli produzione e consumo].

% 1. Seleziono le colonne corrispondenti PRODUZIONE e CONSUMI
xvars = [{'Produz_Carbone'},{'Produz_GasNatur'},{'Produz_PetrGreg'},{'Produz_CFosTOT'},{'Produz_Idroelet'},{'Produz_Eolica'},{'Produz_Biomasse'},{'Consum_CFosTras'},{'Consum_petrolio_Trasp'},{'Consum_Carb_Elettr'},{'Consum_Carb_TOT'}];
T11_sel = T11(:,[xvars,{'Emiss_C02_NTotE'}]);

% 2. Applico algoritmo stepwise (dal modello vuoto a quello pieno)
% Divisione Predittori (X) e Variabile risposta (Y)
X = T11_sel{:,xvars};
y = T11_sel{:,'Emiss_C02_NTotE'};
[b,se,pval,in_stepwise,stats,nextstep,history] = stepwisefit(X,y,...
    'PRemove',0.15,'PEnter',0.05);      %penultimo rimuovo variabile se suo p-value < 15%

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
%R-squared:0.785


%%% 8.2 LASSO algorithm

% 1. Elenco tutte le variabili di regressione di interesse
xvars = [{'Produz_Carbone'},{'Produz_GasNatur'},{'Produz_PetrGreg'},{'Produz_CFosTOT'},{'Produz_Idroelet'},{'Produz_Eolica'},{'Produz_Biomasse'},{'Consum_CFosTras'},{'Consum_petrolio_Trasp'},{'Consum_Carb_Elettr'},{'Consum_Carb_TOT'}];
X = T11{:,xvars};
y = T11.Emiss_C02_NTotE;

%BHAT testa 100 lambda differenti e rispetto al numero di previsori che
%sono andato a dargli. 
[Bhat,lasso_st]=lasso(X,y,'CV',20,'MCReps',5,...   %cv 20
                'Options',statset('UseParallel',true),...
                'PredictorNames',xvars);

% 2. Identifico le variabili selezionate con LASSO
lasso_st.IndexMinMSE                                %--> migliore modello con bhat, è il 1 lambda
%Selezione variabili che vanno bene ottenute con lasso
in_lasso = not(Bhat(:,lasso_st.IndexMinMSE)==0);

% 3. Valuto modello selezionato
mhat_lasso = fitlm(T11_sel(:,[in_lasso(:)',true]),'ResponseVar','Emiss_C02_NTotE')

% 4 Vedo qual è il lambda che minimizza il MSE e SE
lassoPlot(Bhat,lasso_st,'PlotType','CV');
legend('show') % Show legend

% 5 Osservo errore di previsione associato al modello selezionato
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
% R^2 = 0.794

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DOMANDA 2 --> Previsione delle emissioni basata su modelli autoregressivi integrati a media mobile %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rappresentazione grafica della serie storica
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
% PACF --> si nota una stagionalità ogni 12 mesi, ma la
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


%%%%% ModellO AR(12)
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
summarize(EstAR12)     %mostra risultati modello
%Trovo i residui
innov_tr = infer(EstAR12, y_train_m, 'Y0',y_train_m(1:12));
innov_te = infer(EstAR12, y_test_m, 'Y0',y_test_m(1:12));
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
% Modello ARIMA (2,0,2)
MA11 = arima(2,0,2);   % AUTOREGRESSIVO DI GRADO 2, A MEDIA MOBILE DI 2
MAS11 = estimate(MA11,y_train_m,'Display','off');
summarize(MAS11);
innovMA112 = infer(MAS11, y_train_m, 'Y0',y_train_m(1:4));  
innov_te2 = infer(MAS11, y_test_m, 'Y0',y_test_m(1:4));
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

RMSE = sqrt(mean((y_test_m - fit_right2).^2))  % Root Mean Squared Error = 24.1335


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
        EstMdl = estimate(Mdl,y_train_m,'Display','off');
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
% Scegliamo il modello più parsimonioso: SARIMA((1,0,0),(12,0,0))
% Parsimonioso inteso come minor numero di parametri (Rasoio di Occam)
% In generale BIC penalizza di più la verosimiglianza quindi è più 
% parsimonioso (modello più semplice con minor numero di parametri).
SARIMA_opt = arima('ARLags',1,'SARLags',12);
summarize(SARIMA_opt)
Est_SARIMA_opt = estimate(SARIMA_opt,y_train_m);
summarize(Est_SARIMA_opt)
E = infer(Est_SARIMA_opt, y_test_m, 'Y0',T11.Emiss_C02_NTotE(1:14));
fittedSARIMA_opt = y_test_m + E;

% RMSE del test
RMSE = sqrt(mean((y_test_m - fittedSARIMA_opt).^2))  % Root Mean Squared Error = 42,527

%%%%% Modelli ARIMA (TROVATO CON ciclo for (togliendo componente stagionale)
% Modello ARIMA((3,0,3)
% y_t = alpha1*y_t-1 + Alpha12*y_t-12 + eps_t

MA11 = arima(3,0,3);                                                             % AUTOREGRESSIVO DI GRADO 3, A MEDIA MOBILE DI 3
MAS11 = estimate(MA11,y_train_m,'Display','off');
summarize(MAS11);
innovMA112 = infer(MAS11, y_train_m, 'Y0',y_train_m(1:6));  
%fittedMA112 = T11.Emiss_C02_NTotE + innovMA112;
innov_te2 = infer(MAS11, y_test_m, 'Y0',y_test_m(1:6));
%fitted = y_train_m + innov_tr;
new_2 = forecast(MAS11,24,y_test_m);
fit_right3 = new_2+innov_te2;

f15a = figure('Position',[100,100,1250,675])
plot(Period_train,y_train_m)
hold on
plot(Period_test,y_test_m)
plot(Period_test,fit_right2)
xlabel('Tempo [Mesi]') 
ylabel('Quantità emessa [Mln di tonnellate]')
legend('Osservata train','Osservata test','Fittata con ARIMA')
title('Serie storica osservata e fittata con ARIMA(3,0,3)')
saveas(f15a,[pwd '\immagini\15a.Fitting_ARIMA(3,0,3).png'])

%%% Grafico della serie osservata e stimata/fittata
f16 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese,T11.Emiss_C02_NTotE)
hold on
plot(Period_test,fittedSARIMA_opt)
plot(Period_test,fit_right2)
plot(Period_test,fit_right3)
plot(Period_test,fit_right)
xlabel('Tempo [Mesi]') 
ylabel('Quantità emessa [Mln di tonnellate]')
legend('Osservata','SARIMA((1,0,1),(12,0,0))',...
    'ARIMA(2,0,2)','ARIMA(3,0,3)','AR(12)')
title('Serie storica osservata e fittata con diversi modelli')
saveas(f16,[pwd '\immagini\16.ConfrontoModelli.png'])

%solo su test
f16a = figure('Position',[100,100,1250,675])
plot(Period_test,y_test_m,'LineWidth', 2)
hold on
plot(Period_test,fittedSARIMA_opt)
plot(Period_test,fit_right2)
plot(Period_test,fit_right3)
plot(Period_test,fit_right)
xlabel('Tempo [Mesi]') 
ylabel('Quantità emessa [Mln di tonnellate]')
legend('Osservata','SARIMA((1,0,1),(12,0,0))',...
    'ARIMA(2,0,2)','ARIMA(3,0,3)','AR(12)')
title('Serie storica osservata e fittata con diversi modelli')
saveas(f16a,[pwd '\immagini\16a.ConfrontoModelli_test.png'])

%normalizzazione residui per test ADF
media_adf = mean(innov_te2)
innovazioni_normalizzate = innov_te2-media_adf
media_nuova = mean(innovazioni_normalizzate)

%%% Analisi grafica deI residui
f17 = figure('Position',[100,100,1250,675])
subplot(2,2,1)      
plot(innovazioni_normalizzate);
hold on
yline(media_nuova,'r')
hold off
title('Serie storica dei residui')
subplot(2,2,2)       
histfit(innov_te2,20,'Normal')
title('Istogramma dei residui')
subplot(2,2,3)       
autocorr(innov_te2);
title('ACF dei residui')
subplot(2,2,4)       
parcorr(innov_te2);
title('PACF dei residui')
saveas(f17,[pwd '\immagini\17.ACF_PACF_ARIMA(2,0,2).png'])

% Test analitici sui residui
[h,p,jbstat,critval] = jbtest(innov_te2)                                  % i dati sono normali             
[h,pValue,stat,cValue] = lbqtest(innov_te2,'lags',[1,6,8,12,13])          % ai ritardi 1,8,12,13 autocorrelazione
[h,p,adfstat,critval] = adftest(innovazioni_normalizzate)                 % i residui sono stazionari

%Test di engle per l'eteroschedaticità
[h,pValue,stat,cValue] = archtest(innov_te2)
%Accetto H0 --> %no eteroschedasticità nei residui

%%% Modellazione dei residui per eliminare autocorrelazione
arma = arima(3,2,1);
aux_arma = estimate(arma,innov_te2);
% Residui del filtro 'depurati' dalla autocorrelazione
res_k = infer(aux_arma, innov_te2,'Y0',innov_te2(1:6));

% Autocorrelazione totale e parziale dei residui depurati e dei residui depurati al quadrato
f18 = figure('Position',[100,100,1250,675])
subplot(2,2,1)
autocorr(res_k)
title('ACF residui')
subplot(2,2,2)
parcorr(res_k)
title('PACF residui')
saveas(f18,[pwd '\immagini\18.ACF_PACF_residui_modellati.png'])

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% DOMANDA 3 --> Stima delle emissioni di CO2 basata su indici climatici %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Variabili di interesse
yy = T11.Emiss_C02_NTotE;       %variabile di risposta
xx = T11.HDD;   %variabile predittiva
xx2 = xx.^2; 
XX = [xx,xx2];
nn = length(yy);

plot(xx,yy,'p')
title('HDD vs Emissioni di CO_2')
xlabel('HDD [Grado giorno]')
ylabel('Quantità emessa [Mln di tonnellate]')

% Modello 1: Regressione con coefficiente angolare e intercetta statici
lm = fitlm(xx,yy);  %si usa un solo regressore R^2 = 0.201
lm2 = fitlm(XX,yy);  %qui due regressori R^2 = 0.572

%Confronto fittate lineari e fittate quadrate
f19 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese, yy)
hold on
plot(T11.Rif_Mese, lm.Fitted)
plot(T11.Rif_Mese, lm2.Fitted)
legend('Emissioni osservate','Emissioni fittate lineari','Emissioni fittate quadratiche')
xlabel('Tempo [Mesi]') 
ylabel('Quantità emessa [Mln di tonnellate]')
title('Emissioni stimate con regressione lineare')
saveas(f19,[pwd '\immagini\19.Confronti_modelli_statici_con_HDD.png'])

%confronto regressioni
f20 = figure('Position',[100,100,1250,675])
plot(xx,yy,'p')
title('HDD vs Emissioni di CO_2')
xlabel('HDD [Grado giorno]')
ylabel('Quantità emessa [Mln di tonnellate]')
hold on
plot(xx,lm.Fitted,'r','LineWidth',2)
plot(xx,lm2.Fitted,'g','LineWidth',2)
legend('Osservati','Regressione lineari','Regressione quadratica')
saveas(f20,[pwd '\immagini\20.Confronto_regressione_lin_quad_con_HDD.png'])

tt = corr(T11{:,{'Emiss_C02_NTotE','HDD'}}) %corr=0.44857
rowNames = {'Emissioni CO_2 TOT','HDD'};
colNames = {'Emissioni CO_2 TOT','HDD'};
sTable = array2table(tt,'RowNames',rowNames,'VariableNames',colNames) 

tt1=corr(T11.Emiss_C02_NTotE,xx2) %corr=0.5951 --> correlazione più forte con HDD^2

%%% Scelta del modello state-space che minimizza AIC e BIC (confronto tra
%%% due)

% Analisi emissioni con approccio state-space (MODELLO DINAMICO)
% Modello 2: Regressione con coefficiente angolare tempo-variante e
% intercetta statica (alpha statico e beta varia)
%%% Setting del modello
m1 = ssm(@(params)tvp_beta_alphaconstant(params,xx,lm.Coefficients.Estimate(1),lm.Coefficients.Estimate(2)));
% valori iniziali di log(B) e log(D)
params01 = [0.10,log(var(lm.Residuals.Raw))];
%%% Stima MLE dei parametri
disp('Stima')
mhat1 = estimate(m1,yy,params01);
% all'ultimo istante t la costante è x(1) 416.46 e il coefficiente angolare è x(2)  -0.005

% Filtraggio degli stati
xfilter2 = filter(mhat1,yy);
alpha2.flt = xfilter2(:,1);                           
plot(alpha2.flt) 
%La stima del coefficiente tende a stabilizzarsi e a convergere
beta2.flt = xfilter2(:,2);
plot(beta2.flt) 
%cattura tutto l'andamento della serie storica in quanto tempovariabile 

%Smoothing degli stati
xsmooth2 = smooth(mhat1,yy);
alpha2.smo = xsmooth2(:,1);
plot(alpha2.smo)
%Lo smoother è il valore ultimo ed è sempre costante
beta2.smo = xsmooth2(:,2);
plot(beta2.smo)

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
f21 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese, yy)
hold on
plot(T11.Rif_Mese, y2_flt)
plot(T11.Rif_Mese, y2_smo) 
legend('Emissioni osservate','Emissioni filtrate','Emissioni smoothed')
title('Emissioni stimate con modello State Space con slope tempo-variante con intercetta costante')
xlabel('Tempo [Mesi]') 
ylabel('Quantità emessa [Mln di tonnellate]')
saveas(f21,[pwd '\immagini\21.Confronto_modelloSSpace_ALPHA_constant.png'])
% apparentemente sembrano meglio quelle filtrate rispetto a quelle
% smussate, anche se non prendono il picco del lockdown

R2_flt2_alph_const = 1 - mean(e2_flt.^2) / var(yy)              %0.395
R2_smo2_alph_const = 1 - mean(e2_smo.^2) / var(yy)              %0.357

% Analisi emissioni con approccio state-space (MODELLO DINAMICO)
% Modello 2: Regressione con coefficiente angolare tempo-variante e
% intercetta tempo-variante (alpha varia e beta varia)
%%% Setting del modello
m2 = ssm(@(params)tvp_alpha_beta(params,xx,lm.Coefficients.Estimate(1),lm.Coefficients.Estimate(2)));
% valori iniziali di [log(B1) , log(B2) , log(D)]
params0 = [0.10,log(var(lm.Residuals.Raw)),log(var(lm.Residuals.Raw))];
%%% Stima MLE dei parametri
disp('Stima')
mhat2 = estimate(m2,yy,params0);
% all'ultimo istante t la costante è x(1) 383,35 e il coefficiente angolare
% è x(2)  0.054


% Filtraggio degli stati
xfilter3 = filter(mhat2,yy);
alpha3.flt = xfilter3(:,1);                           
plot(alpha3.flt) 
%La stima del coefficiente tende a stabilizzarsi e a convergere
beta3.flt = xfilter3(:,2);
plot(beta3.flt) 
%cattura tutto l'andamento della serie storica in quanto tempovariabile 

%Smoothing degli stati
xsmooth3 = smooth(mhat2,yy);
alpha3.smo = xsmooth3(:,1);
plot(alpha3.smo)
%Lo smoother è il valore ultimo ed è sempre costante
beta3.smo = xsmooth3(:,2);
plot(beta3.smo)

%%% Filtraggio e lisciamento dei valori di y
% valori filtrati di y
y3_flt = alpha3.flt + beta3.flt.*xx;
e3_flt = yy - y3_flt;
mean(e3_flt)
var(e3_flt)
% valori lisciati di y
y3_smo = alpha3.smo + beta3.smo.*xx;
e3_smo = yy - y3_smo;
mean(e3_smo)
var(e3_smo)

%%% Plot della serie originale, filtrata e smussata
f22 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese, yy)
hold on
plot(T11.Rif_Mese, y3_flt)
plot(T11.Rif_Mese, y3_smo) 
legend('Emissioni osservate','Emissioni filtrate','Emissioni smoothed')
title('Emissioni stimate con modello State Space con slope tempo-variante con intercetta tempo-variante')
xlabel('Tempo [Mesi]') 
ylabel('Quantità emessa [Mln di tonnellate]')
saveas(f22,[pwd '\immagini\22.Confronto_modelloSSpace_ALPHA_BETA_variab.png'])
% apparentemente sembrano meglio quelle filtrate rispetto a quelle
% smussate, anche se non prendono il picco del lockdown

%%% Confronto il modello statico con quello dinamico
% Fitting performance
R2_stat = lm.Rsquared.Adjusted
R2_stat_QUADR = lm2.Rsquared.Adjusted                    %modello migliore statico  (0.572)
R2_flt2 = 1 - mean(e3_flt.^2) / var(yy)                  %modello migliore dinamico (0.573)
R2_smo2 = 1 - mean(e3_smo.^2) / var(yy)

% Plot CONFRONTO MODELLO STATICO E DINAMICO migliore
f23 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese, yy)
hold on
plot(T11.Rif_Mese, lm2.Fitted)  
plot(T11.Rif_Mese, y2_flt)
legend('Emissioni osservate','Emiss modello quadratico','Emissioni filtrata')
title('Emissioni stimate con modello statico e modello dinamico')
xlabel('Tempo [Mesi]') 
ylabel('Quantità emessa [Mln di tonnellate]')
saveas(f23,[pwd '\immagini\23.Confronto_modello_opt_STATICOvsDINAMICO.png'])

%MODELLO composizione di parte regressione statica+dinamica
% (primi 9 mesi statico + 2 mesi dinamico [per catturare covid]
primi_parte = lm2.Fitted
primi_parte1 = primi_parte([1:115],:);
secod_parte = y3_flt([116:end],:);

t5_comp = [primi_parte1;secod_parte]
e5_comp = yy - t5_comp;
mean(e5_comp)
var(e5_comp)

R2_composizione = 1 - mean(e5_comp.^2) / var(yy)   %ottiene il migliore R^2 in assoluto.



%%% analisi residui sul modello statico migliore (modello quadratico)
%%% Adattamento del modello
lm2.Rsquared;
%%% Valori fittati dal modello
fit_quadrat_hdd = lm2.Fitted;             
%%% Residui di regressione
res_quadrat_hdd = lm2.Residuals.Raw;

%%%Analisi dei residui 
% Diagnostiche sui residui: normalità
f24 = figure('Position',[100,100,1250,675])
set(f24,'position',[100,100,1250,675]);
subplot(1,2,1)
histfit(res_quadrat_hdd)
title('Distribuzione dei residui di regressione')
xlabel('Quantità emessa [Mln di tonnellate]') 
ylabel('Conteggio')

% Diagnostiche sui residui: incorrelazione tra fittati e residui
subplot(1,2,2)
scatter(fit_quadrat_hdd,res_quadrat_hdd)        
h1 = lsline
h1.Color = 'black';
h1.LineWidth = 2;
xlabel('Valori fittati'); 
ylabel('Residui di regressione');
saveas(f24,[pwd '\immagini\24.Residui_Regr_hdd_quadrato.png'])

% Indici normalità residui
skewness(res_quadrat_hdd)                                                         % -1.1
kurtosis(res_quadrat_hdd)                                                         % 5.36 --> non sono normali
% Test normalità residui
[h,p,jbstat,critval] = jbtest(res_quadrat_hdd, 0.05)                              % pv = 0 --> non normalità
[h,p,jbstat,critval] = jbtest(res_quadrat_hdd, 0.01)                              % pv = 0 --> non normalità
[h,p,dstat,critval] = lillietest(res_quadrat_hdd,'Alpha',0.05)                    % pv = 0.026 --> non normalità
%I test ci permettono di affermare che la distribuzione non è normale (3/3)

%Test di engle per l'eteroschedaticità
[h,pValue,stat,cValue] = archtest(res_quadrat_hdd)                                % i residui della regressione con HDD^2 sono eteroschedastici.

%%% Modellazione residui.
res_quadrat_hdd2 = res_quadrat_hdd.^2;
%%%Autocorrelazione totale e parziale dei residui (E)
f25 = figure('Position',[100,100,1250,675])
subplot(2,2,1)
autocorr(res_quadrat_hdd,24)
title('ACF residui')
subplot(2,2,2)
parcorr(res_quadrat_hdd,24)
title('PACF residui')
subplot(2,2,3)
autocorr(res_quadrat_hdd2,24)
title('ACF residui ^2')
subplot(2,2,4)
parcorr(res_quadrat_hdd2,24)
title('PACF residui ^2')
saveas(f25,[pwd '\immagini\25.Autocorr_norm_e_quadr_Regr_hdd_quadrato.png'])

% Residui risultano autocorrelati --> Whitening
% Residui al quadrato risultano autocorrelati --> GARCH

%%% Modellazione dei residui per eliminare autocorrelazione con ARMA
arma2 = arima(3,0,5);
aux_arma2 = estimate(arma2,res_quadrat_hdd);
% Residui del filtro 'depurati' dalla autocorrelazione
res_k2 = infer(aux_arma2, res_quadrat_hdd,'Y0',res_quadrat_hdd(1:8));
% Residui 'depurati' al quadrato
res2_k2 = res_k2.^2;

% Autocorrelazione totale e parziale dei residui depurati e dei residui depurati al quadrato
f26 = figure('Position',[100,100,1250,675])
subplot(2,2,1)
autocorr(res_k2)
title('ACF residui filtro')
subplot(2,2,2)
parcorr(res_k2)
title('PACF residui filtro')
subplot(2,2,3)
autocorr(res2_k2,24)
title('ACF residui filtro^2')
subplot(2,2,4)
parcorr(res2_k2,24)
title('PACF residui filtro^2')
saveas(f26,[pwd '\immagini\26.Autocorr_norm_e_quadr_Regr_hdd_quadrato_dopo_ARMA.png'])

% Sono molto meno autocorrelati sia ACF che PACF nei residui ordinari.
% Proviamo a modellare i residui al quadrato con GARCH

%Modellazione dell'eteroschedasticità
%ARCH(2) = GARCH(0,2)    %solo componente autoregressiva
m0 = garch(0,2)
[mhat,covM,logL] = estimate(m0,res2_k2);
condVhat = infer(mhat,res2_k2);                      %estraggo residui condizionati ossia e^(2).
condVol = sqrt(condVhat);                            %conditional volatility
% AIC e BIC
n = 139;
[a,b] = aicbic(logL,mhat.P+mhat.Q,n)
% Plot dei valori fittati
f27 = figure('Position',[100,100,1250,675])
plot(T11.Rif_Mese,res2_k2)
hold on;
plot(T11.Rif_Mese,condVol)
title('Residui e inferred conditional volatility con GARCH(0,2)')
xlabel('Tempo [Mesi]') 
legend('Quantità emessa','Estim. cond. volatility','Location','NorthEast')
hold off;
saveas(f27,[pwd '\immagini\27.Garch(0,2).png'])

%%% Standardized residuals
std_res = res2_k2 ./ condVol;
std_res2 = std_res .^ 2;

%%% Diagnostiche sui residui standardizzati
f27a = figure('Position',[100,100,1250,675])
subplot(2,2,1)
plot(std_res)
title('Standardized Residuals')
subplot(2,2,2)
histogram(std_res,10)
subplot(2,2,3)
autocorr(std_res)
subplot(2,2,4)
parcorr(std_res)
saveas(f27a,[pwd '\immagini\27a.residui_standardizzati_dopo_garch.png'])

f27b = figure('Position',[100,100,1250,675])
subplot(2,2,1)
plot(std_res2)
title('Standardized Residuals Squared')
subplot(2,2,2)
histogram(std_res2,10)
subplot(2,2,3)
autocorr(std_res2)
subplot(2,2,4)
parcorr(std_res2)
saveas(f27b,[pwd '\immagini\27b.residui_standardizzati_quadrato_dopo_garch.png'])
% I residui al quadrato presentano ancora autocorrelazione parziale ma non
% importante come nel caso precedente.

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% DOMANDA 4 --> Influenza delle emissioni sulle anomalie del riscaldamento %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(passaggio al dataset annuale)

%%Correlazione su dati annuali
%T1K = T1([1:59],:);
tt3=corr(T1.AnomalieSulRiscaldamento, T1.TotalEnergyCO2EmissionsUSA)      %corr=0.7498

%regressione semplice
mhat = fitlm(T1,'ResponseVar','AnomalieSulRiscaldamento','PredictorVars','TotalEnergyCO2EmissionsUSA')   
%%% Coefficienti stimati
mhat.Coefficients              
%%% Significatività complessiva del modello
anova(mhat,'summary')
%%% Adattamento del modello
mhat.Rsquared                       % R-squared: 0.562
% Il modello è in grado di spiegare il 56,2% della variabilità complessiva di Y
%%% Valori fittati dal modello: yhat_t
fit70 = mhat.Fitted             
%%% Residui di regressione: y_t - yhat_t
res70 = mhat.Residuals.Raw

%Confronto dati veri e stimati
f28 = figure('Position',[100,100,1250,675])
plot(T1.Years,T1.AnomalieSulRiscaldamento)
hold on
plot(T1.Years, mhat.Fitted)
hold off
title('Anomalie del riscaldamento reali vs stimate (fitting lineare una variabile)') 
xlabel('Tempo [Anni]')
ylabel('Anomalie Riscaldamento')
legend('Anomalie Riscaldamento dataset','Anomalie Riscaldamento stimati')
saveas(f28,[pwd '\immagini\28.Confronto_dati_veri_stimati_annuale_Regress_semplice.png'])

%%%Analisi dei residui 
% Diagnostiche sui residui: normalità
f29 = figure('Position',[100,100,1250,675])
subplot(1,2,1)
histfit(res70)
title('Distribuzione dei residui di regressione')
xlabel('Anomalie Riscaldamento') 
ylabel('Conteggio')

% Diagnostiche sui residui: incorrelazione tra fittati e residui
subplot(1,2,2)
scatter(fit70,res70)        
h1 = lsline
h1.Color = 'black';
h1.LineWidth = 2;
xlabel('Valori fittati'); 
ylabel('Residui di regressione');
%text(30,0.5,sprintf('rho = %0.3f',round(corr(res2,fit2),3)))
saveas(f29,[pwd '\immagini\29.Residui_annuale_Regress_semplice.png'])

% Indici normalità residui
skewness(res70)    
kurtosis(res70)                                                         %non molto normali
% Test normalità residui
[h,p,jbstat,critval] = jbtest(res70, 0.05)                              % pv = 0.0086 --> non sono normalità
[h,p,jbstat,critval] = jbtest(res70, 0.01)                              % pv = 0.0086 --> non normalità
[h,p,dstat,critval] = lillietest(res70,'Alpha',0.05)                    % pv = 0.208 --> normalità
[h3,p3,ci3,stats3] = ttest(res70)                                       % normale


%Regressione lineare MULTIPLA: y_t = beta0 + beta1*x_t + epsilon_t
mhat = fitlm(T1,'ResponseVar','AnomalieSulRiscaldamento','PredictorVars',{'TotalEnergyCO2EmissionsUSA','TotalEnergyCO2EmissionChina','TotalEnergyCO2EmissionRussia'})   
%%% Coefficienti stimati
mhat.Coefficients
mhat.Rsquared           % R-squared: 0.886
% Il modello è in grado di spiegare il 88.6% della variabilità complessiva di Y
%%% Valori fittati dal modello: yhat_t
fit71 = mhat.Fitted             
%%% Residui di regressione: y_t - yhat_t
res71 = mhat.Residuals.Raw

%%% Significatività complessiva del modello
anova(mhat,'summary')

%PLOT PER VERIFICARE CONFRONTO DATI VERI E STIMATI
f30 = figure('Position',[100,100,1250,675])
plot(T1.Years,T1.AnomalieSulRiscaldamento)
hold on
plot(T1.Years, mhat.Fitted)
hold off
title('Emissioni C0_2 reali vs stimate (fitting lineare una variabile)') 
xlabel('Tempo [Anni]')
ylabel('Anomalie Riscaldamento')
legend('Anomalie Riscaldamento dataset','Anomalie Riscaldamento stimati')
saveas(f30,[pwd '\immagini\30.Confronto_dati_veri_stimati_annuale_Regress_multipla.png'])



%%%ANALISI dei residui 
% Diagnostiche sui residui: normalità
f31 = figure('Position',[100,100,1250,675])
subplot(1,2,1)
histfit(res71)
title('Distribuzione dei residui di regressione')
xlabel('Quantità emessa [Mln di tonnellate]') 
ylabel('Conteggio')

% Diagnostiche sui residui: incorrelazione tra fittati e residui
subplot(1,2,2)
scatter(fit71,res71)        
h1 = lsline
h1.Color = 'black';
h1.LineWidth = 2;
xlabel('Valori fittati'); 
ylabel('Residui di regressione');
%text(30,0.5,sprintf('rho = %0.3f',round(corr(res2,fit2),3)))
saveas(f31,[pwd '\immagini\31.Residui_annuale_Regress_mult.png'])

% Indici normalità residui
skewness(res71)                                                         %normale
kurtosis(res71)                                                         %non normale
% Test normalità residui
[h,p,jbstat,critval] = jbtest(res71, 0.05)                              % pv = 0.3145 --> normalità
[h,p,jbstat,critval] = jbtest(res71, 0.01)                              % pv = 0.3145 --> normalità
[h,p,dstat,critval] = lillietest(res71,'Alpha',0.05)                    % pv = 0.2806 --> normalità
[h3,p3,ci3,stats3] = ttest(res71)                                       % perfettamente normale

% Test autocorrelazione
[h,pValue,stat,cValue] = lbqtest(res71,'lags',[1,4,6]) %residui autocorrelati di ordine 1

f50 = figure('Position',[100,100,1250,675])
subplot(2,2,1)
autocorr(res71)
title('ACF residui')
subplot(2,2,2)
parcorr(res71)
title('PACF residui')

f32 = figure('Position',[100,100,1250,675])  %Scelta dimensioni
plot(T1.Years,T1.TotalEnergyCO2EmissionsUSA,"LineWidth",1.3)
xlabel('Tempo [Anni]')
ylabel('Emissioni CO_{2} [mln di tonnellate]')
title('Emissioni CO_{2} per categoria. Anni: 1949-2021')
hold on
plot(T1.Years,T1.TotalEnergyCO2EmissionChina,'Linewidth',1.3)
plot(T1.Years,T1.TotalEnergyCO2EmissionRussia,'Linewidth',1.3)
legend('Emissioni CO_{2} USA','Emissioni CO_{2} Cina','Emissioni CO_{2} Russia')
grid minor
saveas(f32,[pwd '\immagini\32.ConfrontoEmissioniCO2_paesi.png'])
