import time

# Teste 11:
# Decorator para construir um string com linhas para a hora e argumentos e saida de cada chamada da funcao. 
# O string sera acessado via atributo
class logstr:
    def __init__(self,f):
        self.f=f
        self.log = ""
    def __call__(self, *args):
        t = time.asctime()
        
        # Para visualização, se há apenas um argumento, não passa como tupla.
        if len(args) == 1:
            arg = args[0]
        else:
            arg = args
    
        r = self.f(*args)
        self.log+= t + ' ' + "entrada: " + str(arg) + ' ' + "saida: " + str(r) + '\n' 
        return r

@logstr
def f(a,b):
    return 2*a+b
