-- Aula:

zipWith' f [] _ = []
zipWith' f _ [] = []
zipWith' f (a:as) (b:bs) = f a b : (zipWith' f as bs)


-- Ex:

-- Refazendo ex. da aula 1

-- Soma dos elementos de uma lista
soma = foldl1 (+)

-- Tamanho de uma lista
tam = foldr (\_ x -> x+1) 0

-- Soma dos elementos pares de uma lista
somaPar l = soma (filter (\ x -> x `mod` 2 == 0) l)

-- Existe item na lista
contains it l = (filter (\ x -> x == it) l) /= [] 

-- Conta quantas vezes um item aparece na lista
amount it l = tam (filter (\ x -> x == it) l) 

-- Remove item da lista (todas as vezes)
rmAll it = filter (\ x -> x /= it)

-- Troca item velho por novo na lista (todas as vezes)
trocaAll v n = map (\x -> if x==v then n else x)

-- Maior elemento de uma lista
maior :: (Ord a) => [a] -> a  
maior = foldr1 (\x acc -> if x > acc then x else acc)

-- Reverter uma lista
reverte :: [a] -> [a]  
reverte = foldl (\acc x -> x:acc) []

-- Ultimo elemento de uma lista
ult :: [a] -> a  
ult = foldl1 (\_ x -> x)  


-- Exercícios da aula
-- Transpoe uma matriz
--transpose = 
