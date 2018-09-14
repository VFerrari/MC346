-- Aula:

ordenada :: (Ord t) => [t] -> Bool
ordenada [] = True
ordenada [_] = True
ordenada (a:b:xs) 
      | a < b = ordenada (b:xs)
      | otherwise = False
     
t1 :: (Eq a) => a -> a -> [a] -> [a]      
t1 _ _ [] = []
t1 n v (x:xs) 
  | x == v = [n] ++ (t1 n v xs)
  | otherwise =  [x] ++ (t1 n v xs)      
  
qs [] = []
qs (x:xs) = menor ++ [x]  ++ maior
  where  menor = qs [y | y <- xs, y<=x]
         maior = qs [y | y <- xs, y > x]


--Ex:

-- Gera lista de 1 a N
sequencia 0 = []
sequencia n = [1..n]

-- Refazendo alguns já feitos com List Comprehension

-- Auxiliares
tam [] = 0
tam (x:xs) = 1 + tam xs

soma [] = 0
soma (x:xs) = x + soma xs

reverte2 x = rev x []
rev [] acc = acc
rev (x:xs) acc = rev xs (x:acc)

-- Contar quantas vezes o item aparece na lista
amount y xs = tam [x | x <- xs, x == y]

-- Remove item da lista (todas as vezes)
rmAll y xs = [x | x <- xs, x /= y]

-- Existe item na lista
contains y xs = [x | x <- xs, x == y] /= []

-- Soma todos os pares
somapares xs = soma [x | x <- xs, x `mod` 2 == 0]

-- Split com duas strings
-- ERRADO! Corrigido nas proximas aulas.
splitString [] _ = [[]]
splitString x [] = [x]
splitString x y = splitString' x y []
    where
        splitString' x [] z = [(reverte2 z), x]
        splitString' [] _ z = [(reverte2 z)]
        splitString' (x:xs) (y:ys) z
            | x /= y = splitString' xs (y:ys) (x:z)
            | x == y = splitString' xs ys z
             
           
