# Projeto 3 - "Uber Pool"

 <img align = "left" src= https://ds055uzetaobb.cloudfront.net/image_optimizer/2451bee741e6bfbaed46c34be07fa696fd2663ed.png alt="Genoma humano">

> ***“Python nunca esteve tão ELEGANTE.”** <br /> ― Wainer, Jacques*

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

## Enunciado
O enunciado pode ser encontrado no arquivo `enunciado.html`.

Para visualizar o arquivo como uma página sem baixá-lo, utilize a ferramenta [HTMLPreview](http://htmlpreview.github.io/).

Autor: [Jacques Wainer](https://ic.unicamp.br/~wainer).

## Referências utilizadas
* [Python 3.7.1 Documentation](https://docs.python.org/3/index.html) - Documentação do Python 3.7.1;

## Checklist de coisas para fazer
  -  [ ] Ler a entrada e construir o grafo;
  -  [ ] Algoritmo Floyd-Warshall para todos caminhos mínimos;
  -  [ ] Achar menor inconveniência dentre todos pares;
  -  [ ] Estender para viagens em andamento; 
  -  [ ] Aplicar todas as vezes;
  -  [ ] Construir a saída e imprimir a saída.
