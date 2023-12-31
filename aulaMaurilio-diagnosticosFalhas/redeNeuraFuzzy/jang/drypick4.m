drydata;
group1 = [1 2 3 4];	% y(k-1), y(k-2), y(k-3), y(k-4)
group2 = [1 2 3 4];	% y(k-1), y(k-2), y(k-3), y(k-4)
group3 = [5 6 7 8 9 10];	% u(k-1) through y(k-6)
group4 = [5 6 7 8 9 10];	% u(k-1) through y(k-6)

anfis_n = 6*15;
index = zeros(anfis_n, 4);
trn_error = zeros(anfis_n, 1);
chk_error = zeros(anfis_n, 1);
% ======= Training options 
mf_n = 2;
mf_type = 'gbellmf';
epoch_n = 1;
ss = 0.1;
ss_dec_rate = 0.5;
ss_inc_rate = 1.5;
% ====== Train ANFIS with different input variables
fprintf('\nTrain %d ANFIS models, each with 4 inputs selected from 10 candidates...\n\n',...
	anfis_n);
model = 1;
tic
for i=1:length(group1),
  for j=i+1:length(group2),
    for k=1:length(group3),
      for l=k+1:length(group4),
	in1 = deblank(input_name(group1(i), :));
	in2 = deblank(input_name(group2(j), :));
	in3 = deblank(input_name(group3(k), :));
	in4 = deblank(input_name(group4(l), :));
	fprintf('ANFIS model = %d: %s %s %s %s\n', model, in1, in2, in3, in4);
	index(model, :) = [group1(i) group2(j) group3(k) group4(l)];
	trn_data = data(1:trn_data_n, ...
		[group1(i) group2(j) group3(k) group4(l) size(data,2)]);
	chk_data = data(trn_data_n+1:size(data,1), ...
		[group1(i) group2(j) group3(k) group4(l) size(data,2)]);
	in_fismat = genfis1(trn_data, mf_n, mf_type);
	[trn_out_fismat t_err step_size chk_out_fismat c_err] = ...
		anfis(trn_data, in_fismat, ...
		[epoch_n nan ss ss_dec_rate ss_inc_rate], ...
		[0 0 0 0], chk_data);
	trn_error(model) = min(t_err);
	chk_error(model) = min(c_err);
	model = model+1;
      end
    end
  end
end
toc

% ====== Reordering according to training error
[a b] = sort(trn_error);
b = flipud(b);		% List according to decreasing trn error
trn_error = trn_error(b);
chk_error = chk_error(b);
index = index(b, :);
% ====== Display training and checking errors
figTitle = 'ANFIS: Input Selection';
figH = findobj(0, 'name', figTitle);
if isempty(figH),
	figH = figure(...
		'Name', figTitle, ...
		'NumberTitle', 'off');
else
	set(0, 'currentfig', figH);
end

x = (1:anfis_n)';
figure;
subplot(211);
plot(x, trn_error, '-', x, chk_error, '-', ...
     x, trn_error, 'o', x, chk_error, '*');
tmp = x(:, ones(1, 3))';
X = tmp(:);
tmp = [zeros(anfis_n, 1) max(trn_error, chk_error) nan*ones(anfis_n, 1)]';
Y = tmp(:);
hold on; plot(X, Y, 'g'); hold off;
axis([1 anfis_n -inf inf]);
set(gca, 'xticklabels', []);

% ====== Add text of input variables
for k = 1:anfis_n,
	text(x(k), 0, ...
	[input_name(index(k,1), :) ' ' ...
	 input_name(index(k,2), :) ' ' ...
	 input_name(index(k,3), :) ' ' ...
	 input_name(index(k,4), :)]);
end
h = findobj(gcf, 'type', 'text');
set(h, 'rot', 90, 'fontsize', 7, 'hori', 'right');
drawnow

% ====== Generate input_index for bjtrain.m
[a b] = min(trn_error);
input_index = index(b,:);
title('Training (Circles) and Test (Asterisks) Errors');
ylabel('RMSE');
