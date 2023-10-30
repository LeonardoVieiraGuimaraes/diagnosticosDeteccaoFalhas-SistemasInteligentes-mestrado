function [ant_gauss_sigma ant_gauss_center con_trim] = decode_code_mandani( DNA_pessoa, n_genes, max_gene_value)

    number_chromosome = size(DNA_pessoa,2);
    number_chromosome_per_genes = number_chromosome/n_genes;
    decoded_code = zeros(1,n_genes);
    ant_gauss_sigma = zeros(5,1);
    ant_gauss_center = zeros(5,1);
    con_trim = zeros(5,3);
    
    
    for gene = 1:1:n_genes
        selected_gene = DNA_pessoa(1,(number_chromosome_per_genes*(gene-1)+1):gene*number_chromosome_per_genes);
        decoded_code(1,gene) = decode_gene(selected_gene,max_gene_value);
    end
    
    for gene = 1:1:5
        ant_gauss_sigma(gene,1) = decoded_code(1,gene);
    end
    
    for gene = 1:1:5
        ant_gauss_center(gene,1) = decoded_code(1,gene+6);
    end
    
    for gene = 1:1:5
        
        con1 = decoded_code(1,(3*(gene-1))+11);
        con2 = decoded_code(1,(3*(gene-1))+12);
        con3 = decoded_code(1,(3*(gene-1))+13);
        
        con = [con1 con2 con3];
        
        con_trim(gene,1) = min(con);
        con_trim(gene,3) = max(con);
        
        for i=1:1:3
            if con(i)~=con_trim(gene,1)
                if con(i)~=con_trim(gene,3)
                    con_trim(gene,2) = con(i);
                end
            end
        end
        
        
    end


end

