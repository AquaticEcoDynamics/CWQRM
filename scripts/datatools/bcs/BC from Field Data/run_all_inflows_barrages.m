clear all; close all;

addpath(genpath('Functions'));

outdir = 'BCs_BAR_2019_2023_V4/';

if ~exist(outdir,'dir')
    mkdir(outdir);
end

load '../../../../data/store/archive/cllmm_BC.mat';


%lowerlakes = limit_datasites(cllmm,1);
lowerlakes = cllmm;
datearray(:,1) = datenum(2012,01,01,00,00,00):1:datenum(2023,07,01,00,00,00);


lowerlakes = rmfield(lowerlakes,'TLM_Mundoo_Channel');
lowerlakes = rmfield(lowerlakes,'TLM_Hunters_Creek');
lowerlakes = rmfield(lowerlakes,'TLM_Ewe_Island');
lowerlakes = rmfield(lowerlakes,'TLM_Monument_Road');

headers = {...
    'FLOW',...
    'SAL',...
    'TEMP',...
    'TRACE_1',...
    'TRACE_2',...
    'TRACE_3',...
    'TRACE_4',...
    'TRACE_5',...
    'WQ_NCS_SS1',...
    'WQ_TRC_RET',...
    'WQ_OXY_OXY',...
    'WQ_SIL_RSI',...
    'WQ_NIT_AMM',...
    'WQ_NIT_NIT',...
    'WQ_PHS_FRP',...
    'WQ_PHS_FRP_ADS',...
    'WQ_OGM_DOC',...
    'WQ_OGM_POC',...
    'WQ_OGM_DON',...
    'WQ_OGM_PON',...
    'WQ_OGM_DOP',...
    'WQ_OGM_POP',...
    'WQ_PHY_GRN',...
    'mag_ulva',...
    'mag_ulva_in',...
    'mag_ulva_ip',...
    'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
    'WQ_DIAG_TOT_TOC',...
    
    };

% %
% % %
% % % % ____________________________________________________

filename = [outdir,'Salt_Creek_20120101_20230701.csv'];
subdir = [outdir,'Salt_Creek/'];

X = 378834.;
Y = 6001351.5;

create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Salt_Creek');



filename = [outdir,'Tauwitchere_20120101_20230701.csv'];
subdir = [outdir,'Tauwitchere/'];

% X = 321940.0;
% Y = 6061790.0;

X = 324305;	
Y = 6067057;


create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Tauwitchere');


filename = [outdir,'Ewe_20120101_20230701.csv'];
subdir = [outdir,'Ewe/'];

% X = 317190.0;
% Y = 6063300.0;

X = 324305;	
Y = 6067057;

create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Ewe');


filename = [outdir,'Boundary_20120101_20230701.csv'];
subdir = [outdir,'Boundary/'];
% X = 314700;
% Y = 6064000;
% X = 324507;	
% Y = 6068128;
X = 316257;	
Y = 6067122;



% X = 315780.0;
% Y = 6067390.0;

create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Boundary');


filename = [outdir,'Mundoo_20120101_20230701.csv'];
subdir = [outdir,'Mundoo/'];
% X = 310500;
% Y = 6065700;

% X = 314110.0;
% Y = 6068270.0;
X = 316257;	
Y = 6067122;
create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Mundoo');


filename = [outdir,'Goolwa_20120101_20230701.csv'];
subdir = [outdir,'Goolwa/'];

% X = 299425.0;
% Y = 6067810.0;
X = 300692;
Y = 6067199;

create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Goolwa');

% 
% % filename = [outdir,'Albert_Opening_Phase_II_20130101_20200701.csv'];
% % subdir = [outdir,'Albert_Opening/'];
% % 
% % X = 344391.0;
% % Y = 6063658.0;
% % 
% % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Albert');
% 
% % filename = [outdir,'Albert_Phase_II_20130101_20200701.csv'];
% % subdir = [outdir,'Albert_Meningie/'];
% % 
% % X = 349821.0;
% % Y = 6050128.0;
% % 
% % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Meningie');
% % 
% % 
% % filename = [outdir,'Alex_Mid_20140101_20200701.csv'];
% % subdir = [outdir,'Alex_Mid/'];
% % 
% % X = 333094.0;
% % Y = 6077943.0;
% % 
% % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Alex');
% % 
% % filename = [outdir,'Alex_Phase_II_20130101_20200701.csv'];
% % subdir = [outdir,'Milang/'];
% % 
% % X = 321246.0;
% % Y = 6076714.0;
% % 
% % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Milang');
% % 
% % 
% % 
% % 
% % filename = [outdir,'River_Phase_II_20130101_20200701.csv'];
% % subdir = [outdir,'Tailem/'];
% % 
% % X = 359744.537;
% % Y = 6095955.698;
% % 
% % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Tailem');
% 
% 
% 

clear datearray;
 datearray(:,1) = datenum(2016,01,01,00,00,00):30/(60*24):datenum(2023,07,01,00,00,00);
% 
% 
headers{1} = 'H';

