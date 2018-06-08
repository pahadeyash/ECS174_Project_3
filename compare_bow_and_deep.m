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
M=11;

f1 = figure;
f2 = figure;
f3 = figure;
% for i = 1:3
    figure(f1);
    % friends_0000004503.jpeg
     fname = [sift_dir '/friends_0000004503.jpeg.mat' ];
     pname = [framesdir '/friends_0000004503.jpeg' ];
    
    %friends_0000000394.jpeg
    %fname = [sift_dir '/friends_0000000394.jpeg.mat' ];
    %pname = [framesdir '/friends_0000000394.jpeg' ];
    
    fprintf("%s\n", pname);
    imshow(imread(pname));
    
    % friends_0000004503.jpeg
    bincounts = Histograms(4444,:);
    
    %friends_0000000394.jpeg
    %bincounts = Histograms(335,:);

    
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
        subplot(4, 3, k);
        fprintf("%s\n", pnames(ind(k)).name);
        impath = [framesdir '/' pnames(ind(k)).name];
        im = imread(impath);
        imshow(im);
        if k == 1
            title('Query Image');
        else
            title(pnames(ind(k)).name);
        end
    end
    
    score = [];
    
    load(fname, 'deepFC7');
    orig_deep = deepFC7;
    for j = 1:num_feats
            fnames_cmp = [sift_dir '/' fnames(j).name];
            load(fnames_cmp, 'deepFC7');
            if j ~= siftdir_index(1)
                %bincounts_temp = Histograms(j,:);
                result = dot(orig_deep, deepFC7) / (norm(orig_deep) * norm(deepFC7));
                score = [score ; result]; 
            else
                score = [score ; -1];
            end
    end
   
    score(isnan(score)) = -1;
     
    figure(f3);
    
    [sorted, ind] = sort(score, 'descend');
    
    for k=1:M
        subplot(4, 3, k);
        fprintf("%s\n", pnames(ind(k)).name);
        impath = [framesdir '/' pnames(ind(k)).name];
        im = imread(impath);
        imshow(im);
        if k == 1
            title('Query Image');
        else
            title(pnames(ind(k)).name);
        end
    end
% end
