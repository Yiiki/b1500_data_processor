% appended mode applicable (i.e., many 'DataName' can be detected)
% appended blocks (identified by 'appvar') should have same test conditions 
% seen by B1500A
% 
% Var1 should share point number among these appvar
% Var2 should keep constant among Var1 (mainly due to B1500) and appvar 
% ObsX can be arbitrarily many.

% the output xlsx file sorts the ObsX to SheetX, Var1 as dim1, appvar as
% dim2
suffix='.xlsx';
% ------  Var1   Var2  Obs1   Obs2   Obs3
tag_vec={'Vbg', 'Vdd', 'Vo1', 'Idd', 'Ibg'};
% appended define
appnam='port';
appvar={'Dev1Port3','Dev3Port2'};% FIFO
fliptag=1;

listing=dir('./data/*.csv');
item_num=length(listing);

warning('off','MATLAB:table:ModifiedAndSavedVarnames')

for i=1:item_num
% for i=1
    file_raw=listing(i).name;
    fprintf('processing %.100s',file_raw)
    filen=file_raw(1:end-4);
    filename=['./data/',filen,'.csv'];
    export_filename=['./data_export/',filen];
    tag = b15csv2xlsx_invx_vddx_flip(filename,export_filename,suffix,tag_vec,appnam,appvar,fliptag);
    if tag==1
        fprintf('...succeed.\n')
    elseif tag==0 
        fprintf(' * * * * failed, due to the file broken.\n')
    end
end

warning('on','MATLAB:table:ModifiedAndSavedVarnames')