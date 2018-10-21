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

# Exercicios:
# Dado um iterator, retorna um iterator com os elementos nas posicoes pares (0,2)
def pares(it):
	l=[]
	
	try:
		while(True):
			a = next(it)
			l.append(a)
			next(it)
	except StopIteration:
		return iter(l)

# Reverte um iterator
def reverte(it):
	l=list(it)
	l.reverse()
	return iter(l)

# Reverte um iterator (2, mais eficiente e menos elegante)
def reverte2(it):
	l=[]
	try:
		while(True):
			l.insert(0,next(it))
	
	except StopIteration:
		return iter(l)

# Dado 2 iterators, retorna um iterator que retorna os elementos intercalados
def zip(it1,it2):
	l=[]
	try:
		while(True):
			l.append(next(it1))
			l.append(next(it2))
			
	except StopIteration:
		return iter(l)

# Dado 2 iterators, retorna um iterator com o produto cartesiano dos elementos
def cart(it1, it2):
	l=[]
	
	try:
		while(True):
			a = next(it1)*next(it2)
			l.append(a)
		
	except StopIteration:
		return iter(l)
		
# Dado um iterator, retorna os elementos num ciclo infinito
def ciclo(it):
	l=list(it)
	t=len(l)
	curr=0
	while(True):
		yield l[curr%t]
		curr+=1

# Retorna um iterator que gera numeros de init ate infinito, com passo
def rangeinf(init, step=1):
	j=0
	while(True):
		yield init+j
		j+=step

# Pega os primeiros n elementos de uma lista
def take(l,n):
	return l[:n]

# Elimina os primeiros n elementos de uma lista
def drop(l,n):
	return l[n:]
