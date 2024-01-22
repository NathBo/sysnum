print("label AFFICHAGE_HEURES")
print("movr rj rc")
for hr in range(24):
    unite = hr % 10
    dizaine = hr // 10
    appel1 = "call display_" + str(dizaine)
    appel2 = "call display_" + str(unite)
    print("movr rk " + str(hr))
    print(appel1)
    print(appel2)


    