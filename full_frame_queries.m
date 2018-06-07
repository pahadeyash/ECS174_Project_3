addpath('./provided_code/');
framesdir = './frames/';
siftdir = './sift/';

load('kMeans.mat');

means = transpose(means);

fnames = dir([siftdir '/*.mat']);
siftdir_index = randperm(6612,3);

score = []; 

for i = 1:3
    fname = [siftdir '/' fnames(siftdir_index(i)).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    distance = dist2(descriptors, means);
    [~,min_indx]= min(transpose(distance)); 
    [m, ~] = size(means);
    bincounts = histc(min_indx, 1:m);
    [size_fnames, ~] = size(fnames);
    for j = 1:size_fnames
        fnames_cmp = [siftdir '/' fnames(j).name];
        if strcmp(fname, fnames_cmp) == 0
            load(fnames_cmp, 'imname', 'descriptors', 'positions', 'scales', 'orients');
            distance = dist2(descriptors, means);
            [~,min_indx]= min(transpose(distance)); 
            [m, ~] = size(means);
            bincounts_temp = histc(min_indx, 1:m);
            result = dot(bincounts, bincounts_temp) / norm(bincounts) * norm(bincounts_temp);
            score = [score ; result]; 
        else 
            score = [score ; -1];
        end
    end    
end
