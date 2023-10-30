function [ pontos_segmento ] = gerar_pontos_segmentos(numero_segmentos_crossover, numero_de_cromossomos_por_gene, numero_de_genes)

numero_cromossomos = numero_de_cromossomos_por_gene*numero_de_genes;
pontos_segmento = zeros(1,2*numero_segmentos_crossover);

i = 1;
while (i<=2*numero_segmentos_crossover)

    numero = ceil(numero_cromossomos*rand);
    
    if find(pontos_segmento == numero)
    else
        pontos_segmento(1,i) = numero;
        i = i+1;
    end  

end

pontos_segmento = sort(pontos_segmento);   