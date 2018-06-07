addpath('./provided_code/');
frames_dir = './frames/';
sift_dir = './sift/';

train_size = 500;
Features = get_features(sift_dir, train_size);
 
[~,means,~] = kmeansML(1500,Features');
% save('kMeans.mat', 'means');
 
x = randperm(size(means,2),2);
words = means(:,x);
words = transpose(words);

f1 = figure;
f2 = figure;
figure(f1);

fnames_vector = randperm(num_feats,25);

for i = 1:25 %looking at 25 random images
	fname = [sift_dir '/' fnames(fnames_vector(i)).name];
	load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
	word_distance = dist2(words, descriptors);
	[~,min_index1] = min(word_distance(1,:));
	impath = [frames_dir '/' imname];
	im = imread(impath);
	patch = getPatchFromSIFTParameters(positions(min_index1,:),scales( min_index1), orients(min_index1), rgb2gray(im));
 
	subplot(5,5,i);
	imshow(patch);
	
end

figure(f2); 
fnames_vector = randperm(num_feats,25);
for i = 1:25 %looking at 25 random images
	fname = [sift_dir '/' fnames(fnames_vector(i)).name];
	load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
	word_distance = dist2(words, descriptors);
	[~,min_index2] = min(word_distance(2,:));
	impath = [frames_dir '/' imname];
	im = imread(impath);
	im = rgb2gray(im);
	patch = getPatchFromSIFTParameters(positions(min_index2,:),scales( min_index2), orients(min_index2), rgb2gray(im));
 
	subplot(5,5,i);
	imshow(patch);
	
end





