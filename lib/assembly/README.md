Le code assembleur doit être composé exactement d'une instruction par ligne, sans ligne vide (y compris à la fin du fichier), notament parce que l'instruction jump prend en argument une ligne de notre fichier et que ça permet de simplifier lorsqu'on code. Pour les commentaires, seuls les commentaire sur une ligne sont autorisé, on peut les introduire avec le caractère //.

Le fichier clock-version-sans-les-mois.txt contient une version de la clock sans les mois, c'est à dire avec seulement l'affichage du nombre de jours modulo 365 (ou 366). Fichier à supprimer à long terme

Le fichier clock-version-avec-les-mois.txt contient une version de la clock avec la gestion des mois. C'est un fichier avec des commentaires pour pouvoir s'y retrouver, et sur lequel les lignes des différentes instructions jump ne sont pas spécifiées. Ce fichier ne compile donc pas. La version qui compile, c'est à dire avec seulement des commentaires sur une ligne et avec les lignes renseignées dans les jump est écrite dans code\_assembly.txt

Toutes les conventions concernant l'utilisation des registres et de la RAM sont indiquées au début du fichier clock-version-avec-les-mois.txt

