function M = image_moyenne(cell_image)
    [num_image, ~] = size(cell_image);
    M = cell2mat(cell_image(1));
    for index = 2:num_image
       im = cell_image(index); 
       M = double(M + im); 
    end
    M = M/num_image;


end