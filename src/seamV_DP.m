function [seamMatrix, parentMatrix] = seamV_DP(energyImage_in)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adds the specified seam from the specified image.
%
% Input
%   energyImage_in - Image to construct seams from
% Output
%   parentMatrix - The best node parents
%   seamMatrix   - The cost matrix for the seams
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Find the best vertical seam checking the north 3 parents
  [seamMatrix, parentMatrix] = verticalSeam(energyImage_in, 3);
end
