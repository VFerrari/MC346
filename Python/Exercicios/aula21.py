# Teste 13:
# Dado uma string de talvez múltiplas linhas, imprime a proporção em que
# cada um dos dígitos 1 a 9 é o primeiro dígito de um número que aparece.
def benford(string):
    digDict = {}
    count = 0
    
    for i in range(1,10):
        digDict[i] = 0
    
    l= string.split()
    for i in l:
        if i[0].isnumeric():
            count+=1
            digDict[int(i[0])]+=1
    if count == 0:
        count = 1
    
    print("Proporções:")
    for i in digDict:
        print("{}: {}".format(i,digDict[i]/count))
