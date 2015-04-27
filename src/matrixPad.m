function [paddedMatrix] = matrixPad(matrix_in, heightPad, widthPad, padValue)

  % Extract the matrix dimensions
  matrixHeight = size(matrix_in, 1);
  matrixWidth  = size(matrix_in, 2);

  if padValue == 0,
    paddedMatrix = [zeros(matrixHeight + 2 * heightPad, widthPad), [zeros(heightPad, matrixWidth); matrix_in; zeros(heightPad, matrixWidth)], zeros(matrixHeight + 2 * heightPad, widthPad)];
  else,
    paddedMatrix = [zeros(matrixHeight + 2 * heightPad, widthPad) + padValue, [zeros(heightPad, matrixWidth) + padValue; matrix_in; zeros(heightPad, matrixWidth) + padValue], zeros(matrixHeight + 2 * heightPad, widthPad) + padValue];
  end  

end