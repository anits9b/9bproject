function [finalImage] = skullstrip(Image)
%workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;

grayImage = Image;
grayImage = grayImage(3:end-3, 4:end-4);

% Threshold to create a binary image
binaryImage = grayImage > 20;
% Seal off the bottom of the head - make the last row white.
binaryImage(end,:) = true;
% Fill the image
binaryImage = imfill(binaryImage, 'holes');
% Erode away 15 layers of pixels.
se = strel('disk', 25, 0);
binaryImage = imerode(binaryImage, se);
% Mask the gray image
finalImage = grayImage; % Initialize.
finalImage(~binaryImage) = 0;
end