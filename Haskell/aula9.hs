-- Aula:

-- Aula sobre MAYBE
-- data Maybe a = Nothing | Just a

-- Maybe em funções

-- :m + Data.List
-- find (>4) [1,2,3,4,5,6,7]
-- find (>14) [1,2,3,4,5,6,7]

-- import Data.Map.Strict as M
-- let dd =  M.fromList [("a",3),("b",5),("g",8)]
-- M.lookup "b" dd
-- M.lookup "f" dd


-- Teste:
main = do 
       dados <- getLine
       let saida = unwords $ reverse $ words dados
       putStrLn saida
