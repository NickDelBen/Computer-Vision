function [removedSeam, resultImage, removedCost, resultMask] = reduceWidth(image_in, colorWeights_in, mask_in, maskWeight_in)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Removes one pixel width from the specified image
%
% Input
%   image_in        - Image to reduce the width of
%   colorWeights_in - Weights for the color based energy image
%   mask_in         - Mask to apply to the image showing importance of pixels
%   maskWeight_in   - Weight to apply to the importance mask
% Output
%   removedSeam - Seam that was removed in order to reduce the image width
%   resultImage - Image with one pixel width removed
%   removedCost - Cost of the removed seam
%   resultMask  - Resulting mask with a pixel removed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Find the energy map for this image
  energyImage = computeEngGradH(image_in) + computeEngColor(image_in, colorWeights_in) + maskWeight_in .* mask_in;

  % Extract the information required for finding a seam
  [seamMatrix, parentMatrix] = seamV_DP(energyImage);
  
  % Find the best seam to be removed
  [removedSeam, removedCost] = bestSeamV(seamMatrix, parentMatrix);

  % Remove the seam from the mask
  resultMask = removeSeamV(mask_in, removedSeam);

  % Remove the seam from the specified image
  resultImage = removeSeamV(image_in, removedSeam);
end