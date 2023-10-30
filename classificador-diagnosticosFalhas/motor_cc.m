function [X,Y]=motor_cc
% Parametros do motor cc
ran=4.6e-3;
rfdn=12.1875;
Lan=2.38e-4;
Lfdn=8.750;
Lafd=0.23;
Jm=2580;
va=750;
vfd=750;
ia=17098;
Bmn=127;

parametros = [ran, rfdn, Lan, Lfdn, Lafd, Jm, va, vfd, ia, Bmn];

fprintf('- Tipo de falha:\n');
fprintf('(1) Abertura da bobina da armadura\n');
fprintf('(2) Abertura da bobina de campo\n');
fprintf('(3) Curto-circuito do conversor da armadura\n');
fprintf('(4) Curto-circuito do conversor do campo\n');
fprintf('(5) Curto-circuito entre espiras da bobina de armadura\n');
fprintf('(6) Curto-circuito entre espiras da bobina de campo\n');
fprintf('(7) Falha no sistema de ventilacao\n');
fprintf('(8) Falha de lubrificacao dos mancais\n');
fprintf('(9) Falha no sensor de corrente da armadura\n');
fprintf('(10) Falha no sensor de corrente do campo\n');
fprintf('(11) Falha no sensor de velocidade\n');
fprintf('(12) Nenhuma\n');
falha = input(' Opcao: ');

switch falha
   case 1
    % Abertura da bobina da armadura
    falhas = [0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]; 
  case 2
    % Abertura da bobina de campo
    falhas = [1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
  case 3
    % Curto-circuito do conversor da armadura
    falhas = [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
  case 4
    % Curto-circuito do conversor do campo
    falhas = [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
  case 5
    % Curto-circuito entre espiras da bobina de armadura
    falhas = [1, 1, 0, 0, 0.1, 0.1, 1, 1, 1, 1, 1, 1, 1, 1];
  case 6
    % Curto-circuito entre espiras da bobina de campo
    falhas = [1, 1, 0, 0, 1, 1, 0.2, 0.2, 1, 1, 1, 1, 1, 1];
  case 7
    % Falha no sistema de ventilacao
    falhas = [1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1];
  case 8
    % Falha de lubrificacao dos mancais
    falhas = [1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1];
  case 9
    % Falha no sensor de corrente da armadura
    falhas = [1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1];
  case 10
    % Falha no sensor de corrente do campo
    falhas = [1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1];
  case 11
    % Falha no sensor de velocidade
    falhas = [1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0];
  case 12
    % Nenhuma
    falhas = [1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];  
  otherwise, 
end;

pause(1);

[out y1 y2 y3 t] = simulador_cc(parametros, falhas);

X=[out y1' y2' y3'];
Y=[y1' y2' y3'];
