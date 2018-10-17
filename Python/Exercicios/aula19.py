# Aula:
class Pessoa:
    npernas = 2
    def __init__(self,idade,nome):
        if idade>0:
            self.idade=idade
            self.nome=nome
            
    def setidade(self,x):
       if x >0 :
         self.idade=x

    def getidade(self):
        return self.idade

class Aluno(Pessoa):
   pass

class Repetidor:
   def __init__(self,x,n=4):
      self.n=n
      self.x=x
   def __iter__(self):
      return self
   def __next__(self):
      if self.n<=0: 
         raise StopIteration
      else:
         self.n-=1
         return self.x
         
def rep(x,n=4):
    while n>0:
        n-=1
        yield x
        
def filtro(padrao,proximo):
    print("Comecando filtro")
    while True:
        msg = (yield)
        if padrao in msg:
            proximo.send(msg)
     

def consumidor():
    print("Comecando consumidor")
    while True:
        l=(yield)
        print(l)

