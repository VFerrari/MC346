import random

# Teste 12 (sem certeza de corretude):
# Dado um iterator e um inteiro k, retorna um iterator com 1-k elementos
# Feito de modo probabilístico, com cada elemento tendo prob. 1/k de ser retornado.
# Para isso, gera um inteiro em [0,k), e se for 0 (prob. 1/k) adiciona ao novo iterator.
def kesino(x,k):
    l=[]
    try:
        while True:
            r = random.randrange(k)
            if r == 0:
                l.append(next(x))
            else:
                next(x)
    except StopIteration:
        return iter(l)
