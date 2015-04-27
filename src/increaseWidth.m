function [addedSeam, resultImage, addedCost, resultMask] = increaseWidth(image_in, colorWeights_in, mask_in, maskWeight_in)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adds one pixel width to the specified image
%
% Input
%   image_in        - The image to increase the width of
%   colorWeights_in - Weights for the color based energy image
%   mask_in         - The mask to apply to the image
%   maskWeight_in   - Weight to apply to the importance mask
% Output
%   removedSeam - The seam that was added in order to increase the image width
%   resultImage - The image with one pixel width added
%   removedCost - The cost of the added seam
%   resultMask  - The resulting mask with a pixel added
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Find the energy map for this image
  energyImage = computeEngGradH(image_in) + computeEngColor(image_in, colorWeights_in) + maskWeight_in .* mask_in;

  % Extract the information required for finding a seam
  [seamMatrix, parentMatrix] = seamV_DP(energyImage);
  
  % Find the best seam to be added
  [addedSeam, addedCost] = bestSeamV(seamMatrix, parentMatrix);

  % Add the seam to the mask
  resultMask = expandMask(mask_in, addedSeam);

  % Add the seam to the specified image
  resultImage = addSeamV(image_in, addedSeam);
end