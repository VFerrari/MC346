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

import Data.Map.Strict as Map
import Data.Maybe

main = do 
       input <- getContents
       putStrLn $ head $ lines input -- Placeholder

-- Insere uma aresta no grafo
readInput g (or:de:modo:peso) = Map.insert de (modo,peso) $ fromMaybe $ Map.lookup or