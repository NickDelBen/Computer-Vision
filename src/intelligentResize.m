function [resultImage] = intelligentResize(image_in, verticalSeams_in, horizontalSeams_in, colorWeights_in, mask_in, maskWeight_in)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Resizes an image by the specified height and width.
%
% Input
%   image_in           - Image to be resized
%   verticalSeams_in   - Desired change iin vertical mesaure (+/-)
%   horizontalSeams_in - Desired change in horizontal measure (+/-)
%   colorWeights_in    - Weights for the color based energy image
%   mask_in            - The mask to apply to the image
%   maskWeight_in      - The weight to give the overlay mask
% Output
%   resultImage - The image with one pixel height added
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  resultImage = image_in;
  resultMask = mask_in;
  resultSeam = 0;
  resultCost = 0;

  totalCost = 0;

  % Get the magnitudes for the desired change
  verticalChange = abs(verticalSeams_in);
  horizontalChange = abs(horizontalSeams_in);

  % Find the number of iterations to resie the image
  numResizes = verticalChange;
  perIteration = floor(horizontalChange / verticalChange);
  numExtra = mod(horizontalChange, verticalChange);
  if horizontalChange < verticalChange,
    numResizes = horizontalChange;
    perIteration = floor(verticalChange / horizontalChange);
    numExtra = mod(verticalChange, horizontalChange);
  end

  if verticalChange < horizontalChange,
    for resizeIterations = 1 : numResizes,
      for mainIteration = 1 : perIteration,
        % Resize horizontal
        if horizontalSeams_in < 0,
          [resultSeam, resultImage, resultCost, resultMask] = reduceHeight(resultImage, colorWeights_in, resultMask, maskWeight_in);
        else,
          [resultSeam, resultImage, resultCost, resultMask] = increaseHeight(resultImage, colorWeights_in, resultMask, maskWeight_in);
        end
        totalCost = totalCost + resultCost;
      end
      if resizeIterations <= numExtra,
        % Resize horizontal
        if horizontalSeams_in < 0,
          [resultSeam, resultImage, resultCost, resultMask] = reduceHeight(resultImage, colorWeights_in, resultMask, maskWeight_in);
        else,
          [resultSeam, resultImage, resultCost, resultMask] = increaseHeight(resultImage, colorWeights_in, resultMask, maskWeight_in);
        end
        totalCost = totalCost + resultCost;
      end
      if verticalChange ~= 0,
        % Resize Vertical
        if verticalSeams_in < 0,
          [resultSeam, resultImage, resultCost, resultMask] = reduceWidth(resultImage, colorWeights_in, resultMask, maskWeight_in);
        else,
          [resultSeam, resultImage, resultCost, resultMask] = increaseWidth(resultImage, colorWeights_in, resultMask, maskWeight_in);
        end
        totalCost = totalCost + resultCost;
      end
    end
  else,
    for resizeIterations = 1 : numResizes,
      for mainIteration = 1 : perIteration,
        % Resize Vertical
        if verticalSeams_in < 0,
          [resultSeam, resultImage, resultCost, resultMask] = reduceWidth(resultImage, colorWeights_in, resultMask, maskWeight_in);
        else,
          [resultSeam, resultImage, resultCost, resultMask] = increaseWidth(resultImage, colorWeights_in, resultMask, maskWeight_in);
        end
        totalCost = totalCost + resultCost;
      end
      if resizeIterations <= numExtra,
        % Resize Vertical
        if verticalSeams_in < 0,
          [resultSeam, resultImage, resultCost, resultMask] = reduceWidth(resultImage, colorWeights_in, resultMask, maskWeight_in);
        else,
          [resultSeam, resultImage, resultCost, resultMask] = increaseWidth(resultImage, colorWeights_in, resultMask, maskWeight_in);
        end
        totalCost = totalCost + resultCost;
      end
      if horizontalChange ~= 0,
        % Resize Horizontal
        if horizontalSeams_in < 0,
          [resultSeam, resultImage, resultCost, resultMask] = reduceHeight(resultImage, colorWeights_in, resultMask, maskWeight_in);
        else,
          [resultSeam, resultImage, resultCost, resultMask] = increaseHeight(resultImage, colorWeights_in, resultMask, maskWeight_in);
        end
        totalCost = totalCost + resultCost;
      end
    end    
  end

  totalCost
end