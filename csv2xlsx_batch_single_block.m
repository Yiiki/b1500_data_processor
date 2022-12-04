listing=dir('./data/*.csv');
item_num=length(listing);

warning('off','MATLAB:table:ModifiedAndSavedVarnames')

for i=1:item_num
% for i=1
    file_raw=listing(i).name;
    fprintf('processing %.100s',file_raw)
    filen=file_raw(1:end-4);
    filename=['./data/',filen,'.csv'];
    export_filename=['./data_export/',filen,'.xlsx'];
    tag = b15_single_block(filename,export_filename);
    if tag==1
        fprintf('...succeed.\n')
    elseif tag==0 
        fprintf(' * * * * failed, due to the file broken.\n')
    end
end

warning('on','MATLAB:table:ModifiedAndSavedVarnames')