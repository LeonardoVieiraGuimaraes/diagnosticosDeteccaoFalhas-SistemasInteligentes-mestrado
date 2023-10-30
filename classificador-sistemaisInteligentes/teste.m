pkg load nnet;

% Generate a random dataset
x = rand(100, 2);
y = x(:, 1) + x(:, 2) > 1;

% Define the input ranges
input_ranges = [min(x); max(x)];

% Check the input ranges
if any(input_ranges(1, :) > input_ranges(2, :))
    error('Invalid input ranges');
end

% Create a feedforward neural network with 1 hidden layer
net = newff(input_ranges, [5 1], {'tansig', 'purelin'}, 'trainlm');

% Set the training parameters
net.trainParam.epochs = 1000;
net.trainParam.goal = 0.01;
net.trainParam.lr = 0.1;
net.trainParam.show = 25;

% Train the network
[net, tr] = train(net, x', y');

% Test the network on a new input
x_test = [0.5 0.5]';
y_test = sim(net, x_test);

% Print the output
disp(y_test);