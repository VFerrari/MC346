# Daniel Pereira Ferragut, RA 169488
# Victor Ferreira Ferrari, RA 187890

# Projeto 3 de MC346 - Uber Pool	
# Programa em Python que calcula os melhores pares de passageiros com
# relação à inconveniência de cada um pela carona.

# Inconveniência pode ser calculada como a razão entre o tempo total da
# viagem de um passageiro com carona e a viagem individual. Não pode exceder 1.4.

# Modelagem por meio de grafo.
# Retorna uma lista dos melhores percursos.

# Modificado em: 02/11/2018

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


# Ou, mais elegante e menos natural (mais lento também)
from itertools import product
def floydWarshall2(graph):
	n = len(graph)
	pred = [[0] * n for i in range(n)]
	for i ,j in product(range(n), repeat=2):
		pred[i][j] = j
			
	for k,i,j in product(range(n), repeat=3):
		if graph[i][j] > graph[i][k] + graph[k][j]:
			graph[i][j] = graph[i][k] + graph[k][j]
			pred[i][j] = pred[i][k]

	return pred
