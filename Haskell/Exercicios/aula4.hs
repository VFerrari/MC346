-- Aula:

-- Exemplo de Thunk (lazy evaluation)
--let a = [1..]
--take 3 a
--let b = drop 5 a
--let {double [] = [] ; double (x:xs) = (2*x):(double xs)}
--let c = double b
--let d = double (take 1 c)
--d


--Solucao do teste:

-- Tuplas (melhor versão)
splitseq2 :: (Eq a) => [a] -> [a] -> [[a]]

splitseq2 sep [] = [[]]
splitseq2 sep l 
  | com = []:(splitseq2 sep res)
  | otherwise = ((head l):a):as 
  where
     (com,res) = aux sep l 
     (a:as) = splitseq2 sep (tail l)

aux [] res = (True, res)
aux _ [] = (False, [])
aux (a:as) (b:bs) 
  | a==b = aux as bs
  | otherwise = (False,[])


-- Exs:
-- Não tem ...
