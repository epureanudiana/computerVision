function [net, info, expdir] = finetune_cnn(varargin)

%% Define options
run(fullfile(fileparts(mfilename('fullpath')), ...
  '..', '..', '..', 'matlab', 'vl_setupnn.m')) ;

opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-stl.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;

opts.train.gpus = [0];



%% update model

net = update_model();

%% TODO: Implement getIMDB function below

if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
else
  imdb = getIMDB() ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;
if rand > 0.5, images=fliplr(images) ; end

end

% -------------------------------------------------------------------------
function imdb = getIMDB()
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'birds', 'ships', 'horses', 'cars'};
splits = {'train', 'test'};

%% TODO: Implement your loop here, to create the data structure described in the assignment
%% Use train.mat and test.mat we provided from STL-10 to fill in necessary data members for training below
%% You will need to, in a loop function,  1) read the image, 2) resize the image to (32,32,3), 3) read the label of that image

train_file = load("train.mat");
test_file = load("test.mat");
[train, ~] = size(train_file.X);
[test, ~] = size(test_file.X);

% construct imdb for training set
for i = 1:train
    if ismember(train.class_names(train.y(i)), classes)
        image = reshape(train.X(i,:), [96, 96, 3]);
        imdb.images.data(:, :, :, i) = im2single(imresize(image, [32, 32]));
        
        switch train.y(i)
            case 1
                imdb.images.labels(1, i) = single(1);
            case 2
                imdb.images.labels(1, i) = single(2);
            case 9
                imdb.images.labels(1, i) = single(3);
            case 7
                imdb.images.labels(1, i) = single(4);
            case 3
                imdb.images.labels(1, i) = single(5);
        end
        
        imdb.images.set(1, i) = 1;
    end
end

% construct imdb for testing set
for i = 1:test
    if ismember(test.class_names(test.y(i)), classes)
        image = reshape(test.X(i,:), [96, 96, 3]);
        imdb.images.data(:, :, :, i + train) = im2single(imresize(image, [32, 32]));
        
        switch test.y(i)
            case 1
                imdb.images.labels(1, i + train) = single(1);
            case 2
                imdb.images.labels(1, i + train) = single(2);
            case 9
                imdb.images.labels(1, i + train) = single(3);
            case 7
                imdb.images.labels(1, i + train) = single(4);
            case 3
                imdb.images.labels(1, i + train) = single(5);
        end
        
        imdb.images.set(1, i + train) = 2;
    end
end

%%
% subtract mean
dataMean = mean(data(:, :, :, sets == 1), 4);
data = bsxfun(@minus, data, dataMean);

imdb.images.data = data ;
imdb.images.labels = single(labels) ;
imdb.images.set = sets;
imdb.meta.sets = {'train', 'val'} ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);

end
