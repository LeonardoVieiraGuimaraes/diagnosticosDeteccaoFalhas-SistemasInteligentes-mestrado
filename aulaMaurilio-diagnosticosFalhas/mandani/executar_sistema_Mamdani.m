clear all
clc

entrada = 0.0001:1e-2:2*pi;

saida_esperada = sin(entrada)./entrada;

% ant_gauss_sigma = [0.2491;0.034;5.2944;7.5619;0.3007];
ant_gauss_sigma = [0.024;0.5001;0.0126;4.9646;0.6144];
%ant_gauss_center = [1.4871;7.0261;0.2774;6.0272;0.4443];
ant_gauss_center = [6.6062;8.9318;7.8703;2.7127;0.2255];
%con_trim = [0.4443 0.4996 1.1503;0.2942 3.5494 3.9624;0.0088 0.0187 0.036;0.0020 0.0342 0.1064; 0.225 1.0447 1.2107];
con_trim = [0.2255 1.8949 2.0424;1.4614 5.0717 5.2213;3.2695 9.3892 9.6073;0.0077 0.0196 0.0422; 0.4759 0.6142 1.4299];
saida_obtida = Mamdani( entrada, ant_gauss_sigma, ant_gauss_center, con_trim);

erro = erro_medio_quadratico(saida_obtida, saida_esperada)

plot(entrada, saida_esperada)
hold on
plot(entrada, saida_obtida,'r')