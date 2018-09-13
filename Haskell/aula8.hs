-- Aula:

-- Aula sobre MÓDULOS
--import Data.List
--import Data.List (nub,sort)
--import qualified Data.List as DL
--DL.sort
-- :m + Data.List Data.Map

-- Hackage: http://hackage.haskell.org/package/containers-0.6.0.1/docs/Data-Map-Strict.html

-- Teste:

soma1 ch [] = [(ch,1)]
soma1 ch ((x,n):xs) 
     | x==ch = (x,n+1):xs
     | otherwise = (x,n): soma1 ch xs 

-- Levemente errado, resposta do teste.
vvog l = snd $ maximum $ map fflip $ foldl  (flip . soma1) [] $ filter (`elem` "aeiou") $ map toLower l
    where fflip (a,b) = (b,a)


-- Exs:
-- Não tem...
