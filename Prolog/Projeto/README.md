# Projeto 2 - "Montagem de trechos com interseção"

 <img align = "left" src= https://geneticliteracyproject.org/wp-content/uploads/2018/06/6-20-2018-harnessing-the-human-genome-286123.png width="472" height="310"  hspace="20" vspace="15" alt="Genoma humano">

> ***“Não coloquem Prolog no currículo!”** <br /> ― Wainer, Jacques*

> ***“Em Prolog, não confunda strings com strings, são duas coisas completamente diferentes.”** <br /> ― Ferragut, Daniel*

> ***“Assim que termino o predicado de interseção, descubro um jeito melhor... Bom, hora de refazer.”** <br /> ― Ferrari, Victor*

## Autores
[Daniel Ferragut](https://github.com/danielferragut) e [Victor Ferrari](https://github.com/VFerrari)

## Objetivos
Programa em Prolog que encontra interseções, com tamanho maior ou igual a 4, entre finais e começos de strings.
Unir as strings que possuem interseção, e imprimir o conjunto final de strings.

## Método
Para verificar se duas strings possuem interseções do tipo desejado, é verificado se uma string é prefixo da outra.
Se não for, repete o processo com um caractere a menos.

Isso é feito entre todas as strings da entrada, a fim de juntar o maior número possível de strings, deixando o conjunto final menor.

## Enunciado
O enunciado pode ser encontrado no arquivo `enunciado.html`.

Para visualizar o arquivo como uma página sem baixá-lo, utilize a ferramenta [HTMLPreview](http://htmlpreview.github.io/).

Autor: [Jacques Wainer](https://ic.unicamp.br/~wainer).

## Referências utilizadas
* [Learn Prolog Now!](http://www.learnprolognow.org/) - Livro texto usado para Prolog;
* [Input And Output](http://www.swi-prolog.org/pldoc/man?section=IO) - Manual do SWI-Prolog para I/O;
* [Lists](http://www.swi-prolog.org/pldoc/man?section=lists) - Biblioteca para listas do SWI-Prolog;
* [Strings](http://www.swi-prolog.org/pldoc/man?section=string-predicates) - Predicados para strings.

## Checklist de coisas para fazer
  -  [x] Ler a entrada;
  -  [x] Verificar interseção entre duas strings;
  -  [x] Aplicar a função acima a todas as combinações;
  -  [x] Construir a saída e imprimir a saída.
