% invx process (multi-ports)

filename='./data/U-1-7-8-vovbg(0-3)-vd3-port1-6(vo-port2,3,4,5)-1-gnd-6-vdd.csv';
export_filename='./data_export/U-1-7-8-vovbg(0-3)-vd3-port1-6(vo-port2,3,4,5)-1-gnd-6-vdd.xlsx';
tag_vec={'Vbg','Vdd','Vo','Idd','Ibg'};
prt_nam={'2','3','4','5'};

tag_num = length(tag_vec);
sheets_num = tag_num-2;
idz=zeros(1,sheets_num);

opts = detectImportOptions(filename);
opts = setvartype(opts,'char');  % or 'string'
T = readtable(filename,opts);

idx = find(contains(T{:,1},'DataName'));
dim2 = length(idx);

% error check ------------------------------------
if length(prt_nam)~=dim2
    error('error port_name file')
end
cret=str2double(T{idx(:)-2,2});
if sum(abs(diff(cret)))~=0
    error('non-self-consistent table was met.')
end
% error check ------------------------------------

dim1 = str2double(T{idx(1)-2,2});

for j=1:sheets_num
idz(j)=find(strcmp(tag_vec{j+2},T{idx(1),:}));
end

%     
%     if isempty(idx_Idd)
%         idx_Idd=find(strcmp('Idd,',T{idx,:}));
%     end
% 

val_cub=zeros(dim1,dim2,sheets_num);% "2" for "Vbg" and "Vdd"
for z3=1:size(val_cub,3)
    tcol=idz(z3);% tag column number in T
    for z2=1:size(val_cub,2)
        val_cub(:,z2,z3)=str2double(T{idx(z2)+1:idx(z2)+dim1,tcol});
    end
end

vbglis=str2double(T{idx(1)+1:idx(1)+dim1,2});
Vdd=str2double(T{idx(1)+1,3});
    
% %       dim1 (const)  sheet1  sheet2    ...
% % ________________________________________________________  _
% % 1     2       3       4       5       ...                 A
% % A     B       C       D       E       ...                 |
% % x     Vbg     Vdd     x1      x2      ...                 |
% % s     s       d       s       s                           |
% %                                                          dim2
% % ... (Appended Data)                                       |
% %                                                           |
% % 1     2       3       4       5       ...                 V
% % A     B       C       D       E       ...                 -
% % x     Vbg     Vdd     x1      x2      ...                 
% % s     s       d       s       s                   
% % 
% % where "s" stands for "string" and "d" stands for "double"
% % to get the data, str2double() function is needed for "s"
% % while it isn't for "d"
% 

dim2_tag_idx=(1:dim2).*dim1 + idx(1);
% consider the csv is broken 
if max(dim2_tag_idx)<=size(T,1)

    tag = 1;

    for sht=1:sheets_num

    %% write xlsx
    % col head
    clear col_header
    col_header{dim2+1}=[];
    
    for i=1:dim2+1
        if i==1
            col_header{i}=[tag_vec{i},' (',tag_vec{i+1},'=',num2str(Vdd),')'];% 'Vbg(Vdd=xxx)'
        else
            col_header{i}=[tag_vec{sht+2},' (port',prt_nam{i-1},')'];% 'tag (portxxx)'
        end
    end
    % % file name
    % export_filename=[filen,'.xlsx'];
    % data body
    data_body = [vbglis,val_cub(:,:,sht)];
    % write in
    writecell(col_header,export_filename,'Sheet',sht,'WriteMode','overwrite')
    writematrix(data_body,export_filename,'Sheet',sht,'WriteMode','append')

    end

else
    tag = 0;
    return
end