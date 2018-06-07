addpath('./provided_code/');
framesdir = './frames/';
sift_dir = './sift/';

load('kMeans.mat');
means = transpose(means);

load('Histograms.mat');

fnames = dir([sift_dir '/*.mat']);
pnames = dir([framesdir '/*.jpeg']);

num_feats = length(fnames);

rand_frame = randperm(num_feats, 1);

fname = [sift_dir '/' fnames(rand_frame).name];
pname = [framesdir '/' pnames(rand_frame).name];

load(fname, 'descriptors', 'positions');

im = imread(pname);
oninds = selectRegion(im, positions);

f1 = figure;
f2 = figure;

figure(f1);
imshow(im);

descriptors_region = descriptors(oninds, :);

% create new histogram for the selected region
euDistance = dist2(means, descriptors_region);
[~, min_ind] = min(euDistance);
[m, ~] = size(means);
new_bincount = histc(min_ind, 1:m);

score = [];

for i=1:num_feats
    if i ~= rand_frame
        bincounts_temp = Histograms(i,:);
        result = dot(new_bincount, bincounts_temp) / (norm(new_bincount) * norm(bincounts_temp));
        score = [score ; result];
    else
        score = [score ; -1];
    end
end

score(isnan(score)) = -1;

[sorted, ind] = sort(score, 'descend');

M=5;
figure(f2);
for k=1:M
    subplot(2, 3, k);
    fprintf("%s\n", pnames(ind(k)).name);
    impath = [framesdir '/' pnames(ind(k)).name];
    im = imread(impath);
    imshow(im);
    title(pnames(ind(k)).name);
end






