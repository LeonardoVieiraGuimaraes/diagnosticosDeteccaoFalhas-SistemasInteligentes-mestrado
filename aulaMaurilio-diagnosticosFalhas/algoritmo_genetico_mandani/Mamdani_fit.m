function [erro] = Mamdani_fit( DNA_pessoa, n_genes, max_gene_value)
    
    entrada = 0.0001:1e-2:2*pi;
    saida_esperada = sin(entrada)./entrada;
    
    [ant_gauss_sigma ant_gauss_center con_trim] = decode_code_mandani(DNA_pessoa,n_genes,max_gene_value);
    
    saida_obtida = Mamdani( entrada, ant_gauss_sigma, ant_gauss_center, con_trim);
    
    erro = erro_medio_quadratico(saida_obtida, saida_esperada);  
    
end

