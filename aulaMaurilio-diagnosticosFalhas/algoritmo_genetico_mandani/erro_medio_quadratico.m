function [ erro ] = erro_medio_quadratico( saida_obtida, saida_esperada )
    
    n_dados = size(saida_obtida,2);
    erro = 0;
    for i=1:1:n_dados
        erro = erro + (saida_obtida(1,i)-saida_esperada(1,i))^2;
    end
    
    erro = erro/n_dados;


end

