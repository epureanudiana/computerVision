%% main function 


%% fine-tune cnn

[net, info, expdir] = finetune_cnn();

%% extract features and train svm

% TODO: Replace the name with the name of your fine-tuned model
nets.fine_tuned = load(fullfile(expdir, 'fine_tuned_model.mat')); nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-stl.mat'));

%{
subplot(1, 2, 1);
visualization(nets.pre_trained, 10, data, "pre-trained")
subplot(1, 2, 2);
visualization(nets.fine_tuned, 10, data, "fine-tuned")
%}
%%
train_svm(nets, data);
