function [newMask] = expandMask(mask_in, seam_in)

  % Get the size of the mask
  maskRows    = size(mask_in, 1);
  maskColumns = size(mask_in, 2);

  % Insert an additional column for the new values
  newMask = [mask_in, zeros(maskRows, 1, size(mask_in, 3))];

  % Hit each row once
  for rowIterator = 1 : maskRows,
    seamIndex = seam_in(rowIterator);
    % Shift all the values right, shifting in the newly added 0
    newMask(rowIterator, seamIndex:maskColumns + 1, :) = circshift(newMask(rowIterator, seamIndex:maskColumns + 1, :), [0, 1]);

    % Mask the old pixel so it is not modified in future iterations
    if seamIndex > 1,
      newMask(rowIterator, seamIndex - 1, :) = newMask(rowIterator, seamIndex - 1, :) + 1;
    end
    newMask(rowIterator, seamIndex, :) = newMask(rowIterator, seamIndex - 1, :) + 1;
    newMask(rowIterator, seamIndex + 1, :) = newMask(rowIterator, seamIndex - 1, :) + 1;
  end
end