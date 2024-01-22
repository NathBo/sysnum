print("label AFFICHAGE_SECONDE")
for sec in range(60):
    unite = sec % 10
    dizaine = sec // 10
    print("movc rk " + str(sec))
    appel1 = "callc ra rk display_" + str(dizaine)
    appel2 = "callc ra rk display_" + str(unite)
    print("movc rm 106")
    print(appel1)
    print("movc rm 107")
    print(appel2)

print("")

print("label AFFICHAGE_MINUTES")
for mnt in range(60):
    unite = mnt % 10
    dizaine = mnt // 10
    print("movc rk " + str(mnt))
    appel1 = "callc rb rk display_" + str(dizaine)
    appel2 = "callc rb rk display_" + str(unite)
    print("movc rm 104")
    print(appel1)
    print("movc rm 105")
    print(appel2)

print("")

print("label AFFICHAGE_HEURES")
for hr in range(24):
    unite = hr % 10
    dizaine = hr // 10
    print("movc rk " + str(hr))
    appel1 = "callc rc rk display_" + str(dizaine)
    appel2 = "callc rc rk display_" + str(unite)
    print("movc rm 101")
    print(appel1)
    print("movc rm 100")
    print(appel2)

print("")

print("label AFFICHAGE_JOURS")
print("movr rj rd")
for jour in range(1, 32):
    unite = jour % 10
    dizaine = jour // 10
    print("movc rk " + str(jour))
    appel1 = "callc rd rk display_" + str(dizaine)
    appel2 = "callc rd rk display_" + str(unite)
    print("movc rm 351")
    print(appel1)
    print("movc rm 350")
    print(appel2)


    