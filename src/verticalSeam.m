function [seamMatrix, parentMatrix] = verticalSeam(energyImage_in, seamParents_in)

  % Find the offset tp search parents for on the upper left and upper right
  parentOffset = floor(seamParents_in / 2);

  % Get the size of the image
  imageRows    = size(energyImage_in, 1);
  imageColumns = size(energyImage_in, 2);

  % Create the blank result matricies
  seamMatrix   = zeros(imageRows, imageColumns);
  parentMatrix = zeros(imageRows, imageColumns);

  % The first row of the seam matrix is the first row of the input energy matrix
  seamMatrix(1,:) = energyImage_in(1,:);

  % Hit each row
  for rowIterator = 2 : imageRows,
    % Hit each cell in each row
    for columnIterator = 1 : imageColumns,
      % Find the lower and upper offsets to scan for the best parent
      lowerOffset = columnIterator - parentOffset;
      upperOffset = columnIterator + parentOffset;
      % Ensure the first parent to check is in bounds
      if lowerOffset < 1,
        lowerOffset = 1;
      end
      % Ensure the last parent to check is in bounds
      if upperOffset > imageColumns,
        upperOffset = imageColumns;
      end
       
      % Find the best parent and its value from the valid parents
      [parentValue, parentIndex] = min(seamMatrix(rowIterator - 1, lowerOffset:upperOffset, :));

      % Store the best parent in the parent matrix
      parentMatrix(rowIterator, columnIterator) = lowerOffset + parentIndex - 1;
      % Store the best path cost in the seam trace matrix
      seamMatrix(rowIterator, columnIterator) = energyImage_in(rowIterator, columnIterator) + parentValue;
    end
  end