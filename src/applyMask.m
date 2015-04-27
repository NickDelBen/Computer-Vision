function [maskedImage] = applyMask(image_in, mask_in)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Takes as an input gray scale image and a mask and outputs the result of correlating
% image im with mask M. Specifically, The result image is = mask ⊗ origional image.
%
% Input
%   image_in - Image to apply mask to
%   mask_in  - MAsk to apply to the specified image
% Output
%   maskedImage - Image with mask applied to it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Find dimensions of the input image
  imageHeight = size(image_in, 1);
  imageWidth  = size(image_in, 2);

  % Find dimensions of the input mask
  maskHeight = size(mask_in, 1) - 1;
  maskWidth  = size(mask_in, 2) - 1;

  % Find the offset for the mask sizes
  maskHeightOffset = maskHeight / 2;
  maskWidthOffset  = maskWidth / 2;

  % Pad the matrix
  image_in = matrixPad(image_in, maskHeightOffset, maskWidthOffset, 0);

  % Create the destination image
  maskedImage = zeros(imageHeight, imageWidth);

  % Iterate over each pixel
  for heightIterator = 1 : imageHeight,
    for widthIterator = 1: imageWidth,
      maskedImage(heightIterator, widthIterator) = sum(sum(mask_in .* image_in(heightIterator:heightIterator + maskHeight, widthIterator:widthIterator + maskWidth)));
    end
  end