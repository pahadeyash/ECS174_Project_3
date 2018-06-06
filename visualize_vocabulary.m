addpath('./provided_code/');
framesdir = './frames/';
siftdir = './sift/';

fnames = dir([siftdir '/*.mat']);

fnames_vector = randperm(6612, 25); %6612 is the number of images in fnames and 450 distinct images are randomly picked

feature_matrix = [];

for i = 1:25
    fname = [siftdir '/' fnames(fnames_vector(i)).name];
    load(fname, 'descriptors');
    feature_matrix= [feature_matrix; descriptors];
end

[membership,means,rms] = kmeansML(100,transpose(feature_matrix));
