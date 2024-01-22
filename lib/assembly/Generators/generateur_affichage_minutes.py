print("label AFFICHAGE_MINUTES")
print("movr rj rb")
for mnt in range(60):
    unite = mnt % 10
    dizaine = mnt // 10
    appel1 = "call display_" + str(dizaine)
    appel2 = "call display_" + str(unite)
    print("movr rk " + str(mnt))
    print(appel1)
    print(appel2)


    