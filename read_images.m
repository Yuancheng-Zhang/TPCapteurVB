function cell_images = read_images(filepath)
    
    img_path_list = dir(strcat(filepath,'*bmp'));
    img_num = length(img_path_list);
    
    cell_images = cell(1, img_num);
    if img_num>0
       for index = 1:img_num
           image_name = img_path_list(index).name;
           image = imread(strcat(filepath,image_name));
           cell_images{index} = image;
       end
    end

end