function cell_images = read_images(filepath)
    % fuction used to read all the bmp images in one folder
    % parameter : filepath : the path of the folder
    % return : a cell d'images pour toutes les images dans un même
    % répèretoire
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