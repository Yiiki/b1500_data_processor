function tag = b15_single_block(filename,export_filename)
% filename='./data/U-1-7-8-vovbg(0-3)-vd3-port1-6(vo-port2)-1-gnd-6-vdd-1hz-hold1s.csv';
% export_filename='./data_export/U-1-7-8-vovbg(0-3)-vd3-port1-6(vo-port2)-1-gnd-6-vdd-1hz-hold1s.xlsx';

opts = detectImportOptions(filename);
opts = setvartype(opts,'char');  % or 'string'
T = readtable(filename,opts);

idx = find(contains(T{:,1},'DataName'));
name_vec_tag=cellfun(@isempty,T{idx,:});% detect empty cell
name_vec=T{idx,~name_vec_tag};
name_vec(1)=[];% brace is needed to properly delete elm in cell

dim1 = str2double(T{idx-2,2});

value_block=T{idx+1:idx+dim1,2:length(name_vec)+1};

dim2 = str2double(T{idx-1,2});

dim2_tag_idx=(1:dim2).*dim1 + idx;

% consider the csv is broken 

if max(dim2_tag_idx)<=size(T,1)
    tag = 1;

    %% write xlsx
    % col head
    col_header=name_vec;       
    % data body
    data_body = str2double(value_block);
    % write in
    writecell(col_header,export_filename,'WriteMode','overwrite')
    writematrix(data_body,export_filename,'WriteMode','append')
else
    tag = 0;
    return
end

end