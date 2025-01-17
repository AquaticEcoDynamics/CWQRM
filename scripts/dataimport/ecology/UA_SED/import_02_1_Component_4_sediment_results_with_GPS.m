clear all; close all;

addpath(genpath('../../../../../aed_matlab_modeltools/TUFLOWFV/tuflowfv/'));

filepath = '../../../../data/incoming/TandI_1/Sediment/';

filename = 'Component 4 sediment results with GPS.xlsx';

thedate = datenum(2019,05,19);

agency = 'UA Sediment';

% >2mm gravel
% 1-2mm very coarse
% 500um - 1mm coarse sand
% 250-500 medium sand
% 125-250 fine sand
% 63-125 very fine sand
% <63 mud


thevars =  {...
    'WQ_DIAG_SDG_Moisture',...
'WQ_DIAG_SDG_pH15',...
'WQ_DIAG_SDG_EC15',...
'Ignore',...
'WQ_DIAG_SDG_TN',...
'WQ_DIAG_SDG_TOC',...
'WQ_DIAG_SDG_OM',...
'Ignore',...
'WQ_DIAG_SDG_TP',...
    };



theconv = [
    1
1
1
1
1
1
1
1
1
];



[snum,sstr] = xlsread([filepath,filename],'Sample GPS coordinates','A2:C8');

site = sstr(:,1); site = regexprep(site,' ','_');

lat = snum(:,1);
lon = snum(:,2);

[X,Y] = ll2utm(lat,lon);

[snum,sstr] = xlsread([filepath,filename],'Main- Page 1','D9:J17');


data = snum';

for i = 1:length(site)
    for j = 1:length(thevars)
                
        if strcmpi(thevars{j},'Ignore') == 0
            
            ua_sediment_results.(site{i}).(thevars{j}).Date = thedate;
            ua_sediment_results.(site{i}).(thevars{j}).Data = data(i,j) * theconv(j);
            ua_sediment_results.(site{i}).(thevars{j}).Depth = 0;
            ua_sediment_results.(site{i}).(thevars{j}).X = X(i);
            ua_sediment_results.(site{i}).(thevars{j}).Y = Y(i);
            ua_sediment_results.(site{i}).(thevars{j}).Agency = agency;
            
        end
    end
end

save('../../../../data/store/ecology/ua_sediment_results.mat','ua_sediment_results','-mat');
