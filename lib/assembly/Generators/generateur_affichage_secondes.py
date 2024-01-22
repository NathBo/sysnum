print("label AFFICHAGE_SECONDE")
print("movr rj ra")
for sec in range(60):
    unite = sec % 10
    dizaine = sec // 10
    appel1 = "call display_" + str(dizaine)
    appel2 = "call display_" + str(unite)
    print("movr rk " + str(sec))
    print(appel1)
    print(appel2)


    