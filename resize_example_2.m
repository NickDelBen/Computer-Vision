function [resultImage] = resize_example_2()
  resultImage = 0;
  
  addpath('./src/');

  image = double(imread('./Images/cat.png'));
  colorWeights = [1, -2, 1];
  imageMask = zeros(size(image,1), size(image,2), 1);
  resultImage = intelligentResize(image, -25, 1, colorWeights, imageMask, 300);
  imwrite(uint8(resultImage),'catResized_custom.png');


end