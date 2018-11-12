from sys import stdin
from math import inf
from collections import defaultdict

def main():
	grafo, viagens = lerGrafoEViagens()
	predGrafo, minDist = floydWarshall(grafo)
	viagensFeitas = defaultdict(bool)
	for viagem in viagens:
		viagensFeitas[viagem] = False
	listaDeIncov = []

	for viagem in viagens:
		for carona in viagens:
			if viagem == carona:
				continue
			if len(viagem) == 2:
				incov, incovPath = minInconv(minDist, viagem, carona)
			else:
				viagemOnGoing = (viagem[3],viagem[2])
				incov, incovPath = minInconv(minDist, viagemOnGoing, carona)
			listaDeIncov.append((viagem, carona, incov, incovPath))	

	listaDeIncov = sorted(listaDeIncov, key = lambda y: y[2])
	for i in listaDeIncov:
		origem, carona, incov, incovPath = i
		if incov == inf:
			break
		if viagensFeitas[origem] or viagensFeitas[carona]:
			continue
		viagensFeitas[origem] = True
		viagensFeitas[carona] = True
		print("Viagem entre {} e {} feita com inconv = {}".format(origem, carona, incov))
	for i in viagensFeitas:
		if not viagensFeitas[i]:
			print("Viagem direta de {}".format(i))
		
		

def lerGrafoEViagens():
	viagens = []
	lerGrafo = True
	grafoEmDic = defaultdict(list)
	maiorVertice = -1
	for line in stdin:
		if line == "\n":
			lerGrafo = False
			continue
		if lerGrafo:
			origem, destino, peso = line.split()
			origem, destino = int(origem), int(destino)
			maiorVertice = maiorVertice if maiorVertice > max(origem,destino) else max(origem,destino)
			peso = float(peso)
			grafoEmDic[origem].append((destino,peso))
		else:
			splited = line.split()
			origem = int(splited[0])
			destino = int(splited[1])
			if len(splited) == 2:
				viagem = (origem, destino)
			else:
				viagem = (origem, destino, int(splited[2]))
			viagens.append(viagem)
	grafoEmMatrix = createMatrixGraph(grafoEmDic, maiorVertice)
	return grafoEmMatrix, viagens

def createMatrixGraph(grafoEmDic, maiorVertice):
	matrix = [[0]*(maiorVertice+1) for i in range(maiorVertice+1)]
	for origem in range(maiorVertice+1):
		listaVizinhos = grafoEmDic[origem]
		for vizinho in listaVizinhos:
			destino = vizinho[0]
			peso = vizinho[1]
			matrix[origem][destino] = peso
	return matrix 

def floydWarshall(originalGraph):
	n = len(originalGraph)
	pred = [[0] * 	n for i in range(n)]
	graph = [row[:] for row in originalGraph]
	for i in range(n):
		for j in range(n):
			pred[i][j] = None
			if originalGraph[i][j] == 0:
				graph[i][j] = inf
			else:
				graph[i][j] = originalGraph[i][j]
				pred[i][j] = j

	for k in range(n):
		for i in range(n):
			for j in range(n):
				if graph[i][j] > graph[i][k] + graph[k][j]:
					graph[i][j] = graph[i][k] + graph[k][j]
					pred[i][j] = pred[i][k]
	for i in range(n):
		graph[i][i] = 0
	return (pred,graph)

def minInconv(dist, path1, path2):
	dir1,dir2 = dist[path1[0]][path1[1]] , dist[path2[0]][path2[1]]
	print(dir1, dir2)
	pathInconv,totInconv = [0,0],[]
	
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

if __name__ == "__main__":
	main()


