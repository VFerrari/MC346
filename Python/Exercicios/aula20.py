# Aula:

# Teste 1 - Funcional
def maxFunc(l):
	max(set(l),key=l.count)

def llog(f):
	def wrapper(*args): 
		print("entrada:",args)
		x = f(*args)
		print("saida:",x)
		return x
	return wrapper

@llog
def aux(x,y):
	return 2*x+y

class decconta:
	def __init__(self,f):
		self.f=f
		self.conta=0
	def __call__(self,*args):
		self.conta += 1
		return self.f(*args)
      
# Exercícios:
# Ex. Aula (Decorators)

# Decorator para imprimir o tempo de execução
import time

def timeFunc(f):
	def wrapper(*args):
		tempo = time.time()
		r = f(*args)
		print (time.time() - tempo)
		return r
	return wrapper

# Decorator para construir um string com linhas para a hora e argumentos e saida de cada chamada da funcao. 
# O string sera acessado via atributo
class strLog:
	def __init__(self,f):
		self.f=f
		self.str = ""
	def __call__(self, *args):
		t = time.localtime()
		
		# Para visualização, se há apenas um argumento, não passa como lista.
		if (len(args) > 1):
			arg = args
		else:
			arg = args[0]
			
		hora = "Hora: " + str(t[3]) + ':' + str(t[4]) + ':' + str(t[5]) + '\n'
		stArg = "Argumentos: " + str(arg) + '\n'
		r = self.f(*args)
		self.str+= hora + stArg + "Saída: " + str(r) + '\n\n' 
		return r

# Decorator para memoizar a funcao. Memoizacao é criar um dicionario 
# que se lembra dos valores de entrada e de saida da funcao ja executado. 
# Se um desses valores de entrada for re-executado, a funcao nao sera re-executada - 
# ela apenas retorna o valor de saida memoizado
# Poderia ser feita usando função em vez de classe.
class memoizator:
	def __init__(self,f):
		self.f = f
		self.dic = {}
	def __call__(self,*args):
		arg = *args,						# Tupla, para memoização de múltiplos argumentos
		if arg in self.dic:
			return self.dic[arg]
		else:
			self.dic[arg] = self.f(*args)
			return self.dic[arg]

# Decorator para log argumentos e horario num arquivo (append no arquivo) dado como argumento do decorator.
# Recebe só nome do arquivo, o abre e fecha em uma execução.
# Poderia receber o arquivo aberto, e não fechá-lo (flush)
def logFile(name):
	def wrapper1(func):
		def wrapper2(*args):
			fil = open(name,"a")
			t = time.localtime()
			
			# Visualização, se há apenas um argumento, não passa como lista.
			if (len(args) > 1):
				arg = args
			else:
				arg = args[0]
				
			r = func(*args)				
			hora = "Hora: " + str(t[3]) + ':' + str(t[4]) + ':' + str(t[5]) + '\n'
			st = hora + "Argumentos: " + str(arg) + '\n' + "Saída: " + str(r) + '\n\n' 
			fil.write(st)
			fil.close()
			
			return r
		return wrapper2
	return wrapper1
	
# Aplicando os decorators feitos:

# Função exemplo, recursiva memoizada.
@memoizator
def fibonacci(n):
	if n < 2:
		return n
	else:
		return fibonacci(n-1)+fibonacci(n-2)

# Função exemplo, com log em arquivo, memoizada.
# Note que se os decorators estivessem em ordem trocada, resultados memoizados não são registrados
@logFile("log.txt")
@memoizator
def soma(a,b):
	return a+b


# Programação funcional em Python:

# Função exemplo, funcional, com log em arquivo e mostrando tempo de execução.
from functools import reduce
from operator import getitem

@logFile("logFunc.txt")
@timeFunc
def somaL(l): return reduce(lambda x,y : x+y, l)

# Função exemplo funcional, com log em string e mostrando tempo de execução
# Soma elementos nas posições pares de uma lista (começando em 1), pouco legível (saudades de Haskell)
# acc = (res,pos)
# Acessar string: somaPPar.str
@strLog
def somaPPar(l): return getitem(reduce((lambda acc, x : (acc[0]+x,acc[1]+1) if acc[1] % 2 == 0 else (acc[0],acc[1]+1)), l, (0,1)),0)