filename = [outdir,'BK_20160101_20230701.csv'];
subdir = [outdir,'BK/'];

X = 309703.3;
Y = 6062973;

 create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'BK');




filename = [outdir,'Salt_Creek_H_20120101_20230701.csv'];
subdir = [outdir,'Salt_Creek_H/'];

X = 378834.;
Y = 6001351.5;

create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Salt_Creek_H');

%
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Albert_Opening');
%
%
% filename = [outdir,'Albert_SouthWest.csv'];
% subdir = [outdir,'Albert_SouthWest/'];
%
% X = 341650.0;
% Y = 6050496.0;
%
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Albert_SouthWest');
%
%
% filename = [outdir,'Albert_Water_Level_Recorder.csv'];
% subdir = [outdir,'Albert_Water_Level_Recorder/'];
%
% X = 349307.0;
% Y = 6058801.0;
%
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Albert_Water_Level_Recorder');
%
% filename = [outdir,'Meningie.csv'];
% subdir = [outdir,'Meningie/'];
%
% X = 348605.0;
% Y = 6052257.0;
%
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Meningie');
%






%create_scenarios_flows(outdir,'Lock1_Obs',headers);

%stop
% % %
% % % % % % % % ____________________________________________________
% filename = [outdir,'MALP_Offtake.csv'];
% subdir = [outdir,'MALP_Offtake/'];
%
% X = 345925.70;
% Y = 6135137.64;
%
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'MALP_Offtake');
%
% % % ____________________________________________________
% % %____________________________________________________
% filename = [outdir,'MBO_Offtake.csv'];
% subdir = [outdir,'MBO_Offtake/'];
%
% X = 343220.92;
% Y = 6112719.63;
%
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'MBO_Offtake');
%
% % % ____________________________________________________
% filename = [outdir,'SRS_Offtake.csv'];
% subdir = [outdir,'SRS_Offtake/'];
%
% X = 371170.12;
% Y = 6174209.94;
%
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'SRS_Offtake');
%
% % % ____________________________________________________
% % % ____________________________________________________
% filename = [outdir,'TB_Offtake.csv'];
% subdir = [outdir,'TB_Offtake/'];
%
% X = 359254.30;
% Y = 6097452.90;
%
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'TB_Offtake');
%
% % %____________________________________________________
% filename = [outdir,'SR_Offtake.csv'];
% subdir = [outdir,'SR_Offtake/'];
%
% X = 350782.77;
% Y = 6120567.39;
%
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'SR_Offtake');
% % %
% % %
% % % ____________________________________________________
% filename = [outdir,'Wellington.csv'];
% subdir = [outdir,'Wellington/'];
%
% X = 352265.2;
% Y = 6085784.0;
%
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Wellington_BC_v2');
% % %
% % % %____________________________________________________
% % % filename = [outdir,'Albert_Pumping.csv'];
% % % subdir = [outdir,'Albert_Pumping/'];
% % %
% % % X = 333970.0;
% % % Y = 6072540.0;
% % %
% % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Albert_Pumping');
% % %
% % % ____________________________________________________
% % % filename = [outdir,'Goolwa_Pumping.csv'];
% % % subdir = [outdir,'Goolwa_Pumping/'];
% % %
% % % X = 312092.0;
% % % Y = 6069136.0;
% % %
% % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Goolwa_Pumping');
% % %
% % % ____________________________________________________
% % % filename = [outdir,'Alex_Excess.csv'];
% % % subdir = [outdir,'Alex_Excess/'];
% % %
% % % X = 326228.6;
% % % Y = 6070265.93;
% % %
% % % create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Alex_Excess');
%
%
% %__________________________________________________
%
%
%
% filename = [outdir,'Bremer.csv'];
% subdir = [outdir,'Bremer/'];
%
% X = 322978.0;
% Y = 6082138.0;
%
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Bremer_BC_v2');
%
% % %__________________________________________________
%
% filename = [outdir,'Angus.csv'];
% subdir = [outdir,'Angus/'];
%
% X = 304939.0;
% Y = 6099634.0;
%
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Angus_BC_v2');
%
%
% % %__________________________________________________
% filename = [outdir,'Finniss.csv'];
% subdir = [outdir,'Finniss/'];
%
% X = 302934.0;
% Y = 6080419.0;
%
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Finniss_BC_v2');
% % %
% % % __________________________________________________

% % %
% % %
% % % __________________________________________________
% filename = [outdir,'Currency.csv'];
% subdir = [outdir,'Currency/'];
%
% X = 298066.0;
% Y = 6074055.0;
%
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Currency_BC_v2');
% % % % % %
% % % % % % __________________________________________________
% % % %
% % % % %

% % % %
%
%
% headers{1} = 'H';
% filename = [outdir,'Wellington_H.csv'];
% subdir = [outdir,'Wellington/'];
%
% X = 352265.2;
% Y = 6085784.0;
%
% create_tfv_inflow_file(lowerlakes,headers,datearray,filename,X,Y,subdir,'Wellington_BC_v2');
%
%
%
%
% %
% %merge_files_cewh;
%
create_html_for_directory(outdir);
