function [image] = addSeamV(image, seam_in)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adds the specified seam from the specified image.
%
% Input
%   image_in - Image to remove seam from
%   seam_in  - Seam to remove from the image
% Output
%   resumtImage = Image with seam removed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Get the size of the image
  imageRows    = size(image, 1);
  imageColumns = size(image, 2);

  % Insert an additional column for the new values
  image = [image, zeros(imageRows, 1, size(image, 3))];

  for rowIterator = 1 : imageRows,
    seamIndex = seam_in(rowIterator);
    % Shift all the values right, shifting in the newly added 0
    image(rowIterator, seamIndex:imageColumns + 1, :) = circshift(image(rowIterator, seamIndex:imageColumns + 1, :), [0, 1]);
    % Special case when pixel only has one neighbour to the right
    if seamIndex == 1,
      image(rowIterator, seamIndex, :) = image(rowIterator, seamIndex + 1, :);
    else,
      image(rowIterator, seamIndex, :) = (image(rowIterator, seamIndex - 1, :) .+ image(rowIterator, seamIndex + 1, :)) ./ 2;
    end
  end
    
end
