# Daniel Pereira Ferragut, RA 169488
# Victor Ferreira Ferrari, RA 187890

# Projeto 3 de MC346 - Uber Pool        
# Programa em Python que calcula os melhores pares de passageiros com
# relação à inconveniência de cada um pela carona.

# Inconveniência pode ser calculada como a razão entre o tempo total da
# viagem de um passageiro com carona e a viagem individual. Não pode exceder 1.4.

# Modelagem por meio de grafo.
# Retorna uma lista dos melhores percursos.

# Modificado em: 12/11/2018

from sys         import stdin           # Entrada padrão
from math        import inf             # Infinito
from collections import defaultdict     # Manipulação de dicionários

def main():
    out = []
    graph, trips = readInput()          # Leitura da entrada
    pred = floydWarshall(graph)         # Caminhos mínimos (modifica o grafo).
    inconvList = allInconv(graph,trips) # Lista de inconveniências nos caminhos.
    
    # Ordena a lista pelas menores inconveniências.
    inconvList = sorted(inconvList, key = lambda y: y[2])
    
    # Dicionário de viagens feitas e inicialização.
    doneTrips = defaultdict(bool)  
    for trip in trips:
        doneTrips[trip] = False
    
    # Filtra a lista de viagens.
    tripsWithRide, dirTrips = filterTrips(doneTrips, inconvList)
    
    # Para cada viagem com carona, reconstroi o caminho
    out = tripPaths(pred, tripsWithRide, dirTrips)
    print(out)
    return out

# Lê a entrada do programa, ou seja, o grafo e as viagens.
# Lê o grafo como um dicionário, e depois o transforma em matriz de adjacências. 
# Os vértices são inteiros de 0 a tam-1 (tam é o tamanho do grafo).
# Cria uma lista com as viagens (incluindo as em andamento) como tuplas.
# Retorna o grafo e a lista de viagens.
def readInput():
    trips = []
    readGraph = True
    dictGraph = defaultdict(list)
    lastVertex = -1
    for line in stdin:
        
        # Troca de leitura.
        if line == "\n":
            readGraph = False
            continue
            
        # Leitura do grafo.
        if readGraph:
            start, end, weight = line.split()
            start, end = int(start), int(end)
            lastVertex = lastVertex if lastVertex > max(start,end) else max(start,end)
            weight = float(weight)
            dictGraph[start].append((end,weight))
            
        # Leitura das viagens.
        else:
            splited = line.split()
            start = int(splited[0])
            end = int(splited[1])
            if len(splited) == 2:
                trip = (start, end)
            else:
                trip = (start, end, int(splited[2]))
            trips.append(trip)
    
    # Matriz
    matGraph = createMatrixGraph(dictGraph, lastVertex+1)
    return matGraph, trips
    
# Cria uma matriz de adjacências.
# Transforma um grafo de dicionário para matriz.
# Recebe o grafo em dicionário e o tamanho do grafo, retorna o grafo em matriz.
def createMatrixGraph(dictGraph, size):
    matrix = [[inf]*size for i in range(size)]
    for start in range(size):
        neighList = dictGraph[start]
        for neighbor in neighList:
            end = neighbor[0]
            weight = neighbor[1]
            matrix[start][end] = weight
    return matrix 

# Implementação do algoritmo Floyd-Warshall.
# Utilizado para calcular caminhos mínimos todos-para-todos em um grafo.
# Supõe grafo dado em matriz de adjacências. Modifica a matriz de entrada.
# Retorna a matriz de predecessores.
def floydWarshall(graph):
    n = len(graph)
    pred = [[None] * n for i in range(n)]
    for i in range(n):
        for j in range(n):
            if graph[i][j] != inf:
                pred[i][j] = j
                        
    for k in range(n):
        for i in range(n):
            for j in range(n):
                if graph[i][j] > graph[i][k] + graph[k][j]:
                    graph[i][j] = graph[i][k] + graph[k][j]
                    pred[i][j] = pred[i][k]
    return pred

# Encontra a inconveniencia entre todos os pares de viagens.
# Para as viagens em andamento, utiliza só os vértices atual e final.

# PROBLEMA: viagens em andamentos quebram quando são "ride".
# POSSIVEL PROBLEMA: Recálculo de problemas. Talvez remover caminhos 2 e 3 de minInconv, ou não fazer o recálculo.
def allInconv(graph, trips):
    inconvList = []
    for trip in trips:
        for ride in trips:
            if trip == ride:
                continue
            if len(trip) == 2:
                inconv, inconvPath = minInconv(graph, trip, ride)
            else:
                ongoingTrip = (trip[3],trip[2])
                inconv, inconvPath = minInconv(graph, ongoingTrip, ride)
            inconvList.append((trip, ride, inconv, inconvPath))
    return inconvList
    
