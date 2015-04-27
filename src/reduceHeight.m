function [removedSeam, resultImage, removedCost, resultMask] = reduceHeight(image_in, colorWeights_in, mask_in, maskWeight_in)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Removes one pixel height from the specified image
%
% Input
%   image_in        - The image to reduce the height of
%   colorWeights_in - Weights for the color based energy image
%   mask_in         - The mask to apply to the image
%   maskWeight_in   - Weight to apply to the importance mask
% Output
%   removedSeam - The seam that was removed in order to reduce the image height
%   resultImage - The image with one pixel width removed
%   removedCost - The cost of the removed seam
%   resultMask  - The resulting mask with a pixel removed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Transpose the image
  transposed_image = permute(image_in, [2,1,3]);

  % Transpose the mask
  transposed_mask = permute(mask_in, [2,1,3]);

  % Find the energy map for this image
  energyImage = computeEngGradH(transposed_image) + computeEngColor(transposed_image, colorWeights_in) + maskWeight_in * transposed_mask;

  % Extract the information required for finding a seam
  [seamMatrix, parentMatrix] = seamV_DP(energyImage);
  
  % Find the best seam to be removed
  [removedSeam, removedCost] = bestSeamV(seamMatrix, parentMatrix);

  % Remove the seam from the specified image
  resultImage = removeSeamV(transposed_image, removedSeam);

  % Remove seam from the mask
  resultMask = removeSeamV(transposed_mask, removedSeam);

  % Transpose the mask to undo the first transposition
  resultMask = permute(resultMask, [2,1,3]);

  % Transpose the image again to undo the first transposition
  resultImage = permute(resultImage, [2,1,3]);
end