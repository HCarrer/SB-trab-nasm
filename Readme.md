# Exercícios de NASM
## Integrantes:
- Henrique de Miranda Carrer - 180101951
- João Lucas Sales Aragao - 190015225
- Pedro Henrique de Moura Silva - 190018810
- Roberto Caixeta Ribeiro Oliveira - 190019611

## Exercícios realizados
### Pré-processador
2 - Construa macros para simular o comando switch em C

### Montador NASM
7 - Construa um programa em NASM para ler um arquivo, aplicar um filtro qualquer nele e gravar o arquivo resultante, usando os serviços do S.O.

## Tutoriais
### Pré-processador
Trata-se de um switch case responsável por, dado um número positivo maior que 1, dizer ao usuário qual dia da semana este representa.
Por exemplo:
- 1 = Domingo
- 2 = Segunda
- 3 = Terça
- 4 = Quarta
- 5 = Quinta
- 6 = Sexta
- 7 = Sábado
- 8 = Domingo
- 9 = Segunda
- 10 = Terça
- ...

Para realizar a execução da simulação do comando switch em C, edite o arquivo `switch.asm` localizado no diretório `switch` com o valor desejado na linha ***51***. Em seguida, enquanto no diretório raiz do projeto, execute os seguintes comandos:
- Para limpar os arquivos gerados
```bash
make clean-switch
```

- Para compilar e executar o código
```bash
make run-switch
```

### Montador NASM
Trata-se de um filtro responsável por pegar todos os caracteres de a-z de um arquivo .txt e transformá-los em seus respectivos caracteres em uppercase (A-Z).
Para realizar a execução do filtro, primeiro deve-se alterar o arquivo `text.txt` localizado no diretório `filter` com o texto a ser aplicado o filtro. Em seguida, no diretório raiz do projeto, execute os seguintes comandos:
- Para limpar os arquivos gerados
```bash
make clean-filter
```

- Para compilar e executar o código
```bash
make run-filter
```

## Considerações
O projeto foi criado em plataforma Linux e programado para rodar em nasm versão `2.15.05` ou `2.13.02`.

## Referências
- [x86_64 NASM Assembly Quick Reference ("Cheat Sheet")](https://www.cs.uaf.edu/2017/fall/cs301/reference/x86_64.html)

- Slides de referência disponibilizados no aprender3