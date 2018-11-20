# Projeto 3 - "Uber Pool"

 <img align = "left" src= https://ds055uzetaobb.cloudfront.net/image_optimizer/2451bee741e6bfbaed46c34be07fa696fd2663ed.png height=200 width=400 alt="Floyd-Warshall">

> ***“Não se preocupem com os espaços.”** <br /> ― Wainer, Jacques*

> ***“Faço esse projeto em algumas horas!”** <br /> ― Ferragut, Daniel*

> ***“Então é tipo o projeto 1?”** <br /> ― Ferrari, Victor*

## Autores
[Daniel Ferragut](https://github.com/danielferragut) e [Victor Ferrari](https://github.com/VFerrari)

## Objetivos
Encontrar lista de percursos propostos, tal que no máximo dois passageiros farão uma viagem compartilhada.
Para essa lista, será escolhido o par de passageiros cujo percurso terá mínima inconveniência máxima, não ultrapassando 1.4.
É possível que passageiros tenham viagens individuais.

Inconveniência é a razão entre o tempo total da viagem de um passageiro com carona e o tempo da viagem sem carona.
É possível que uma viagem já esteja em andamento. Nesse caso, a inconveniência para o passageiro que já está em viagem
é calculada a partir do ponto atual.

Modelagem por meio de grafo.

## Método
Primeiro, o grafo é lido como uma matriz de adjacências, pois as operações são favoráveis a essa representação.
Feito isso, os custos dos menores caminhos entre todos os vértices são calculados. Para isso, é usado o algoritmo Floyd-Warshall.

Com os custos, é calculada a menor inconveniência entre todas as combinações de passageiros. Para isso, é calculada
a maior inconveniência relacionada a um percurso entre os dois passageiros, e é tomada a menor entre os dois percursos.
Se o resultado for maior que 1.4, uma carona não vale a pena.

Com a lista resultante de inconveniências entre passageiros e percursos (que é ordenada crescentemente), as viagens são
divididas em dois grupos: com carona e diretas. Apenas uma viagem por passageiro é tomada, e uma estratégia gulosa foi
usada. As viagens que não possuem inconveniência menor que o limite com outro passageiro que ainda não foi escolhido
serão diretas.

Finalmente, os passageiros e percursos de cada viagens são colocados na saída padrão. Os números dos passageiros são
definidos pela ordem na entrada. O percurso não é o caminho inteiro percorrido, mas apenas os vértices inicial e final
de cada passageiro, na ordem escolhida.

Casos específicos (viagens em andamento, origem de um passageiro = destino de outro, etc) e mais informações podem ser
encontradas nos comentários do código (arquivo `uber.py`).

## Reconstrução de Caminho
O script principal (arquivo `uber.py`) não realiza reconstrução de caminho no grafo para verificar todo o percurso, como
descrito na seção anterior. Porém, uma versão incompleta do mesmo, porém com reconstrução de caminho, pode ser encontrada
no outro script (arquivo `uberPathRec.py`).

Nele, a saída é a mesma (possivelmente há bugs), porém seguida de uma lista com os caminhos completos entre todos os vértices
do percurso, reconstruído a partir de uma matriz de predecessores feita no algoritmo Floyd-Warshall.

## Testes
Este projeto possui testes com saídas esperadas, ao contrário dos outros. Como o número de arquivos foi duplicado,
eles se encontram na pasta `Testes`.

## Enunciado
O enunciado pode ser encontrado no arquivo `enunciado.html`.

Para visualizar o arquivo como uma página sem baixá-lo, utilize a ferramenta [HTMLPreview](http://htmlpreview.github.io/).

Autor: [Jacques Wainer](https://ic.unicamp.br/~wainer).

## Referências utilizadas
* [Python 3.7.1 Documentation](https://docs.python.org/3/index.html) - Documentação do Python 3.7.1;
* [Floyd-Warshall](https://en.wikipedia.org/wiki/Floyd%E2%80%93Warshall_algorithm) - Algoritmo para cálculo de caminhos mínimos todos-para-todos;
* [Collections](https://docs.python.org/3/library/collections.html) - Biblioteca para dicionários do Python.

## Checklist de coisas para fazer
  -  [x] Ler a entrada e construir o grafo como matriz de adjacências;
  -  [x] Algoritmo Floyd-Warshall para todos caminhos mínimos;
  -  [x] Calcular inconveniência entre todos pares e caminhos;
  -  [x] Filtrar viagens (diretas e caronas).
  -  [x] Imprimir a saída.
