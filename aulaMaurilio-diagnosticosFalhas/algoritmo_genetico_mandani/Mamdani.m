function [ saida ] = Mamdani( entrada, ant_gauss_sigma, ant_gauss_center, con_trim)

    % obs: testado apenas com entrada de 1 dimens�o, ou seja, as regras s�o
    % compostas da seguinte forma se X � A ent�o Y � Z. Teoricamente
    % funcina para mais, mas n�o foi testado
    
    % as entradas seguem o seguinte formato entrada[x11 x21 x31
    %                                               x12 x22 x32]-;
    
    % func�es de pertinencia s�o gaussiana e divididas em 2 vetores,
    % ant_gauss_sigma ant_gauss_center, o primeiro indica o sigma e o
    % segundo indica o centro. segue o formato abaixo
    % ant_gauss_sigma = [f11 f12]
    %                    f21 f22]
    % ant_gauss_sigma = [c11 c12]
    %                    c21 c22]
    
    % os consequentes s�o triangulares e definidos em con_trim no seguinte 
    % formato
    % con_trim = [ci1 cm1 cf1
    %             ci2 cm2 cf2]
    % i indica o inicio da fun��o, m o meio e f o fim do triangulo,
    % indicamos c1 como a fun��o de consequente 1
    
    % a partir dos formatos acima essa fun��o determina as regras da 
    % seguinte maneirasendo as regras formadas por: se x11 � f11 e x12 � f12
    % ent�o Y � c1
    
    % para calcular a sa�da � usado o centroid of area na defuzzyfica��o
    
    saida_maxima = max(max(con_trim));
    precisao = 1e-2;
    n_entradas = size(entrada,2);
    n_funcoes = size(ant_gauss_sigma,1);
    n_dimensoes = size(ant_gauss_sigma,2);
    saida = zeros(1,n_entradas);
    
    if n_funcoes == size(ant_gauss_center,1);
        
        % loop para calcular todas as saidas
        for e = 1:1:n_entradas
            
            
            pertinencias = zeros(n_funcoes,n_dimensoes);
            operador = zeros(n_funcoes,1);
            saidas_consequente = zeros(n_funcoes,1/precisao*ceil(saida_maxima)+1);
            agregado = zeros(1,1/precisao*ceil(saida_maxima)+1);
            
            
            % calcular pertinencias
            for d = 1:1:n_dimensoes
                for f = 1:1:n_funcoes
                    pertinencias(f,d) = gaussmf(entrada(1,e),[ant_gauss_sigma(f,d) ant_gauss_center(f,d)]);
                end
            end
            
            % aplicar operador max
            for f = 1:1:n_funcoes
                for d = 1:1:n_dimensoes
                    operador(f,1) = max(operador(f,1),pertinencias(f,d));
                end
            end
            
            % consequente
            i = 0:precisao:(ceil(saida_maxima));
            for f = 1:1:n_funcoes
                operador_consequente = ones(1,1/precisao*ceil(saida_maxima)+1).*operador(f,1);
                funcao_consequente = trimf(i,[con_trim(f,1) con_trim(f,2) con_trim(f,3)]);
                saidas_consequente(f,:) = min(operador_consequente,funcao_consequente);
            end
            
            % agrega��o
            for f = 1:1:n_funcoes
                agregado(1,:) = max(agregado(1,:), saidas_consequente(f,:));
            end
            
            % desfuzzyfica��o
            numerador = 0;
            denominador = 0;
            for a = 1:1:size(agregado,2);
                numerador = numerador + agregado(1,a)*i(a)*precisao;
                denominador = denominador + agregado(1,a)*precisao;
            end
            saida(1,e) = numerador/denominador;
            
        end
    else
        display('Dados de fun��es de pertin�ncia incompletos.');
    end

end

