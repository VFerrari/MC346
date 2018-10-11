# Aula: Nada
# Exercícios:

# Cria uma lista com apenas os valores pares de outra lista
def evenList(list1): return [x for x in list1 if x % 2 == 0]

# Cria uma lista com os valores nas posições pares
def evenIndexList(list1):
    list2 = []
    for i in range(len(list1)):
        if (i % 2 == 0):
            list2.append(list1[i])
    return list2

# Cria um dicionario com a contagem de cada elemento numa lista
def amountList(list1):
    dic = {}
    for i in list1:
        if i in dic:
            dic[i] += 1
        else:
            dic[i] = 1
    return dic

# Descobre a chave com maior valor num dicionário
def maxValue(dic):
    vMax = float("-infinity")
    for i in dic:
        if (dic[i] > vMax):
            vMax = dic[i]
            kMax = i
    return kMax
    
# Encontra o elemento mais comum de uma lista
def mostCommon(list1): return maxValue(amountList(list1))
    
# Verifica se uma lista (list2) é sublista de outra (list1)
def sublist(list1,list2):
    leng = len(list2)
    j = 0
    for i in list1:
        if (i == list2[j]):
            j += 1
            if (j == leng):
                return True
        else:
            j = 0
            
    return False

# Verifica se dadas duas strings, o fim de uma (str1) é igual ao início da outra (str2)
def intersect(str1,str2):
    if (str1 == ""):
        return False
    inter = str2.startswith(str1)
    if (inter == False):
        return intersect(str1[1:],str2)
    elif(len(str1) < 4): 
        return False
    return True
    
