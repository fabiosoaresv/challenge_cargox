# CargoX Coding Challenge - Projeto ADM

## Problema

O conglomerado CargoX Corp. adquiriu algumas companhias menores e precisamos construir uma aplicação para cadastrar todos os funcionários de cada empresa.

As relações e atributos seguem o seguinte diagrama:

```
+-------------+ *      1 +--------------+ 1      1 +-------------+
|   Company   +----------+   Fundador   +----------+    Lider    |
|             |          |              |          |             |
|  nome       |          |  nome        |          |  nome       |
|  CNPJ       |          |  sobrenome   |          |  sobrenome  |
|  fundação   |          |  idade       |          |  idade      |
|             |          |              |          |  área       |
+-------------+          +--------------+          |             |
                                                   +------+------+
                                                          | 1
                                                          |
                                     +--------------------+
                                     |
                                   * |
                            +--------+--------+
                            |   Coordenador   |
                            |                 |
                            |  nome           |
                            |  sobrenome      |
                            |  idade          |
                            |  contratado em  |
                            |                 |
                            +-+-------------+-+
                              |             |
                            1 |             | 1
                              |             |
                              |             |
                            * |             | *
            +-----------------+----+   +----+-----------------+
            |   Empregado Júnior   |   |   Empregado Sênior   |
            |                      |   |                      |
            |  nome                |   |  nome                |
            |  sobrenome           |   |  sobrenome           |
            |  idade               |   |  idade               |
            |  em experiência?     |   |  salário             |
            |  salário             |   |  em experiência?     |
            |                      |   |                      |
            +----------------------+   +----------------------+

```

## Tarefa

1. Construir uma API **utilizando JSON API** para que seja possível criar, consultar, alterar e remover (CRUD) os recursos:
  - Company
  - Fundador
  - Líder
  - Coordenador
  - Empregado Júnior
  - Empregado Sênior

2. Disponibilizar rota para consulta de um `sumário` da companhia com os seguintes dados:
  - nome da companhia
  - CNPJ
  - nome do Fundador
  - número total de funcionários
  - número total de líderes
  - número total de coordenadores
  - número total de empregados sênior
  - número total de empregados júnior

OBS: As companhias devem ser ordenadas em ordem **crescente** por: `nome`, `nome do fundador`, `número de funcionários`

3. Disponibilizar uma rota para contratação de novos empregados (Júnior ou Sênior) que receba os seguintes parâmetros:
   - nome
   - sobrenome
   - idade
   - salário
   - nível (júnior ou sênior)

4. Documentação das rotas e exemplos de `curl` para teste da API. No caso de
   utilizar `GraphQL`, adicionar o painel `graphiql` para teste e documentação
   das queries e mutations.

## Diferenciais

1. Construção de um painel front-end que implemente criação, edição, consulta e
   remoção de **cada um dos recursos** citados (Fundador, Líder, etc). O painel
   não precisa ser bonito, somente funcionar. Aqui na CargoX utilizamos `VueJS`,
   mas sinta-se à vontade para escolher a biblioteca ou framework que mais lhe
   agrade
2. Construir a API utilizando `GraphQL`
