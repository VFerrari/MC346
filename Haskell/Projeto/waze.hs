-- Daniel Pereira Ferragut, RA 169488
-- Victor Ferreira Ferrari, RA 187890

-- Projeto 1 de MC346 - Waze para transporte público	
-- Programa em Haskell que calcula o caminho mais rápido entre uma origem
-- e um destino dado usando uma combinação de caminhar e usar transporte público.

-- Modelagem por meio de grafo, e o menor caminho entre dois pontos (um para um).
-- Retorna o melhor caminho, o modo de chegar a cada ponto, e o tempo total gasto.



-- TODO: Criar o tipo do grafo*
-- TODO: Ler o grafo e as características.
-- TODO: Biblioteca simples para operações em grafo (existe o Data.Graph mas não parece ser o que queremos)*
-- TODO: Modelar o grafo para simples implementação do algoritmo de Djikstra
-- TODO: Djikstra
-- TODO: Resposta

-- * = Mais urgentes

-- Ideias para modelagem:
-- Junta todas as arestas entre 2 nós em uma, com peso igual ao menor.
-- Menor peso: a pé ou soma da metade do período do t. publico e o peso normal.

import Data.List (sortBy)

-- Lista de adjacências. Grafo é uma lista de "No"
data Aresta = Aresta Char String Float deriving (Show, Eq, Ord)
data No = No Char [Aresta] deriving (Show, Eq)

main = do 
       input <- getContents
       let inputSplit = map words $ lines input
       putStrLn $ head $ lines input -- Placeholder

-- Ler o grafo a partir do input dividido em palavras
readInput :: [No] -> [String] -> [No]
readInput g (or:stDe:mo:stPe) = 
    let de = read stDe :: Char 
        pe = read stPe :: Float
    in insAresta or (Aresta de mo pe) g 
   

-- Inserir aresta no grafo
insAresta origem aresta [] = [No origem [aresta]]
insAresta origem aresta ((No b l):gs)
    | b == origem = ((No b (aresta:l)):gs)
    | b /= origem = ((No b l):insAresta origem aresta gs)

-- Função auxiliar para peso de aresta.
getFloat (Aresta _ _ f) = f

-- Função de comparação de arestas para uso com SortBy
sortFloat (Aresta _ _ f1) (Aresta _ _ f2)
    | f1 > f2 = GT
    | otherwise = LT
