function [disparityMatrix] = stereoCorrespondence(leftImage_in, rightImage_in, windowSize_in, maxDisparity_in)

  % Extract the dimensions of the images
  imageHeight = size(leftImage_in, 1);
  imageWidth  = size(leftImage_in, 2);

  % Find the offset for the window size
  windowOffset = floor(windowSize_in / 2);

  % The result matrix holding the best disparities for each location
  disparityMatrix = zeros(imageHeight, imageWidth);
  % The costs corresponding to the best disparities
  costMatrix = zeros(imageHeight, imageWidth) + realmax;

  % Try each disparity
  for disparityIterator = 0 : maxDisparity_in,
    % Find the integral image corresponding to this result
    image_difference = absoluteDifference(leftImage_in, rightImage_in, disparityIterator);
    image_integral = integralImage(image_difference);
    % Pad with 1 row and column of zeroes on top and left of the image
    image_integral = [zeros(1, imageWidth + 1); [zeros(imageHeight, 1), image_integral]];
    % Hit each pixel in the images
    for rowIterator = 1 : imageHeight,
      for columnIterator = 1 : imageWidth,
        % Calculate the boundries for the integral box sum
        lowerColumn = max(columnIterator - windowOffset, 1);
        lowerRow    = max(rowIterator - windowOffset, 1);
        upperColumn = min(columnIterator + windowOffset + 1, imageWidth + 1);
        upperRow    = min(rowIterator + windowOffset + 1, imageHeight + 1);
        % Track the cost of the best window for this pixel
        windowCost = image_integral(lowerRow, lowerColumn) + image_integral(upperRow, upperColumn) - image_integral(lowerRow, upperColumn) - image_integral(upperRow, lowerColumn);
        % Check if this is the best disparity for this pixel
        if windowCost < costMatrix(rowIterator, columnIterator),
          % Store the best disparity for this pixel
          disparityMatrix(rowIterator, columnIterator) = disparityIterator;
          % Store the best window cost for this pixel
          costMatrix(rowIterator, columnIterator) = windowCost;
        end
      end
    end
  end


end