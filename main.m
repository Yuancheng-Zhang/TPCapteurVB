% images_580 = read_images("images\580\");
% M_580 = image_moyenne(images_580);

% read les fichiers dat et calculer la moyenne pour chaque longeur d'onde en micro amp¨¨re
vecteur_moyenne_miuA = zeros(1,41);
compteur = 1;
for index_fichier  = 400:10:800
    txt_file = importdata(strcat('Capteur_ReponseSpectral\',int2str(index_fichier),'.dat'));
    data = txt_file.data;
    % calculer la moyenne de la deuxi¨¨me colonne du data
    vecteur_moyenne_miuA(compteur) = mean(data(:,2));
    compteur = compteur + 1;
end

% read la sensibilit¨¦ du capteur en A/W
txt_sensibilite_capteur = importdata("Sensidetec_anc.txt").data();
