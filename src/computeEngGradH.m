function [greyScaleImage] = computeEngGradH(image_in)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Takes as an input a color image im and outputs a gray scale image eng, which is
% gradient based energy of the input image. The energy should be based on the
% horizontal component of image gradient.
%
% Input
%   image_in - Image to make greyscale
% Output
%   greyScaleImage - Converted greyscale image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % The mask to convert colour images to greyScaleImage
  greyscaleMask = [-1, 0, 1];

  greyScaleImage = abs(applyMask(image_in(:,:,1), greyscaleMask)) + abs(applyMask(image_in(:,:,2), greyscaleMask)) + abs(applyMask(image_in(:,:,3), greyscaleMask));
  
end