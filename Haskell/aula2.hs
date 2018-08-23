-- Aula
troca _ _  [] = []
troca v n (x:xs) 
    | x==v = n:(troca v n xs)
    | otherwise = x:(troca v n xs)
    
maior [x] = x
maior (x:xs) = if x > (maior xs) then x 
                                 else (maior xs)
                                 
maior2 [x] = x
maior2 (x:xs) = let
         mm = maior2 xs
      in if x>mm then x else mm 
      
reverte [] = []
reverte (x:xs) = (reverte xs) ++ [x]

reverte2 x = rev x []

rev [] acc = acc
rev (x:xs) acc = rev xs (x:acc)

-- Ex
-- Lista com todas as posicoes do item em uma lista original
posicoes _ [] = []
posicoes y x = posicoes' y x [] 1
    where 
        posicoes' _ [] z _ = z
        posicoes' y (x:xs) z n
            | x == y = n:(posicoes' y xs z (n+1))
            | otherwise = posicoes' y xs z (n+1)

-- Split (retorna lista de listas, com os elementos da lista original antes do item, e depois)
split [] _ = [[]]
split x y = split' x y []
    where
        split' [] _ _ = [[]]
        split' (x:xs) y z
            | x == y = [(reverte2 z),xs]
            | otherwise = split' xs y (x:z)

-- Lista sem os n primeiros elementos
drop' _ [] = []
drop' 0 x  = x
drop' n (x:xs) = drop' (n-1) xs

-- Apenas os n primeiros elementos da lista
take' _ [] = []
take' 0 x = []
take' n (x:xs) = x:(take' (n-1) xs)

-- Splitall (split, mas com todas as sublistas)
splitall [] _ = [[]]
splitall x y = splitall' x y []
    where
        splitall' [] _ z = [reverte2 z]
        splitall' (x:xs) y z
            | x == y = (reverte2 z):(splitall' xs y [])
            | otherwise = splitall' xs y (x:z)

-- Exs da ultima aula refeitos
-- Posicao de um elemento na lista
index y [] = 0
index y (x:xs)
    | y == x = 1
    | otherwise = if (pos > 0) then (pos+1) else 0
    where pos = index y xs
    
-- Gera lista de 1 a N
sequencia 0 = []
sequencia n = sequencia' n []
    where
        sequencia' 0 acc = acc
        sequencia' n acc = sequencia' (n-1) (n:acc)

-- Remove item da lista (ultima vez que aparece)
rmLast _ [] = []
rmLast y x = let
    (z, lixo) = rmLast' y x in z
    where
        rmLast' _ [] = ([], False)
        rmLast' y (x:xs) = let
                (xxs, removeu) = rmLast' y xs
            in if removeu ||  (x /= y) then (x:xxs, removeu)
                                       else (xxs, True)

-- Troca item da lista (ultima vez que aparece)
trocaLast _ _ [] = []
trocaLast v n x = let
    (z, lixo) = trocaLast' v n x in z
    where
        trocaLast' _ _ [] = ([], False)
        trocaLast' v n (x:xs) = let
                (xxs, trocou) = trocaLast' v n xs
            in if trocou || (x /= v) then (x:xxs, trocou)
                                     else (n:xxs, True)
