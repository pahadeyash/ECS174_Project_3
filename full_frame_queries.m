addpath('./provided_code/');
framesdir = './frames/';
sift_dir = './sift/';

load('kMeans.mat');

means = transpose(means);

fnames = dir([sift_dir '/*.mat']);
pnames = dir([framesdir '/*.jpeg']);

num_feats = length(fnames);
siftdir_index = randperm(num_feats,1);

% Histograms = get_histograms(sift_dir, means);
load('Histograms.mat');

score = []; 
ind = [];
M=5;

f1 = figure;
f2 = figure;
% for i = 1:3
    figure(f1);
    fname = [sift_dir '/' fnames(siftdir_index).name];
    pname = [framesdir '/' pnames(siftdir_index).name];
    fprintf("%s\n", pname);
    imshow(imread(pname));
    bincounts = Histograms(siftdir_index(1),:);
    for j = 1:num_feats
        fnames_cmp = [sift_dir '/' fnames(j).name];
        if j ~= siftdir_index(1)
            bincounts_temp = Histograms(j,:);
            result = dot(bincounts, bincounts_temp) / (norm(bincounts) * norm(bincounts_temp));
            score = [score ; result]; 
        else
            score = [score ; -1];
        end
    end
    
    score(isnan(score)) = -1;
    
    figure(f2);
            
    [sorted, ind] = sort(score, 'descend');
    
    for k=1:M
        subplot(2, 3, k);
        fprintf("%s\n", pnames(ind(k)).name);
        impath = [framesdir '/' pnames(ind(k)).name];
        im = imread(impath);
        imshow(im);
        title(pnames(ind(k)).name);
    end
    
% end
