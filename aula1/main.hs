--Aula:

double x = 2*x

par y = if (mod y 2)==0 then True
                        else False
                        
par' y = mod y 2 == 0

tam1 x = if x==[] then 0
                  else 1 + tam1 (tail x)
                  
tam2 [] = 0
tam2 x = 1 + tam2 (tail x)

tam3 [] = 0
tam3 (x:xs) = 1 + tam3 xs

somap1 [] = 0
somap1 (x:xs) = (if par x then x else 0) + somap1 xs

somap2 [] = 0
somap2 (x:xs) 
    | par x = x + somap2 xs
    | otherwise = somap2 xs
    
conta it [] = 0
conta it (x:xs) 
  | x==it = 1 + (conta it xs)
  | x /= it = conta it xs


-- Ex:
-- Soma dos elementos de uma lista
soma [] = 0
soma (x:xs) = x + soma xs

-- Soma dos elementos nas posições pares
somapp y [] = 0
somapp y (x:xs)
    | mod y 2 == 0 = x + somapp (y+1) xs
    | otherwise = somapp (y+1) xs

-- Existe na lista
contains y [] = False
contains y (x:xs)
    | y == x = True
    | otherwise = contains y xs
    
-- Posicao de um elemento na lista
-- TERMINAR
index y [] = 0
index y (x:xs)
    | y == x = 1 
    | otherwise = 1 + index y xs

-- Qtas vezes o elemento aparece na lista
amount y [] = 0
amount y (x:xs)
    | y == x = 1 + amount y xs
    | otherwise = amount y xs

-- Maior elemento de uma lista
maxi [] = 0
maxi (x:xs)
    | (maxi xs) > x = maxi xs
    | otherwise = x

-- Ultimo elemento de uma lista
ult [] = 0
ult (x:xs)
    | (xs == []) = x
    | otherwise = ult xs

-- Reverte uma lista
reverter [] = []
reverter (x:xs) = reverter xs ++ [x]

-- Intercalar 2 listas
intercala1 [] [] = []
intercala1 [] y = [head y]
intercala1 x [] = [head x]
intercala1 x y = [head x] ++ intercala1 y (tail x)

intercala2 [] [] = []
intercala2 [] y = y
intercala2 x [] = x
intercala2 x y = [head x] ++ intercala2 y (tail x)

-- Verifica se lista esta ordenada
sorted [] = True
sorted (x:xs)
    | (xs == []) = True
    | otherwise = (x < head xs) && sorted xs
    
-- Gera lista de 1 a N
sequencia 0 = []
sequencia x = sequencia (x-1) ++ [x]

-- Retorna lista sem o último elemento
delLast [] = []
delLast (x:xs)
    | (xs == []) = []
    | otherwise = [x] ++ delLast xs


-- Shifts

-- Shift Right
shiftr [] = []
shiftr x
    | (tail x == []) = x
    | otherwise = [ult x] ++ delLast x

-- Shift Left
shiftl [] = []
shiftl (x:xs)
    | (xs == []) = [x]
    | otherwise = xs ++ [x]
    
-- Shift Right N vezes
shiftrn n [] = []
shiftrn 0 x = x
shiftrn n x = shiftr (shiftrn (n-1) x)
    
-- Shift Left N vezes
shiftln n [] = []
shiftln 0 x = x
shiftln n x = shiftl (shiftln (n-1) x)


-- Remover itens da lista

-- Remove item da lista (1 vez)
rm1 y [] = []
rm1 y (x:xs)
    | (y == x) = xs
    | otherwise = [x] ++ rm1 y xs

-- Remove item da lista (todas as vezes)
rmall y [] = []
rmall y (x:xs)
    | (y == x) = rmall y xs
    | otherwise = [x] ++ rmall y xs

-- Remove item da lista (primeiras N vezes)
rmN y n [] = []
rmN y 0 x = x
rmN y n (x:xs)
    | (y == x) = rmN y (n-1) xs
    | otherwise = [x] ++ rmN y n xs

-- Remove item da lista (ultima vez que aparece)
--rmLast y [] = []


-- Trocar itens da lista

-- Troca velho por novo na lista (1 vez)
troca1 y z [] = []
troca1 y z (x:xs)
    | (y == x) = [z] ++ xs
    | otherwise = [x] ++ troca1 y z xs
    
-- Troca velho por novo na lista (todas as vezes)
trocaAll y z [] = []
trocaAll y z (x:xs)
    | (y == x) = [z] ++ trocaAll y z xs
    | otherwise = [x] ++ trocaAll y z xs

-- Troca velho por novo na lista (primeiras N vezes)
trocaN y z n [] = []
trocaN y z 0 x = x
trocaN y z n (x:xs)
    | (y == x) = [z] ++ trocaN y z (n-1) xs
    | otherwise = [x] ++ trocaN y z n xs
