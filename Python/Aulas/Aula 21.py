import numpy as np
import time
import sys

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

# Aula
def aula():
    
    # Parte 1: Intro a Numpy
    def parte1(): 
          
        # Tamanhos
        print("Comparando tamanhos de array e lista de 1000 elementos")
        l = range(1000)
        print("Tamanho de lista:",sys.getsizeof(5)*len(l))
        a = np.arange(1000)
        print("Tamanho do array:",a.size*a.itemsize,end="\n\n")
        
        # Tempo
        SIZE = 1000000

        l = range(SIZE)
        l2 = range(SIZE)
        a = np.arange(SIZE)
        a2 = np.arange(SIZE)
        
        print("Comparando tempo para somar listas e arrays de tamanho arbitrário")
        
        start = time.time()
        result = [(x+y) for x,y in zip(l,l2)]
        print("Lista demorou:", (time.time()-start)*1000)
        
        start = time.time()
        result = a + a2
        print("Array demorou:", (time.time()-start)*1000)
    
    # Parte 2: Operações básicas em array.
    def parte2():
        print("Características de um array")
        a = np.array([[1,2],[3,4],[5,6]])
        print("Array:\n",a)
        print("Número de dimensões:",a.ndim)
        print("Tamanho:",a.size)
        print("Tipo de dado:",a.dtype)
        print("Linhas e colunas:",a.shape,end="\n\n")
        
        b = np.array([[1,2],[3,4],[5,6]], dtype=complex)
        print("Array complexo:\n",b,end="\n\n")
        
        print("Array de zeros:\n",np.zeros((3,4)), end="\n\n")
        # Array de 1s: mesma coisa, mas com np.ones
        
        b = np.linspace(1,5,10)
        print("Array com N elementos espaçados linearmente entre A e B:\n",b,end="\n\n")
        
        # Essas funções não alteram o array original
        print("Mudar a forma do array:\n",a.reshape(2,3),end="\n\n")
        
        print("Linearizar o array:",a.ravel(),end="\n\n")
        
        # Funções Matemáticas
        print("Mínimo:",a.min())
        print("Máximo:",a.max())
        print("Soma:",a.sum())
        print("Soma das colunas:",a.sum(axis=0))
        print("Soma das linhas:",a.sum(axis=1))
        print("Desvio padrão:", np.std(a))
        print("Raiz quadrada:\n",np.sqrt(a), end="\n\n")
        
        # Operações entre arrays
        print("Operações entre arrays")
        a = np.array([[1,2],[3,4]])
        b = np.array([[5,6],[7,8]])
        print("Array A:\n",a)
        print("Array B:\n",b,end="\n\n")
        
        print("A+B:\n",a+b)
        print("B-A:\n",b-a)
        print("A*B (elemento a elemento):\n",a*b)
        print("A/B:\n",a/b)
        print("Produto matricial:\n",a.dot(b))

    # Parte 3: Indexing, slicing, iterating, stacking
    def parte3():
        
        # Slicing linear: Igual listas
        a=np.array([[6,7,8],[1,2,3],[9,3,2]])
        print("Array:\n",a)
        
        print("\nSlicing & indexing")
        print("Elemento [1,2]:", a[1,2])
        print("Terceiro elemento das duas primeiras linhas:", a[0:2,2])
        print("Última linha:",a[-1])
        print("Dois primeiros elementos da última linha:", a[-1,0:2])
        print("Segunda e terceira colunas:\n",a[:,1:3])
        print()
        
        # Iterar por um array
        # Não usar for! Usar funções do numpy
        print("Iterar por um array")
        print("Imprimindo ao iterar:")
        for row in a:
            print(row)
        print("Imprimindo elemento a elemento:")
        for cell in a.flat:
            print(cell,end=" ")
        print()
        
        # Stacking
        print("\nStacking")
        a = np.arange(6).reshape(3,2)
        b = np.arange(6,12).reshape(3,2)
        print("Array A:\n",a)
        print("Array B:\n",b)
        print("Stack Vertical:\n",np.vstack((a,b)))
        print("Stack Horizontal:\n",np.hstack((a,b)))
        
        # Split
        print("\nSplitting")
        a=np.arange(30).reshape(2,15)
        print("Array:\n",a)
        
        print("\nSplit Horizontal:")
        result = np.hsplit(a,3)
        for i in range(len(result)):
            print("Array {}:\n{}".format(i,result[i]))

        print("\nSplit Vertical:")
        result = np.vsplit(a,2)
        for i in range(len(result)):
            print("Array {}:\n{}".format(i,result[i]))
            
        # Indexação com Arrays Booleanos
        print("\n\nIndexação com Arrays Booleanos")
        a = np.arange(12).reshape(3,4)
        print("Array:\n",a)
        
        b = a > 4
        print("Se o elemento é maior que 4:\n",b)
        print("Apenas os elementos maiores que 4:\n",a[b])
        a[b] = -1
        print("Substituindo os elementos maiores que 4 por -1:\n",a)

    # Parte 4: Iterando com nditer
    def parte4():
        a = np.arange(12).reshape(3,4)
        print("Array:\n",a)
        
        # É possível iterar com múltiplos "for" ou ainda com diferentes métodos.
        # Mas há um método do numpy para facilitar e centralizar isso: nditer
        # Muitas opções, verifique documentação!
        print("\nIterando por todos os elementos")
        
        # Igual a um for com a.flat, visto na parte 3
        print("Linha a linha (ordem C):")
        for x in np.nditer(a,order='C'):
            print(x,end=' ')
        print()
        
        # Ordem Fortran
        print("Coluna a coluna (ordem Fortran):")
        for x in np.nditer(a,order='F'):
            print(x,end=' ')
        print()
        
        # Flags:
        print("Imprimindo as colunas:")
        for x in np.nditer(a,order='F', flags=['external_loop']):
            print(x,end=' ')
        print()
        
        # Op_flags: 
        # Modificando o array
        print("\nModificando o array")
        for x in np.nditer(a,op_flags=['readwrite']):
            x[...]=x*x
        print("Tomando o quadrado de todos os elementos:\n",a)
        
        # Iterando por dois arrays ao mesmo tempo
        print("\nIterando por dois arrays")
        b = np.arange(3,15,4).reshape(3,1)
        print("Array A:\n",a)
        print("Array B:\n",b)
        
        # Para isso funcionar, as dimensões dos dois arrays precisam ser iguais ou uma delas é 1.
        print("Percorrendo A e B ao mesmo tempo:")
        for x,y in np.nditer([a,b]):
            print(x,y)
        
        print("\nMuito mais pode ser feito, leia a documentação!")

    print("AULA 21: NUMPY")
    print("Para ver esta aula, abra o script e o leia ao mesmo tempo que vê a saída.")
    print("Para melhor visualização, redirecione a saída para 'less' (python3 aula21.py | less).")
    
    print("\nPARTE 1: INTRODUÇÃO\n\n")
    parte1()
    
    print("\nPARTE 2: OPERAÇÕES\n\n")
    parte2()
    
    print("\nPARTE 3: INDEXAÇÃO E MANIPULAÇÃO\n\n")
    parte3()
    
    print("\nPARTE 4: ITERAR SOBRE O ARRAY COM NDITER\n\n")
    parte4()
    
    print("\nPara mais informações, veja o texto da aula.")
    print("Para a resolução do teste, entre em modo interativo e execute a função 'benford'")
    print("Esta aula tem exercícios. Execute-os pelo modo interativo.")

# Exercícios:

# Normaliza as linhas de uma matriz (soma dos quadrados é 1)
# Normaliza as colunas de uma matriz
# Calcula a soma dos elementos das linhas cujos primeiros valores são >0
# Computa um array 1D com o item de menor valor absoluto para cada coluna.
# Dado um array 1D, troca todos os valores >0 para 1 e os <0 para -1

if __name__ == "__main__":
    aula()
