function [addedSeam, resultImage, addedCost, resultMask] = increaseHeight(image_in, colorWeights_in, mask_in, maskWeight_in)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adds one pixel height to the specified image
%
% Input
%   image_in        - Image to increase the height of
%   colorWeights_in - Weights for the color based energy image
%   mask_in         - Mask to apply to the image
%   maskWeight_in   - Weight to apply to the importance mask
% Output
%   addedSeam   - The seam that was added in order to increase the image height
%   resultImage - The image with one pixel height added
%   addedCost   - The cost of the added seam
%   resultMask  - The resulting mask with a pixel added
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Transpose the image
  transposed_image = permute(image_in, [2,1,3]);

  % Transpose the mask
  transposed_mask = permute(mask_in, [2,1,3]);

  % Find the energy map for this image
  energyImage = computeEngGradH(transposed_image) + computeEngColor(transposed_image, colorWeights_in) + maskWeight_in * transposed_mask;

  % Extract the information required for finding a seam
  [seamMatrix, parentMatrix] = seamV_DP(energyImage);
  
  % Find the best seam to be added
  [addedSeam, addedCost] = bestSeamV(seamMatrix, parentMatrix);

  % Add the seam to the specified image
  resultImage = addSeamV(transposed_image, addedSeam);

  % Add the seam to the mask
  resultMask = expandMask(transposed_mask, addedSeam);

  % Transpose the mask to undo the first transposition
  resultMask = permute(resultMask, [2,1,3]);

  % Transpose the image again to undo the first transposition
  resultImage = permute(resultImage, [2,1,3]);
end