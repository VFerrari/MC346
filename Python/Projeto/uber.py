# Daniel Pereira Ferragut, RA 169488
# Victor Ferreira Ferrari, RA 187890

# Projeto 3 de MC346 - Uber Pool	
# Programa em Python que calcula os melhores pares de passageiros com
# relação à inconveniência de cada um pela carona.

# Inconveniência pode ser calculada como a razão entre o tempo total da
# viagem de um passageiro com carona e a viagem individual. Não pode exceder 1.4.

# Modelagem por meio de grafo.
# Retorna uma lista dos melhores percursos.

# Modificado em: 11/11/2018

# Implementação do algoritmo Floyd-Warshall.
# Utilizado para calcular caminhos mínimos todos-para-todos em um grafo.
# Supõe grafo dado em matriz de adjacências. Modifica a matriz de entrada.
# Retorna a matriz de predecessores.
def floydWarshall(graph):
	n = len(graph)
	pred = [[0] * n for i in range(n)]
	for i in range(n):
		for j in range(n):
			pred[i][j] = j
			
	for k in range(n):
		for i in range(n):
			for j in range(n):
				if graph[i][j] > graph[i][k] + graph[k][j]:
					graph[i][j] = graph[i][k] + graph[k][j]
					pred[i][j] = pred[i][k]
	return pred

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
	pathInconv[1] = 1
	totInconv.append(max(pathInconv))
	
	# C,A,D,B - 2
	pathInconv[0] = (dist[path1[0]][path2[1]] + dist[path2[1]][path1[1]])/dir1
	pathInconv[1] = (dist[path2[0]][path1[0]] + dist[path1[0]][path2[1]])/dir2
	totInconv.append(max(pathInconv))
	
	# C,A,B,D - 3
	pathInconv[0] = 1
	pathInconv[1] = (dist[path2[0]][path1[0]] + dir1 + dist[path1[1]][path2[1]])/dir2
	totInconv.append(max(pathInconv))

	path = totInconv.index(min(totInconv))
		
	return (totInconv[path],path) if totInconv[path] < 1.4 else (-1,-1)
