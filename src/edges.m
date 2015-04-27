function [edgeMap] = edges(image_in, edgeDistance_in, differenceThreshold_in)
  edgeMap = csEdges(image_in, edgeDistance_in, differenceThreshold_in);
end

% Math approach to naive edge detection.
function [edgeMap] = matEdges(image_in, edgeDistance_in, differenceThreshold_in)  
  % Extract the dimensions from the image
  imageHeight = size(image_in, 1);
  imageWidth  = size(image_in, 2);

  % Check each pixels diffrence horizontally
  horizontalDifference = abs(image_in - [image_in(:, 1 + edgeDistance_in:imageWidth), zeros(imageHeight, edgeDistance_in)]);
  % Check each pixels difference vertically
  verticalDifference = abs(image_in - [image_in(1 + edgeDistance_in:imageHeight, :); zeros(edgeDistance_in, imageWidth)]);
  % Calculate the offsetbetween the two differences
  offsetDifference = horizontalDifference + verticalDifference - (2 * differenceThreshold_in);
  edgeMap = sign(max(offsetDifference, 0));
end

% Computer science approach to naive edge detection (iterative)
function [edgeMap] = csEdges(image_in, edgeDistance_in, differenceThreshold_in)
  % Extract the dimensions from the image
  imageHeight = size(image_in, 1);
  imageWidth  = size(image_in, 2);

  % Ther esult matrix
  edgeMap = zeros(imageHeight, imageWidth);

  % Check for horizontal edge markers
  for rowIterator = 1 : imageHeight,
    for columnIterator = 1 : imageWidth - edgeDistance_in,
      % Find the horizontal difference
      pixelDifference = abs(image_in(rowIterator, columnIterator) - image_in(rowIterator, columnIterator + edgeDistance_in));
      % Check if the horizontal difference breaks the threshold
      if pixelDifference >= differenceThreshold_in,
        edgeMap(rowIterator, columnIterator) = 1;
      end
    end
  end 

  % Check for vertical edge markers
  for columnIterator = 1 : imageWidth,
    for rowIterator = 1 : imageHeight - edgeDistance_in,
      % Find the horizontal difference
      pixelDifference = abs(image_in(rowIterator, columnIterator) - image_in(rowIterator + edgeDistance_in, columnIterator));
      % Check if the horizontal difference breaks the threshold
      if pixelDifference >= differenceThreshold_in,
        edgeMap(rowIterator, columnIterator) = 1;
      end
    end
  end
end