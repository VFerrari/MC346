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

       -- Lendo a entrada
       input <- getContents 
       let graph = Map.empty
       let linInput = lines input 
       
       -- Separando a entrada em tres seções
       let gInput = takeWhile (not . Prelude.null) linInput -- Grafo
       let modInput = (init . init) $ tail $ dropWhile (not . Prelude.null) linInput
       let pathInput = last linInput -- Caminho desejado
       
       -- Temporário: imprime a entrada dividida
       print gInput
       print modInput
       print pathInput
       putStrLn ""
       
       -- Temporário - lê duas linhas da entrada, insere no grafo, e o imprime
       let lol = readInput graph $ words $ head gInput
       print $ readInput lol $ words $ head $ drop 1 gInput

-- Função que analisa uma linha da entrada, criando o grafo.
-- Insere o vértice de origem no grafo se não existe.
-- O(lgn)
readInput g (ori:dest:modo:strPeso:[]) = insert ori (insertEdge $ Map.lookup ori g) g
    where peso = read strPeso :: Float    
          insertEdge map = insertWith (++) dest [(modo,peso)] $ fromMaybe empty map  -- Insere uma aresta no grafo.
