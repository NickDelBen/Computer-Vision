function [resultImage] = integralImage(image_in)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computes and returns the integral image for a specified image.
%
% Input
%   image_in - Image to compute integral image for
% Output
%   resultImage - Computed integral image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Extract the image dimensions
  imageHeight = size(image_in, 1);
  imageWidth  = size(image_in, 2);

  % Initially the result image is empty
  reultImage = zeros(imageHeight, imageWidth);

  % The first row and first column are a special case
  resultImage(1, 1, :) = image_in(1, 1, :);
  for rowIterator = 2 : imageHeight,
    resultImage(rowIterator, 1) = image_in(rowIterator, 1) + resultImage(rowIterator - 1, 1);
  end
  for columnIterator = 2 : imageWidth,
    resultImage(1, columnIterator) = image_in(1, columnIterator) + resultImage(1, columnIterator - 1);
  end

  % Compute the remainder of the cells
  for rowIterator = 2 : imageHeight,
    for columnIterator = 2 : imageWidth,
      resultImage(rowIterator, columnIterator) = image_in(rowIterator, columnIterator) + resultImage(rowIterator, columnIterator - 1) + resultImage(rowIterator - 1, columnIterator) - resultImage(rowIterator - 1, columnIterator - 1);
    end
  end

end