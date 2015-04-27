function [result_sum] = resize_example_1()
result_sum = 0;


addpath('./src/');

image = double(imread('./Images/cat.png'));
colorWeights = [1, -2, 1];
imageMask = zeros(size(image,1), size(image,2), 1);
result_image = intelligentResize(image, -20, -20, colorWeights, imageMask, 0);
imwrite(uint8(result_image),'./results/catResized.png');

image = double(imread('./Images/face.jpg'));
colorWeights = [1, -2, 1];
imageMask = zeros(size(image,1), size(image,2), 1);
result_image = intelligentResize(image, -20, 10, colorWeights, imageMask, 0);
imwrite(uint8(result_image), './results/faceResized.png');

image = double(imread('./Images/programmer.jpg'));
colorWeights = [1, 1, 1];
imageMask = zeros(size(image,1), size(image,2), 1);
result_image = intelligentResize(image, -25, -18  , colorWeights, imageMask, 100);
imwrite(uint8(result_image), './results/programmerCompress.png');

image = double(imread('./Images/programmer.jpg'));
colorWeights = [1, 1, 1];
imageMask = zeros(size(image,1), size(image,2), 1);
result_image = intelligentResize(image, 50, 37, colorWeights, imageMask, 100);
imwrite(uint8(result_image), './results/programmerStretch.png');  