# Função que calcula a menor inconveniencia de dois passageiros
# Recebe a matriz de distâncias e duas tuplas com locais de saída e chegada, uma de cada pass.
# Faz todas as combinações de percursos.
# Retorna uma tupla com a inconveniencia e um identificador de percurso. Retorna (-1,-1) se inconv. for maior que 1.4.
def minInconv(dist, path1, path2):
    dir1,dir2 = dist[path1[0]][path1[1]] , dist[path2[0]][path2[1]]
    pathInconv,totInconv = [0,0],[]
        
    # 4 combinações:
    # A,C,B,D - 0
    pathInconv[0] = (dist[path1[0]][path2[0]] + dist[path2[0]][path1[1]])/dir1
    pathInconv[1] = (dist[path2[0]][path1[1]] + dist[path1[1]][path2[1]])/dir2
    totInconv.append(max(pathInconv))
        
    # A,C,D,B - 1
    pathInconv[0] = (dist[path1[0]][path2[0]] + dir2 + dist[path2[1]][path1[1]])/dir1
    pathInconv[1] = 1.0
    totInconv.append(max(pathInconv))
        
    # C,A,D,B - 2
    pathInconv[0] = (dist[path1[0]][path2[1]] + dist[path2[1]][path1[1]])/dir1
    pathInconv[1] = (dist[path2[0]][path1[0]] + dist[path1[0]][path2[1]])/dir2
    totInconv.append(max(pathInconv))
        
    # C,A,B,D - 3
    pathInconv[0] = 1.0
    pathInconv[1] = (dist[path2[0]][path1[0]] + dir1 + dist[path1[1]][path2[1]])/dir2
    totInconv.append(max(pathInconv))

    path = totInconv.index(min(totInconv))
                
    return (totInconv[path],path) if totInconv[path] < 1.4 else (inf,-1)

# Filtra a lista de viagens.
# Coloca em uma nova lista em ordem as viagens com carona a serem feitas.
# Coloca em outra lista as viagens sem carona.
# Recebe o dicionário booleano de viagens feitas e a lista de inconveniências.
# Retorna as duas listas de viagens criadas.
def filterTrips(doneTrips, inconvList): 
    tripsWithRide,dirTrips = [],[]
    for i in inconvList:
        trip, ride, inconv, inconvPath = i
        if inconv == inf:
            break
        if doneTrips[trip] or doneTrips[ride]:
            continue
        doneTrips[trip] = True
        doneTrips[ride] = True
        tripsWithRide.append((trip,ride,inconvPath))
        print("Viagem entre {} e {} feita com inconv = {}".format(trip, ride, inconv))
    
    for i in doneTrips:
        if not doneTrips[i]:
            dirTrips.append(i)
            print("Viagem direta de {}".format(i))
    return tripsWithRide,dirTrips

# Reconstrói o caminho de todas as viagens.
# Recebe a matriz de predecessores, e as viagens divididas em duas listas.
# Retorna uma lista de percursos.
def tripPaths(pred, rides, direct):
    allPaths=[]
    currPath=[]
    
    # Com carona
    for i in range(len(rides)):
        trip, ride, pathType = rides[i]

        # A,C,B,D
        if pathType == 0:
            currPath = (pathRec(pred,trip[0],ride[0]) + pathRec(pred,ride[0],trip[1]) 
                       + pathRec(pred,trip[1],ride[1]) + [ride[1]])
        # A,C,D,B
        elif pathType == 1:
            currPath = (pathRec(pred,trip[0],ride[0]) + pathRec(pred,ride[0],ride[1]) 
                       + pathRec(pred,ride[1],trip[1]) + [trip[1]])
        
        # C,A,D,B
        elif pathType == 2:
            currPath = (pathRec(pred,ride[0],trip[0]) + pathRec(pred,trip[0],ride[1]) 
                       + pathRec(pred,ride[1],trip[1]) + [trip[1]])
        
        # C,A,B,D
        else:
            currPath = (pathRec(pred,ride[0],trip[0]) + pathRec(pred,trip[0],trip[1]) 
                       + pathRec(pred,trip[1],ride[1]) + [ride[1]])
                       
        allPaths.append(currPath)
    
    # Sem carona
    for i in direct:
        currPath = pathRec(pred, i[0], i[1])
        allPaths.append(currPath)
    return allPaths
            

# Reconstrução do caminho a partir do Floyd-Warshall.
# Retorna sem o último elemento
def pathRec(pred, u, v):
    if pred[u][v] == None:
        return []
    path = [u]
    while pred[u][v] != v :
        u = pred[u][v]
        path.append(u)
    return path

if __name__ == "__main__":
    main()
