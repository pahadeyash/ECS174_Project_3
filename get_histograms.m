function [Histograms] = get_histograms(sift_dir, means)
%GET_HISTORGRAMS Summary of this function goes here
%   Detailed explanation goes here
    fnames = dir([sift_dir '/*.mat']);
    num_feats = length(fnames);
    
    Histograms = [];
    
    for i=1:num_feats
        fname = [sift_dir '/' fnames(i).name];
        load(fname, 'descriptors');
        distance = dist2(means, descriptors);
        [~, min_ind] = min(distance);
        [m, ~] = size(means);
        bincounts = histc(min_ind, 1:m);
        Histograms = [Histograms; bincounts];
    end
    
    save('Histograms.mat', 'Histograms');
end