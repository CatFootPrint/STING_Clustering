function output=po_recover(input,po)
    [num_row,num_col]=size(input);
    [row,col]=find(input~=0);
    position=row+1i*col;
    recover_position=position*exp(-1i*po);
    output=zeros(num_row,num_col);
    output([real(recover_position),imag(recover_position)])=1;
    showimg(output);
end