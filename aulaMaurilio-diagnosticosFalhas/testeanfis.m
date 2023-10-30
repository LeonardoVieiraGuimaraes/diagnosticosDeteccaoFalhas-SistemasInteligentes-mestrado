close all;
clear all;

x = -10:20/1000:10;
y = -10:20/1000:10;


z = (sin(x).*sin(y))./(x.*y);

genOpt = genfisOptions('GridPartition');
genOpt.NumMembershipFunctions = [4 4];
genOpt.InputMembershipFunctionType = 'gaussmf';
inFIS = genfis(x,y,z,genOpt);

opt = anfisOptions('InitialFIS',inFIS);
opt.DisplayANFISInformation = 0;
opt.DisplayErrorValues = 0;
opt.DisplayStepSize = 0;
opt.DisplayFinalResults = 0;

outFIS = anfis([x y z],opt);

plot3(x,y,x,evalfis(x,outFIS))
legend('Training Data','ANFIS Output')