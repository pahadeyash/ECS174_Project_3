function [Features] = get_features(sift_dir, train_size)
%GET_FEATURES Summary of this function goes here
%   Detailed explanation goes here
    fnames = dir([sift_dir '/*.mat']);
    num_feats = length(fnames);

    fnames_vector = randperm(num_feats, train_size); %6612 is the number of images in fnames and 500 distinct images are randomly picked

    Features = [];
    for i = 1:train_size
        fname = [sift_dir '/' fnames(fnames_vector(i)).name];
        load(fname, 'descriptors');
        Features= [Features; descriptors];
    end
    save('Features.mat', 'Features');
end