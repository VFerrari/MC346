-- Aula:

data Tree a = Vazia | No a (Tree a) (Tree a) deriving (Eq, Show, Read)

-- Procura um item em uma abb
procura :: (Ord a, Eq a) => a -> Tree a -> Bool

procura _ Vazia = False
procura it (No x ae ad)
    | it==x = True
    | it < x  = procura it ae
    | it > x  = procura it ad


-- Verifica se uma arvore é uma abb (V1)
abb Vazia  = True
abb (No _ Vazia Vazia)  = True
abb (No x Vazia ad) = (abb ad) && (x < (menor ad))
abb (No x ae Vazia) = (abb ae) && (x > (maior ae))
abb (No x ae ad) = (abb ae) && (abb ad) && (x < (menor ad)) && (x>(maior ae))

maior (No x _ Vazia) = x
maior (No x _ ad) = maior ad

menor (No x Vazia _) = x
menor (No x ae _) = menor ae

-- Ex:
-- Insere um item em uma abb
insert a Vazia = No a Vazia Vazia
insert a (No x ae ad)
    | a < x = No x (insert a ae) ad
    | a > x = No x ae (insert a ad)
    | a == x = No x ae ad

-- Remove um item em uma abb
remove _ Vazia = Vazia
remove a (No x ae ad)
    | a < x = No x (remove a ae) ad
    | a > x = No x ae (remove a ad)
    | a == x = delete ae ad
    where
        delete Vazia Vazia = Vazia
        delete Vazia ad = ad
        delete ae Vazia = ae
        delete ae ad = let
                mm = menor ad
            in No mm ae (remove mm ad)

-- Calcula profundidade maxima de uma abb
depth Vazia = 0
depth (No _ ae ad)
    | e > d  = e + 1
    | e <= d = d + 1
    where
        e = depth ae
        d = depth ad
        
-- Converte abb em uma lista em ordem infixa (esq, no, dir)
inOrder Vazia = []
inOrder (No x ae ad) = (inOrder ae) ++ (x:(inOrder ad))

-- Converte abb em uma lista em ordem prefixa (no, esq, dir)
preOrder Vazia = []
preOrder (No x ae ad) = (x:preOrder ae) ++ (preOrder ad)

-- Converte uma lista em uma abb
buildTree [] = Vazia
buildTree (x:xs) = insert x (buildTree xs)


-- Exercicios extras:
-- Conta os nos de uma abb
countNodes Vazia = 0
countNodes (No _ ae ad) = (countNodes ae) + (countNodes ad) + 1

-- Soma os nos de uma abb
sumNodes Vazia = 0
sumNodes (No x ae ad) = (sumNodes ae) + (sumNodes ad) + x

-- Converte abb em uma lista em ordem posfixa (esq, dir, no)
postOrder Vazia = []
postOrder (No x ae ad) = (postOrder ae) ++ (postOrder ad) ++ [x]

