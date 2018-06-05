addpath('./provided_code/');

load('twoFrameData.mat');
oninds = selectRegion(im1, positions1);
selected_region = descriptors1(oninds, :);

euDistance = dist2(selected_region, descriptors2); %Euclidian distance between the selected region and descriptors 2

[row, ~] = size(euDistance);
[sift_desc, ~] = size(descriptors2); %sift descriptors to displays
sift_desc_array = zeros(sift_desc, 1);

for i = 1:row
    if (min(euDistance(i,:)) < 0.25)
        [~,sift_desc_array(i)] = min(euDistance(i,:));
    end
end

sift_desc_array = sift_desc_array(sift_desc_array > 0);
imshow(im2);
displaySIFTPatches(positions2(sift_desc_array,:), scales2(sift_desc_array), orients2(sift_desc_array), im2);

