-- Daniel Pereira Ferragut, RA 169488
-- Victor Ferreira Ferrari, RA 187890

-- Projeto 1 de MC346 - Waze para transporte público	
-- Programa em Haskell que calcula o caminho mais rápido entre uma origem
-- e um destino dado usando uma combinação de caminhar e usar transporte público.

-- Modelagem por meio de grafo, e o menor caminho entre dois pontos (um para um).
-- Retorna o melhor caminho, o modo de chegar a cada ponto, e o tempo total gasto.

-- TODO: Djikstra
-- TODO: Resposta

import Data.Map.Strict as Map
import Data.Maybe

main = do

       -- Lendo a entrada
       input <- getContents 
       let linInput = lines input 
       
       -- Separando a entrada em tres seções
       let gInput = takeWhile (not . Prelude.null) linInput -- Grafo
       let prettyInput = Prelude.map (\(ori:dest:modo:peso:[]) -> (ori,dest,modo,peso)) $ Prelude.map words gInput
       
       let modInput = (init . init . tail) $ dropWhile (not . Prelude.null) linInput
       let pathInput = words $ last linInput -- Caminho desejado
       
       -- Cria o dicionário de modificadores
       let mapModo = fromList $ Prelude.map (mapLines) $ Prelude.map (words) modInput

       -- Lê o grafo e o ordena
       let graph = readGraph prettyInput mapModo empty

       print graph
       
-- Transforma uma linha da entrada com os modificadores em uma tupla.
mapLines (a:b:[]) = (a,c) where c = read b :: Float

-- Função que percorre a entrada, construindo o grafo.
-- O grafo é modelado como uma lista de adjacências, feito com Maps no lugar de listas.
readGraph inp modos og = Prelude.foldl(\g lin -> readEdge g modos lin) og inp

-- Função que lê a aresta a ser inserida
-- Verifica o modo, e realiza as ações pertinentes a cada uma.
-- Insere a aresta "a-pe", ou faz uma sequencias de inserções de transporte publico.
-- Cria aresta de "mudança de plano", que simboliza entrar em um ônibus.
-- O preço dessa mudança está no dicionário mapModos.
readEdge g mapModos (ori,dest,modo,strPeso)
    | modo == "a-pe" = insEdge (ori,dest,modo,peso) "a-pe" g
    | otherwise = insEdge (dest,dest,modo,0.0) "a-pe" $ 
                  insEdge (ori,dest,modo,peso) modo $ 
                  insEdge (ori,ori,"a-pe",modif) modo g
        
    where peso = read strPeso :: Float
          modif = (fromJust $ Map.lookup modo mapModos)/2

-- Insere uma aresta no grafo a partir de uma linha da entrada
-- Insere o vértice de origem se não existe no grafo.
-- Recebe a tupla de 4 elementos que representa a aresta.
-- Recebe o "plano" do vértice destino (modo de entrada no vértice).
insEdge (ori,dest,modoSaida,peso) modoEnt g 
    = insert (ori,modoSaida) (insertEdge $ Map.lookup (ori,modoSaida) g) g
    where insertEdge m = insert (dest,modoEnt) peso $ fromMaybe empty m                 
    -- Insere a aresta, gerando o par (destino,modo) e o seu peso como valor.
