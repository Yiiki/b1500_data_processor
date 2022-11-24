filename='./data/7-8-vovbg-vd3-(port2-6 vo-4 3 5).csv';
export_filename='./data_export/7-8-vovbg-vd3-(port2-6 vo-4 3 5).xlsx';

opts = detectImportOptions(filename);
    opts = setvartype(opts,'char');  % or 'string'
    T = readtable(filename,opts);
    
    idx = find(contains(T{:,1},'DataName'));
    
    idx_Idd=find(strcmp('Idd',T{idx,:}));
    
    if isempty(idx_Idd)
        idx_Idd=find(strcmp('Idd,',T{idx,:}));
    end

    dim1 = str2double(T{idx-2,2});
    dim2 = str2double(T{idx-1,2});
    
    %       dim1    dim2
    % ________________________________________________________
    % 1     2       3       4       5
    % A     B       C       D       E
    % x     Vdd     Vbg     Ibg     Idd
    % s     s       d       s       s
    % where "s" stands for "string" and "d" stands for "double"
    % to get the data, str2double() function is needed for "s"
    % while it isn't for "d"
    
    dim2_tag_idx=(1:dim2).*dim1 + idx;
    % consider the csv is broken 
    if max(dim2_tag_idx)<=size(T,1)
        tag = 1;
    
        dim2_tag_vec=T{dim2_tag_idx,3};
        
        dim1_tag_idx=(1:dim1).*1 + idx;
        dim1_tag_vec=str2double(T{dim1_tag_idx,2});
        
        data_val_idx=(1:dim1*dim2) + idx;
        data_val_vec=str2double(T{data_val_idx,idx_Idd});
        data_val_mat=reshape(data_val_vec,[dim1,dim2]);
        
        dim1_tag_nam=T{idx,2};
        dim2_tag_nam=T{idx,3};
        
        
        %% write xlsx
        % col head
        clear col_header
        col_header{dim2+1}=[];
        for i=1:dim2+1
            if i==1
            col_header{i}=dim1_tag_nam{:};
            else
                col_header{i}=[dim2_tag_nam{:},'=',dim2_tag_vec{i-1}];
            end
        end
        % % file name
        % export_filename=[filen,'.xlsx'];
        % data body
        data_body = [dim1_tag_vec,data_val_mat];
        % write in
        writecell(col_header,export_filename,'WriteMode','overwrite')
        writematrix(data_body,export_filename,'WriteMode','append')
    else
        tag = 0;
        return
    end