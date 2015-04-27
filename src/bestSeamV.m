function [resultSeam, resultCost] = bestSeamV(costMatrix_in, parentMatrix_in)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Finds the best seam from the specified image.
%
% Input
%   costMatrix_in   - Matrix containing costs for each location in the image
%   parentMatrix_in - Matrix containg column of best parent for each location in the image
% Output
%   bestSeam - Best seam to remove from the input image
%   seamCost - The cost of the best seam
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Extract the amount of rows in the image
  imageRows    = size(costMatrix_in, 1);

  % Create the matrix holding the result seam
  resultSeam = ones(1, imageRows);

  % Find the best cost path and the index at which it occurs
  [resultCost, resultSeam(imageRows)] = min(costMatrix_in(imageRows, :, :));

  % Check the rest of the rows to build the best edge
  for rowIterator = imageRows - 1 : -1 : 1,
    resultSeam(rowIterator) = parentMatrix_in(rowIterator + 1, resultSeam(rowIterator + 1));
  end
end