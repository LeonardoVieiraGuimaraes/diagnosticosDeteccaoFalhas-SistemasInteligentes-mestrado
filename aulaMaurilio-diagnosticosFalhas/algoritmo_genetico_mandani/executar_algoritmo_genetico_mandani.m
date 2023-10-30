clear all
close all
clc

numero_individuos_por_geracao = 20;
numero_individuoes_vencedores = 5;
numero_maximo_geracoes = 300;
erro_minimo_parada = 1e-4;
numero_de_genes = 25;
numero_de_cromossomos_por_gene = 20;
maior_valor_de_gene = 10;
taxa_crossover = 0.3;
numero_segmentos_crossover = 100;
taxa_mutacao = 0.05;

% gerar individuos primeira geraçao

numero_de_cromossomos = numero_de_genes * numero_de_cromossomos_por_gene;
individuo = zeros(numero_individuos_por_geracao,numero_de_cromossomos);
for i = 1:1:numero_individuos_por_geracao
    individuo(i,:) = generate_dna(numero_de_cromossomos);
end


for geracao = 1:1:numero_maximo_geracoes
    % avaliar individuos
    erro_medio_quadrado_individuo = zeros(numero_individuos_por_geracao,1);
    
    for i = 1:1:numero_individuos_por_geracao
        erro_medio_quadrado_individuo(i,1) = Mamdani_fit( individuo(i,:), numero_de_genes, maior_valor_de_gene);
    end
    
    % escolher melhores
    melhores_individuos = zeros(numero_individuoes_vencedores, numero_de_cromossomos);
    melhores_erros = zeros(numero_individuoes_vencedores,1);
    
    dados_dos_melhores = escolher_melhores( erro_medio_quadrado_individuo, numero_individuoes_vencedores, 0 );
    
    for separador_melhores = 1:1:numero_individuoes_vencedores
        melhores_individuos(separador_melhores,:) = individuo(dados_dos_melhores(separador_melhores,2),:);
        melhores_erros(separador_melhores,1) = dados_dos_melhores(separador_melhores,1);
    end
    
    % gerar cross over
    
    individuo_novo = zeros(numero_individuos_por_geracao-numero_individuoes_vencedores,numero_de_cromossomos);
        % loop para gerar novos individuos
        for numero_novo_individuo = 1:1:(numero_individuos_por_geracao-numero_individuoes_vencedores)
            % gerar randomicamente numero para gerar filho
            probabilidade_gerar_filhos = zeros(numero_individuoes_vencedores,1);
            for r = 1:1: numero_individuoes_vencedores
                probabilidade_gerar_filhos(r,1) = melhores_erros(r,1)*rand;
            end
            menos_chance_de_reproducao = max(probabilidade_gerar_filhos);
            
            % escolha de pai (doa material que será inserido)
            
            [erro_pai indice_pai] = min(probabilidade_gerar_filhos);
            probabilidade_gerar_filhos(indice_pai,1) = menos_chance_de_reproducao + 1;
            
            pai(1,:) = melhores_individuos(indice_pai,:);
 
            % escolha de mae (doa material completo)
            
            [erro_mae indice_mae] = min(probabilidade_gerar_filhos);
            probabilidade_gerar_filhos(indice_mae,1) = menos_chance_de_reproducao + 1;
            
            mae(1,:) = melhores_individuos(indice_mae,:);
            
            % definir segmentos do crossover
            
            pontos_segmento = gerar_pontos_segmentos(numero_segmentos_crossover, numero_de_cromossomos_por_gene,numero_de_genes);
            
            % realizar crossover
            
            filho(1,:) = mae(1,:);
            for segmento = 1:1:numero_segmentos_crossover
                if rand <= taxa_crossover
                    filho(1,:) = two_points_crossover( pai(1,:), filho(1,:), pontos_segmento(1,2*segmento-1), pontos_segmento(1,2*segmento));
                end
            end
            
     % gerar mutação
            
            for cromossomo = 1:1:numero_de_cromossomos
                if rand <= taxa_mutacao
                    if filho(1,cromossomo) == 0
                        filho(1,cromossomo) = 1;
                    else
                        filho(1,cromossomo) = 0;
                    end
                end
            end
            
            individuo_novo(numero_novo_individuo,:) = filho; 
        end
   
    individuo(1:numero_individuoes_vencedores,:) = melhores_individuos;
    individuo(numero_individuoes_vencedores+1:numero_individuos_por_geracao,:) = individuo_novo;
    % post calculo
            texto_1 = [num2str(geracao),'geracao'];
            texto_2 = ['Erro do vencedor = ',num2str(melhores_erros(1,1))];
            [ant_gauss_sigma_vencedor ant_gauss_center_vencedor con_trim_vencedor] = decode_code_mandani(melhores_individuos(1,:),numero_de_genes,maior_valor_de_gene);
            display(texto_1);
            display(texto_2);
end
ant_gauss_sigma_vencedor
ant_gauss_center_vencedor
con_trim_vencedor