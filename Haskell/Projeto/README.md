# Projeto 1 - "Waze Para Transporte Público"

 <img align = "left" src= https://www.baeldung.com/wp-content/uploads/2017/01/initial-graph.png width="456" height="190"  hspace="40" vspace="5" alt="Borin Png">

> ***“Precisamos subir o nível de elegância!”** <br /> ― Wainer, Jacques*

> ***“Haskell: a única linguagem onde é mais fácil implementar um dicionário como fila de prioridades do que um heap.”** <br /> ― Ferragut, Daniel*

> ***“Posso comentar? Mudar os nomes? Refazer o código?”** <br /> ― Ferrari, Victor*

## Autores
[Daniel Ferragut](https://github.com/danielferragut) e [Victor Ferrari](https://github.com/VFerrari)

## Objetivos
Programa em Haskell que calcula o caminho mais rápido entre uma origem e um destino dado usando uma combinação de caminhar e usar transporte público.

Modelagem por meio de grafo, e o menor caminho entre dois pontos (um para um).
Retorna o melhor caminho, o modo de chegar a cada ponto, e o tempo total gasto.
## Método
Para calcular o caminho mínimo, foi utilizado o Algoritmo de Djikstra.

Como o algoritmo é aplicado em grafos simples, o grafo foi modelado de modo a ser simples.
Para isso, cada vértice foi representado como uma tupla de duas strings (nome e modo).
Cada modo de transporte foi assim transformado em um "plano" diferente, com apenas os vértices alcançáveis pela linha, assim removendo a necessidade de arestas múltiplas entre vértices.
O custo de entrar em um desses planos é metade do período do modo (dado na entrada), e o custo de saída é zero.

O grafo foi modelado como uma lista de adjacências, mas com estrutura de dicionários.
Isso foi interessante pois possibilitou o uso de muitas funções prontas na biblioteca Data.Map.Strict.

Mais informações podem ser vistas nos comentários do código (arquivo `waze.hs`).
## Enunciado
O enunciado pode ser encontrado no arquivo `enunciado.html`.

Para visualizar o arquivo como uma página sem baixá-lo, utilize a ferramenta [HTMLPreview](http://htmlpreview.github.io/).

Autor: [Jacques Wainer](https://ic.unicamp.br/~wainer).

## Referências utilizadas
* [Learn You Haskell](http://learnyouahaskell.com/chapters) - Livro texto usado para Haskell
* [Algoritmo de Djikstra](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm) - Famoso algoritmo para cálculo de caminhos mínimos em grafos simples.
* [Data.Map.Strict](http://hackage.haskell.org/package/containers-0.6.0.1/docs/Data-Map-Strict.html) - Biblioteca de dicionários padrão da linguagem.

## Coisas que restam fazer.
  -  [x] Definir o tipo do grafo;
  -  [x] Ler o grafo e as características;
  -  [x] Modelar o grafo para simples implementação do algoritmo de Djikstra;
  -  [x] Implementar o algoritmo de Djikstra;
  -  [x] Encontrar o caminho e imprimir resposta.
