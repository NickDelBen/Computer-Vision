function [image] = removeSeamV(image, seam_in)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Removes the specified seam from the specified image.
%
% Input
%   image   - Image to remove seam from
%   seam_in - Seam to remove from the image
% Output
%   resumtImage = Image with seam removed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Get the size of the image
  imageRows    = size(image, 1);
  imageColumns = size(image, 2);

  for rowIterator = 1 : imageRows,
    image(rowIterator, seam_in(rowIterator):imageColumns, :) = circshift(image(rowIterator, seam_in(rowIterator):imageColumns, :), [0, -1]);
  end

  %remove the last column from the row
  image = image(:, 1:imageColumns - 1, :);
  
end