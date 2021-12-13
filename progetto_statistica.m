%% IMPORTO DATASET
T = readtable('DATA SET UFFICIALE.xlsx','ReadVariableNames',true);



T.Month = datetime(T.Month,"Format","dd-MM-uuuu")  %sto trasformando con datetime e Inputformat una colonna qualsiasi facendola diventare una colonna più significativa
% Creazione variabili mese e anno usando il datetime format
%T.Month = month(T.Date);       %variabile1 aggiunge colonna
%T.Year = year(T.Date);         %variabile2 aggiunge colonna
%table2array(T)

%mofiche variabili table
T.Properties.VariableNames = {'Month','Emiss_C02_Carbo','Emiss_C02_GasNa','Emiss_C02_BenAe','Emiss_C02_CoODi','Emiss_C02_LiqId','Emiss_C02_CarJe',
                              'Emiss_C02_Keros','Emiss_C02_Lubri','Emiss_C02_BenMo','Emiss_C02_CokPe','Emiss_C02_CoORe','Emiss_C02_AltrP',
                              'Emiss_C02_Petro','Emiss_C02_NTotE','Produzi_Carbone','Produz_GasNatur','Produz_PetrGreg','Produzi_CFosTOT',
                              'Produz_Idroelet','Produzio_Eolica','Produz_Biomasse','Produz_RinnoTOT','Produz_EnePrTOT','Consum_RinnoTOT',
                              'Consum_NRinnTOT','Consum_EnePrTOT','Import_EnePrTOT','Import_PetrOPEC','Consum_CFosTras','CDD','HDD'}

%%PRESENTAZIONE DATASET
