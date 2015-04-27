function [result] = stereo_correspondance_example()

  addpath('./src/');

  window_sizes = [3,7,15];
  maximum_disparity = 16;

  left_image_src = './Images/Stereo/tsukuba-left.pgm';
  right_image_src = './Images/Stereo/tsukuba-right.pgm';
  image_name = 'tsukuba';
  testCorrespondence(left_image_src, right_image_src, image_name, window_sizes, maximum_disparity);
  edgeMaps(left_image_src, right_image_src, image_name);

  left_image_src = './Images/Stereo/teddy-left.pgm';
  right_image_src = './Images/Stereo/teddy-right.pgm';
  image_name = 'teddy';
  testCorrespondence(left_image_src, right_image_src, image_name, window_sizes, maximum_disparity);
  edgeMaps(left_image_src, right_image_src, image_name);

  left_image_src = './Images/Stereo/venus-left.pgm';
  right_image_src = './Images/Stereo/venus-right.pgm';
  image_name = 'venus';
  testCorrespondence(left_image_src, right_image_src, image_name, window_sizes, maximum_disparity);
  edgeMaps(left_image_src, right_image_src, image_name);

  
  result = 0;
end


function [result] = testCorrespondence(left_image_src, right_image_src, image_name, window_sizes, maximum_disparity)

  left_image = double(imread(left_image_src));
  right_image = double(imread(right_image_src));

  for windowIterator = 1 : size(window_sizes, 2),
    result = stereoCorrespondence(left_image, right_image, window_sizes(1, windowIterator), maximum_disparity);
    imwrite(uint8(stretch(result)), sprintf('./results/stereo/%s_%d.png', image_name, window_sizes(1, windowIterator)));
  end

  result = 0;
end

function [left_edges, right_edges] = edgeMaps(left_image_src, right_image_src, image_name)
  
  left_image = double(imread(left_image_src));
  right_image = double(imread(right_image_src));

  left_edges = edges(left_image, 2, 10);
  right_edges = edges(right_image, 2, 10);

  imwrite(uint8(stretch(left_edges)), sprintf('./results/stereo/%s-left_edges.png', image_name));
  imwrite(uint8(stretch(right_edges)), sprintf('./results/stereo/%s-right_edges.png', image_name));

end

function [result] = testCorrespondence_verbose(left_image_src, right_image_src, image_name, window_sizes, maximum_disparity)

  left_image = double(imread(left_image_src));
  right_image = double(imread(right_image_src));

  result = zeros(size(left_image, 1), size(left_image, 2), size(window_sizes, 2));
  for windowIterator = 1 : size(window_sizes, 2),
    result(:, :, windowIterator) = stereoCorrespondence(left_image, right_image, window_sizes(1, windowIterator), maximum_disparity);
    imwrite(uint8(stretch(result(:, :, windowIterator))), sprintf('./results/stereo/%s_%d.png', image_name, window_sizes(1, windowIterator)));
  end
  imwrite(uint8(stretch(sum(result, 3))), sprintf('./results/stereo/%s_sum.png', image_name));
  imwrite(uint8(stretch(mean(result, 3))), sprintf('./results/stereo/%s_mean.png', image_name));
  imwrite(uint8(stretch(mode(result, 3))), sprintf('./results/stereo/%s_mode.png', image_name));

  result = 0;
end