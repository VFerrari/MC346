-- Aula: Não houve aula de Haskell, apenas um teste.
-- Exs:

-- Teste 5: Dado uma entrada como a seguir, com a coluna da esquerda
-- representando valores e a da direita representando pesos, ler da
-- entrada padrão e tirar a média ponderada dos valores.

-- Entrada:
-- n1 w1
-- n2 w2
-- ...
-- nm wm

main = do
    input <- getContents
    let linhas = lines input
    print $ media linhas

media (x:xs) = media2 (x:xs) 0 0

media2 [] soma div = soma/div   
media2 (x:xs) soma div = 
    let a = words x
        n = read (head a) :: Float
        w = read (last a) :: Float in
    media2 xs (soma + (n * w)) (div + w)
