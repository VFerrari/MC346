-- Aula

-- Conta itens da lista
conta it l = foldl (\ac x -> if x==it then ac+1 else ac) 0 l

conta' it l = foldr (\x res -> if x==it then res+1 else res) 0 l 

-- Conta quantos itens satisfazem uma função
contaf f l = foldl (\ac x -> if f x then ac+1 else ac) 0 l

-- Troca elemento velho por novo usando "fold"
troca velho novo l = foldr (\x res -> if x==velho then novo:res else x:res) [] l 

trocal velho novo l = foldl (\acc x -> if x==velho then acc++[novo] else acc++[x]) [] l

-- Remover um item da lista n vezes
rem1 it n l = fst $  foldl (\(li,nn) x -> 
                     if x==it && nn>0 
                         then (li,nn-1) 
                         else (li++[x],nn))
                   ([],n) l 
                   
-- Transpor uma matriz
transp ([]:_) = []
transp mat = col1 : (transp restmat)
   where col1 = map head mat
         restmat = map tail mat

-- Multiplicação de Matrizes
matmul m1 m2 = matmul' m1 (transp m2)

matmul' [] _ = [[]]
matmul' (lin:r) m2 = (map (\l -> dotprod l lin) m2) : (matmul' r m2)

dotprod l1 l2 = sum $ zipWith (*) l1 l2

-- Ex:

-- Soma elementos das posições pares
somaPPar :: (Num a) => [a] -> a
somaPPar l = fst $ foldl (\(res,pos) x -> 
                         if pos `mod` 2 == 0 
                             then (res+x, pos+1) 
                             else (res,pos+1)) 
                   (0,1) l
                        
-- Calcular a posicao do elemento
index it l = fst $ foldl (\(res,pos) x -> 
                         if it == x
                             then (pos, pos+1)
                             else (res, pos+1))
                   (0,1) l     

-- Intercala 2 listas
intercala1 l r = concat $ zipWith (\a b -> [a,b]) l r
intercala1' l r = foldl1 (\acc x -> acc++x) $ zipWith (\a b -> [a,b]) l r
-- Não consegui fazer o intercala2

-- Verifica se a lista está ordenada
sorted l = fst $ foldl (\(res, ant) x -> 
                       if x >= ant && res /= False 
                           then (True, x) 
                           else (False, x)) 
                 (True, (head l)) l 

-- Ultimo elemento de uma lista
ult :: [a] -> a  
ult = foldl1 (\_ x -> x)  

-- Retorna a lista sem o último elemento
dropLast l = filter (\x -> x /= u) l where u = ult l

-- Remove as ULTIMAS n ocorrências de um número
rmLast it n l = fst $  foldr (\x (li,nn) -> 
                             if x==it && nn>0 
                                 then (li,nn-1) 
                                 else (x:li,nn))
                       ([],n) l 
