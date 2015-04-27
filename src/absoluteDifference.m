function [resultImage] = absoluteDifference(leftImage_in, rightImage_in, disparity)

  % Get the image dimensions
  imageHeight = size(leftImage_in, 1);
  imageWidth  = size(rightImage_in, 2);

  % Chop the beginning columns of the left image to account for disparity
  leftImage = leftImage_in(:, 1 + disparity:imageWidth);

  % Chop the end columns of the right image to account for disparity
  rightImage = rightImage_in(:, 1:imageWidth - disparity);

  % Compute the absolute difference image
  resultImage = [zeros(imageHeight, disparity), abs([leftImage - rightImage])];

end