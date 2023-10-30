function [ melhores ] = escolher_melhores( vetor, quantidade, ordem )

    % ordem = 0 para menor numero
    % ordem = 1 para maior numero
    melhores = zeros(quantidade,2);
    if ordem == 0
        for i = 1:1:quantidade
            maximo = max(vetor);
            [erro indice] = min(vetor);
            melhores(i,:) = [erro indice];
            vetor(melhores(i,2)) = maximo+1;
        end
    elseif ordem == 1
        for i = 1:1:quantidade
            minimo = min(vetor);
            [erro indice] = max(vetor);
            melhores(i,:) = [erro indice];
            vetor(melhores(i,2)) = minimo-1;
        end
    else
        display('Erro na indicação do melhor');
    end

end

