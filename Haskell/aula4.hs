-- Aula:

let a = [1..]
take 3 a
let b = drop 5 a
let {double [] = [] ; double (x:xs) = (2*x):(double xs)}
let c = double b
let d = double (take 1 c)
d

-- Exs:
-- Não tem ...
