print("label AFFICHAGE_JOURS")
print("movr rj rd")
for jour in range(1, 32):
    unite = jour % 10
    dizaine = jour // 10
    appel1 = "call display_" + str(dizaine)
    appel2 = "call display_" + str(unite)
    print("movr rk " + str(jour))
    print(appel1)
    print(appel2)


    