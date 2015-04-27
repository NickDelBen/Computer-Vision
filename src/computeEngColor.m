function [weightedEnergyImage] = computeEngColor(image_in, weights_in)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% that takes as an input a color image im, a vector w of size 3 and outputs 
% color-based energy image eng.

% Input
%   image_in   - Image to make greyscale
%   weights_in - Weights of the RGB componants of imput image
% Output
%   weightedEnergyImage - Resulting image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  weightedEnergyImage = weights_in(1) * image_in(:,:,1) + weights_in(2) * image_in(:,:,2) + weights_in(3) * image_in(:,:,3);

end