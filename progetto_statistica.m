%% IMPORTO DATASET
T = readtable('DATA SET UFFICIALE.xlsx');

%% RINOMINARE COLONNE
% T.Month = datetime(T.Month,"Format","dd-MM-uuuu"); in realtà non serve 
T.Properties.VariableNames = {'Rif_Mese','Emiss_C02_Carbo','Emiss_C02_GasNa','Emiss_C02_BenAe','Emiss_C02_CoODi','Emiss_C02_LiqId','Emiss_C02_CarJe','Emiss_C02_Keros','Emiss_C02_Lubri','Emiss_C02_BenMo','Emiss_C02_CokPe','Emiss_C02_CoORe','Emiss_C02_AltrP','Emiss_C02_Petro','Emiss_C02_NTotE','Produzi_Carbone','Produz_GasNatur','Produz_PetrGreg','Produzi_CFosTOT','Produz_Idroelet','Produzio_Eolica','Produz_Biomasse','Produz_RinnoTOT','Produz_EnePrTOT','Consum_RinnoTOT','Consum_NRinnTOT','Consum_EnePrTOT','Import_EnePrTOT','Import_PetrOPEC','Consum_CFosTras','CDD','HDD'}

%% PLOT DATA

f1 = figure('Position',[100,100,1250,675])  %Scelta dimensioni
plot(T.Rif_Mese,T.Emiss_C02_NTotE,'Linewidth',1.3)
xlabel('Anni')
ylabel('Emissioni CO_{2}')
title('Emissioni CO_{2} da carbone dal 1973-2021')
hold on
plot(T.Rif_Mese,T.Emiss_C02_Carbo,'Linewidth',1.3)
plot(T.Rif_Mese,T.Emiss_C02_GasNa,'Linewidth',1.3)
plot(T.Rif_Mese,T.Emiss_C02_Petro,'Linewidth',1.3)
ylim([0 700])
legend('Emissioni CO_{2} TOT','Emissioni CO_{2} da Carbone','Emissioni CO_{2} da Gas Naturale','Emissioni CO_{2} da Petrolio')
grid minor
saveas(f1,[pwd '\immagini\1.ConfrontoEmissioni.png'])

f2 = figure('Position',[100,100,1250,675])  %Scelta dimensioni
plot(T.Rif_Mese,T.Produzi_CFosTOT,'Linewidth',1.3)
xlabel('Anni')
ylabel('Emissioni CO_{2}')
title('Emissioni CO_{2} da carbone dal 1973-2021')
hold on
plot(T.Rif_Mese,T.Produzi_Carbone,'Linewidth',1.3)
plot(T.Rif_Mese,T.Produz_GasNatur,'Linewidth',1.3)
plot(T.Rif_Mese,T.Produz_PetrGreg,'Linewidth',1.3)
plot(T.Rif_Mese,T.Consum_NRinnTOT,'Linewidth',1.3)
legend('Prod CO_{2} TOT','Prod CO_{2} da Carbone','Prod CO_{2} da Gas Naturale','Emissioni CO_{2} da Petrolio','Consumo_NonRinnova')
grid minor
saveas(f2,[pwd '\immagini\2.ConfrontoProduzioneNonRinnovabili.png'])

f3 = figure('Position',[100,100,1250,675])  %Scelta dimensioni
plot(T.Rif_Mese,T.Produz_RinnoTOT,'Linewidth',1.3)
xlabel('Anni')
ylabel('Emissioni CO_{2}')
title('Emissioni CO_{2} da carbone dal 1973-2021')
hold on
plot(T.Rif_Mese,T.Produz_Idroelet,'Linewidth',1.3)
plot(T.Rif_Mese,T.Produzio_Eolica,'Linewidth',1.3)
plot(T.Rif_Mese,T.Produz_Biomasse,'Linewidth',1.3)
plot(T.Rif_Mese,T.Consum_RinnoTOT,'Linewidth',1.3)
legend('Prod_Rinnovabili','Prod_idr','Prod_eol','Prod_biom','Consumo_Rinnov')
grid minor
saveas(f3,[pwd '\immagini\3.ConfrontoProduzioneRinnovabili.png'])
