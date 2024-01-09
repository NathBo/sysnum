nlin, ncol = 12, 8 #taille d'un chiffre
Nlin = 108 #longueur d'une ligne, en mégapixels


#écrire le design d'un chiffre, et le script donne le code OCaml de la liste des positions, à laquelle on peut rajouter un offset pour déplacer le chiffre

template = [
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0]
]

lst = [i*Nlin+j for i in range(nlin) for j in range(ncol) if template[i][j]]

print('[' + '; '.join(map(str, lst)) + ']')
