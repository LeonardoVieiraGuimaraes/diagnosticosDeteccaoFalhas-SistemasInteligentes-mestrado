function [ decoded_num ] = decode_gene( gene, max_gene_value )
    gene_size = size(gene,2);
    num = 0;
    for i = 1:1:gene_size-1
        num = num + (2^i)*gene(1,i);
    end
    decoded_num = change_scale(num,2^gene_size,max_gene_value);
end

