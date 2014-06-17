""" Using "else" in "for" loops """

names = ['bruno','marcio','ronaldo','sergio','ted','antonio','henrique']
#names = ['bruno','marcio','ronaldo','sergio','ted','antonio','henrique', 'pedro']

for name in names:
    if name == "pedro":
        print 'Name "Pedro" was found'
        break

else:
    print 'Only will be printed if the loop doesnt breaks'
