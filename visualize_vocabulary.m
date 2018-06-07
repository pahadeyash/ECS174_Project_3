addpath('./provided_code/');
framesdir = './frames/';
siftdir = './sift/';
 
fnames = dir([siftdir '/*.mat']);
 
fnames_vector = randperm(6612, 500); %6612 is the number of images in fnames and 500 distinct images are randomly picked
 
feature_matrix = [];
 
for i = 1:500
	fname = [siftdir '/' fnames(fnames_vector(i)).name];
	load(fname, 'descriptors');
	feature_matrix= [feature_matrix; descriptors];
end
 
[membership,means,rms] = kmeansML(1500,transpose(feature_matrix));
save('kMeans.mat', 'means');
 
x = randperm(size(means,2),2);
words = means(:,x);
words = transpose(words);

Word_1 = figure;
Word_2 = figure;
figure(Word_1);

fnames_vector_2 = randperm(6612,25);

for i = 1:25 %looking at 25 random images
	fname = [siftdir '/' fnames(fnames_vector_2(i)).name];
	load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
	word_distance = dist2(words, descriptors);
	[~,min_index1] = min(word_distance(1,:));
	%[~,min_index2] = min(word_distance(2,:));
	impath = [framesdir '/' imname];
	im = imread(impath);
	im = rgb2gray(im);
	patch_1 = getPatchFromSIFTParameters(positions(min_index1,:),scales( min_index1), orients(min_index1), im);
	%patch_2 = getPatchFromSIFTParameters(positions(min_index2,:),scales( min_index2), orients(min_index2), im);
 
	subplot(5,5,i);
	imshow(patch_1);
	
% 	subplot(10,5,i+25);
% 	imshow(patch_2);
end

figure(Word_2); 
fnames_vector_3 = randperm(6612,25);
for i = 1:25 %looking at 25 random images
	fname = [siftdir '/' fnames(fnames_vector_2(i)).name];
	load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
	word_distance = dist2(words, descriptors);
	%[~,min_index1] = min(word_distance(1,:));
	[~,min_index2] = min(word_distance(2,:));
	impath = [framesdir '/' imname];
	im = imread(impath);
	im = rgb2gray(im);
	%patch_1 = getPatchFromSIFTParameters(positions(min_index1,:),scales( min_index1), orients(min_index1), im);
	patch_2 = getPatchFromSIFTParameters(positions(min_index2,:),scales( min_index2), orients(min_index2), im);
 
	subplot(5,5,i);
	imshow(patch_2);
	
end





