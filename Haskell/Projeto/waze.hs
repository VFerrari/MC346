-- Daniel Pereira Ferragut, RA 169488
-- Victor Ferreira Ferrari, RA 187890

-- Projeto 1 de MC346 - Waze para transporte público	
-- Programa em Haskell que calcula o caminho mais rápido entre uma origem
-- e um destino dado usando uma combinação de caminhar e usar transporte público.

-- Modelagem por meio de grafo, e o menor caminho entre dois pontos (um para um).
-- Grafo simplificado transformando cada modo de transporte em um "plano" distinto, com os vértices da linha.
-- Retorna o melhor caminho, o modo de chegar a cada ponto, e o tempo total gasto.

-- Modificado em: 30/09/2018

import Data.Map.Strict as Map
import Data.List(minimumBy)
import Data.Maybe

main = do
       input <- getContents 
       let linInput = lines input 
       
       -- Separando a entrada em quatro seções:
       let gInput = Prelude.map words $ takeWhile (not . Prelude.null) linInput       -- Grafo
       let waitInput = (init . init . tail) $ dropWhile (not . Prelude.null) linInput -- Periodos
       let pathInput = words $ last linInput                                          -- Começo e Final
       let start = (head pathInput,"a-pe")                                            -- Começo
       let end = (last pathInput,"a-pe")                                              -- Final
       
       -- Cria o dicionário de tempos de espera
       -- Lê o grafo como lista de adjacências, e aplica o algoritmo de Djikstra.
       let (ant,tam) = djikstra start end $ readGraph gInput empty $ fromList $
                       Prelude.map (mapLines) $ Prelude.map words waitInput
      
       -- Percorre a árvore de antecessores, e retorna o caminho.
       putStrLn $ parsePath (fst start) $ pathList end [] ant
       print tam
       
-- Transforma uma linha da entrada com os periodos em uma tupla (com valor periodo/2).
mapLines (a:b:[]) = (a,c) where c = (read b :: Float)/2

-- O grafo é modelado como uma lista de adjacências, feito com Maps no lugar de listas.
readGraph inp og modes = Prelude.foldl(\g lin -> readEdge g modes lin) og inp

-- Função que lê a aresta a ser inserida
-- Insere, se necessario, os vértices envolvidos nessa aresta.
-- Verifica o modo, e realiza as ações pertinentes a cada uma.
-- Insere a aresta "a-pe", ou faz uma sequencias de inserções de transporte publico.
-- Cria aresta de "mudança de plano", que simboliza entrar em um ônibus.
-- O preço dessa mudança está no dicionário mapWait.
readEdge g mapWait (ori:end:mode:strWei:[])
    | mode == "a-pe" = insEdge (ori,end,"a-pe",wei) "a-pe" $
                       insertIfNotMember (end, "a-pe") g
                       
    | otherwise = insEdge (end,end,mode,0.0) "a-pe" $ 
                  insertIfNotMember (end, "a-pe") $
                  insEdge (ori,end,mode,wei) mode $ 
                  insEdge (ori,ori,"a-pe",wait) mode g
    where wei = read strWei :: Float
          wait = fromJust $ Map.lookup mode mapWait

-- Insere um vértice no grafo se ele não existir na lista de adjacencias.
insertIfNotMember v g = if member v g then g else insert v empty g

-- Insere uma aresta no grafo a partir de uma linha da entrada
-- Insere o vértice de origem se não existe no grafo.
-- Recebe a tupla de 4 elementos que representa a aresta.
-- Recebe o "plano" do vértice destino (modo de entrada no vértice).
insEdge (ori,end,exitMode,wei) entryMode g 
    = insert (ori,exitMode) (insertEdge $ Map.lookup (ori,exitMode) g) g
    where insertEdge m = insert (end,entryMode) wei $ fromMaybe empty m                 

-- Implementação do algoritmo de Djikstra.
-- Encontra o menor caminho entre um vértice e todos os outros.
-- Recebe o vértice inicial e o grafo, e retorna a árvore de antecessores.
-- Inicia o dicionário de predecessores com "nil" e o de distâncias com infinito.
djikstra start end graph = djikstraLoop graph end (pred,dist)
    where pred = initialize graph ("nil","nil")
          dist = insert start 0 $ initialize graph (1/0) -- 1/0 == infinity

-- Loop principal do Djikstra.
-- Se a fila de prioridades estiver vazia, retorna a árvore de predecessores.
-- Se encontrar o vértice final, retorna a árvore e a distância total.
-- Senão, extrai o menor elemento, encontra seus vizinhos no grafo, e relaxa as arestas.
djikstraLoop graph end (pred,dist)
    | dist == empty = (pred,(1/0))
    | u == end = (pred,distU)
    
    -- Relaxa as arestas, e passa ao próximo vértice, recursivamente.
    | otherwise = djikstraLoop graph end $
                  Map.foldlWithKey (\(currPred,currDist) v wei -> relax (u,distU) (v,wei) (currPred,currDist)) (pred,delDist) neigh

    -- Extrai o mínimo, e encontra o vizinho desse vértice mínimo.
    where (u , distU) = minimumBy (\x y-> compare (snd x) (snd y)) $ toList dist
          delDist = delete u dist
          neigh = fromJust $ Map.lookup u graph 

-- Inicia um dicionário com um valor padrão passado.
initialize graph newValue = Map.map (\ _ -> newValue) graph

-- Função de relaxação de aresta.
-- Recebe o vértice de origem/distância calculada até ele (u, distU)
-- Recebe o vértice de destino/peso da aresta a ele (v,wei)
-- Recebe os dicionários de antecessores e distâncias (pred,dist).
-- Atualiza o antecessor e a distância de V se d(V) > d(U) + wei
relax (u,distU) (v,wei) (pred,dist)
    | dV > d = (newPred , newDist)
    | otherwise = (pred, dist)
    where dV = fromMaybe (-1/0) $ Map.lookup v dist
          d = distU + wei
          newPred = insert v u pred
          newDist = insert v d dist

-- Função que retorna o menor caminho, em forma de lista.
-- Percorre árvore de predecessores, adicionando-os à lista.
pathList ("nil","nil") list _ = list
pathList vert list pred =
    let newList = vert:list
        prevVert = fromJust $ Map.lookup vert pred
    in  pathList prevVert newList pred

-- Função que transforma a lista de menor caminho em uma string.
-- Cria a saída do programa, separando cada vértice e modo.
-- Exclui as "trocas de modo", onde os vértices são iguais.
parsePath str ([_]) = str
parsePath str (h:t:xs)
    | headM == tailM = if headM == "a-pe" then parsePath walk (t:xs) else parsePath str (t:xs)
    | otherwise = if tailM == "a-pe" then parsePath out (t:xs) else  parsePath str (t:xs)
    where   (_, headM) = h 
            (tailV, tailM) = t
            walk = str ++ " a-pe " ++ tailV
            out = str ++ (' ':headM) ++ (' ':tailV)