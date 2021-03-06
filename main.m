% images_580 = read_images("images\580\");
% M_580 = image_moyenne(images_580);

% charger les fichiers dat et calculer la moyenne pour chaque longueur
% d'onde en micro amp��re(10e-6 amp��re)

% vecteur pour sauvegarder le courant mesur�� par le d��tecteur calibr�� pour chaque longueur d'onde
vecteur_moyenne_miuA = zeros(41,1); 
compteur = 1;
for index_fichier  = 400:10:800
    txt_file = importdata(strcat('Data_Capteur_ReponseSpectral\',int2str(index_fichier),'.dat'));
    data = txt_file.data;
    % calculer la moyenne de la deuxi��me colonne du data
    vecteur_moyenne_miuA(compteur) = mean(data(:,2));
    compteur = compteur + 1;
end
save vecteur_moyenne_miuA_detecteur_calibre.txt -ascii vecteur_moyenne_miuA

% charger la sensibilit�� du d��tecteur calibr�� en A/W
% on prend juste les 41 premi��res lignes et la deuxi��mes colonnes
% qui nous donne la valeur en Amp��re par watt
txt_sensibilite_capteur = importdata("Sensidetec_anc.txt").data(1:41,2);
txt_sensibilite_capteur = txt_sensibilite_capteur * 1e6; % transmettre en micro amp��re par watt

% calculer la puissance lumineuse en fonction de la longueur d'onde de 400nm �� 800nm en watt
vecteur_puissance_lumineuse = vecteur_moyenne_miuA ./ txt_sensibilite_capteur;

% tracer en fonction de la longeur d'onde la puissance lumineuse �� la
% sortie de la sph��re
vecteur_longugeur_onde = 400:10:800;
figure(1)
plot(vecteur_longugeur_onde, vecteur_puissance_lumineuse, 'rx')
grid on
xlabel("longueur d'onde (nm)")
ylabel("la puissance lumineuse (watt)")
title("La puissance lumineuse en fonction de la longueur d'onde")

% calculer l'image moyenne pour chaque longueur d'onde et les sauvegarder
% dans un cell
cell_images_moyenne = cell(1, 41); % le nombre des images est 41
for index_image_moyenne = 400:10:800
    % prendre toutes les images d'un r��peretoire de l'longueur d'onde dans un cell
    images_path =  strcat("Data_images\", int2str(index_image_moyenne),"\");
    % read all the images dans le r��peretoire et les sauvegarder dans un
    % cell
    cell_images = read_images(images_path); 
    % calculer la moyenne d'images correpondant �� chaque longueur d'onde
    M_images = image_moyenne(cell_images);
    index_cell_images = int8((index_image_moyenne - 400)/10 + 1);
    % sauvegarder les images moyennes dans un cell
    cell_images_moyenne{index_cell_images} = M_images;
end

% calculer la valeur moyenne num��rique dans un r��gion de chaque 
% image correspondant �� chaque longeur d'onde
valeur_numerique_matrix = zeros(41,1);
for index_value = 1:41
    image = cell2mat(cell_images_moyenne(index_value));
    % concentrer sur une r��gion centrale d'image
    image_region = image(512-74:512+75, 640-74:640+75);
    % calculer la valeur num��rique moyenne
    valeur_numerique_moyenne = mean(image_region(:));
    valeur_numerique_matrix(index_value) = valeur_numerique_moyenne;
end

% calculer la r��ponse spectrale du cam��ra en divisant la valeur num��rique
% par la puissance lumineuse
valeur_reponse_spectrale = valeur_numerique_matrix ./ vecteur_puissance_lumineuse;
figure(2)
plot(vecteur_longugeur_onde, valeur_reponse_spectrale,'rx')
grid on 
title("la r��ponse spectrale de la cam��ra")
xlabel("la longueur d'onde (nm)")
ylabel("la r��ponse en Valeur num��rique par Watt")


