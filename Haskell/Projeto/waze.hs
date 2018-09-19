-- Daniel Pereira Ferragut, RA 169488
-- Victor Ferreira Ferrari, RA 187890

-- Projeto 1 de MC346 - Waze para transporte público	
-- Programa em Haskell que calcula o caminho mais rápido entre uma origem
-- e um destino dado usando uma combinação de caminhar e usar transporte público.

-- Modelagem por meio de grafo, e o menor caminho entre dois pontos (um para um).
-- Retorna o melhor caminho, o modo de chegar a cada ponto, e o tempo total gasto.

-- TODO: Modelar o grafo para simples implementação do algoritmo de Djikstra
    -- tecnicamente feito
-- TODO: Djikstra
-- TODO: Resposta

-- * = Mais urgentes

-- Ideias para modelagem:
-- Junta todas as arestas entre 2 nós em uma, com peso igual ao menor.
-- Menor peso: a pé ou soma da metade do período do t. publico e o peso normal.

import Data.Map.Strict as Map
import Data.List(sortBy)
import Data.Maybe

main = do

       -- Lendo a entrada
       input <- getContents 
       let linInput = lines input 
       
       -- Separando a entrada em tres seções
       let gInput = takeWhile (not . Prelude.null) linInput -- Grafo
       let modInput = (init . init . tail) $ dropWhile (not . Prelude.null) linInput
       let pathInput = last linInput -- Caminho desejado
       
       -- Temporário: imprime a entrada dividida
    --    print gInput
    --    print modInput
    --    print pathInput
    --    putStrLn ""
       
       -- Lê o grafo
       let mapModo = fromList $ Prelude.map (mapLines) $ Prelude.map (words) modInput
       let graph = readGraph gInput mapModo
       let modGraph = shortGraph graph
       print modGraph
       putStrLn ""
    --    print graph

-- Transforma uma linha da entrada com os modificadores em um dicionário.
mapLines (a:b:[]) = (a,c) where c = read b :: Float

-- Função que analisa uma linha da entrada, criando o grafo.
-- Insere o vértice de origem no grafo se não existe.
-- O(lgn)
readInput g mapModo (ori:dest:modo:strPeso:[])  = insert ori (insertEdge $ Map.lookup ori g) g
    where peso = read strPeso :: Float
          custoEstimado = Map.lookup modo mapModo
          pesoReal = peso + (fromMaybe 0.0 custoEstimado)/2
          insertEdge m = insertWith (++) dest [(modo,pesoReal)] $ fromMaybe empty m  -- Insere uma aresta no grafo.

-- Função que percorre a entrada, construindo o grafo.
-- O grafo é modelado como uma lista de adjacências, feito com Maps no lugar de listas.
readGraph inp modos = Prelude.foldl(\g lin -> readInput g modos $ words lin) empty inp

shortGraph oriGraph =  Map.map (Map.map (sortBy (\(_,a) (_,b) -> compare a b))) oriGraph
