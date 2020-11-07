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

## Solução para a Tarefa 1:
- Fora criadas as Mutaçãoes (app/graphql/mutations) e Queries (app/graphql/queries) no GraphQL para resolver a parte deste CRUD.
- Na sequência aproveitei o CRUD feito no GraphQL e utilizei um client para poder consumir a API do Projeto, onde fiz um Service já que em vários momentos precisaria utilizar a API (app/services/client_graphql.rb)
- Para testar o CRUD pelo GraphQL, você pode subir o projeto com Docker ou localmente, e acessar a url http://localhost:3000/graphiql e fazer as mutações/queries, exemplos:

*Mutation para criar um Foundator:*
```ruby
mutation {
  addFoundator(input: { params: { name: "Fabio", surname: "Soares", age: 23 }}) {
    foundator {
      name
      surname
      age
    }
  }
}
```

*Query para consultar todos Foundators:*
```ruby
query {
  fetchFoundators {
    name
    surname
    age
  }
}
```

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

## Solução para a Tarefa 2:
Criei um relatório extraindo as informações acima. O mesmo foi resolvido nos arquivos:
- app/controllers/reports_controller.rb
- app/views/reports/index.html.erb

Obs.: optei em utilizar o ActiveRecord para realizar as consultas ao invés da API.

3. Disponibilizar uma rota para contratação de novos empregados (Júnior ou Sênior) que receba os seguintes parâmetros:
   - nome
   - sobrenome
   - idade
   - salário
   - nível (júnior ou sênior)

## Solução para a Tarefa 3:
Disponibilizei uma tela de cadastro para cada Endpoint, para os Funcionários é possível encontrar o código em:
- app/controllers/employees_controller.rb
- app/views/employees

4. Documentação das rotas e exemplos de `curl` para teste da API. No caso de
   utilizar `GraphQL`, adicionar o painel `graphiql` para teste e documentação
   das queries e mutations.

## Solução para a Tarefa 4:
Como utilizei as gem's GraphQL e Graphiql-Rails é possível consultar todas queries e mutações na Documentação da página http://localhost:3000/graphiql
- Exemplos de consumo da API via `cURL`:

Queries
```curl
curl -i -H 'Content-Type: application/json' -X POST -d '
  {
    "query": "query {fetchFoundators { name surname age }}"
  }' http://localhost:3000/graphql
```

Mutations
```curl
curl -H "Content-Type: application/json" -X POST -d '
  {
    "query": "mutation { addFoundator(input: { params: { name: \"Fabio\", surname: \"Soares\", age: 23 }}) { foundator { name surname age } } }"
  }' http://localhost:3000/graphql
```

## Diferenciais

1. Construção de um painel front-end que implemente criação, edição, consulta e
   remoção de **cada um dos recursos** citados (Fundador, Líder, etc). O painel
   não precisa ser bonito, somente funcionar. Aqui na CargoX utilizamos `VueJS`,
   mas sinta-se à vontade para escolher a biblioteca ou framework que mais lhe
   agrade

## Solução para o Diferencial 1:
Conforme dito anteriormente, contrui um front (em Rails pois não tenho muito domínio em Front) para todos os endpoints.

2. Construir a API utilizando `GraphQL`
`done xD`

## Considerações finais
Achei um desafio bem bacana, tendo em vista que eu nunca havia mexido em GraphQL então, precisei dar uma estudada, mas compreendi como funciona.

Achei um pouco pesado o tamanho do CRUD, acredito que apenas a relação de 3 models já bastaria para fazer um projeto bacana.

- Fiz alguns specs unitários de mutations, queries e integração, apenas não fiz todos pois o contexto seria o mesmo.
- "Dockerizei" o projeto :)
- Não coloquei autenticação na API por token pois estava tendo algumas dificuldades, e meu prazo de finalização do projeto já estava quase acabando.
- Como adicionei uns specs mais complexos das queries e mutações, optei em não fazer o de controllers/models.
- Não tenho muito domínio em spec de integração, porém tenho noção, adicionei uma base de um spec de integração mas não consegui concluí-lo devido a minha stack ter um client, fiquei um pouco block nos mocks e configuração local da minha máquina do Capybara.

Para utilizar o docker basta rodar os comandos:
Obs.: dê um check no config/database.yml caso NÃO for utilizar docker, deverá alterar o host.
```console
$ docker-compose build
$ docker-compose up -d
$ docker-compose run web bundle exec rails db:create db:migrate db:seed
```

Ou para rodar o projeto localmente sem docker, basta clonar e rodar:
```console
$ bundle install && bundle exec rails db:drop db:create db:migrate db:seed && rails s
```
Evidência dos specs unitários passando:
```console
[  9:38PM ]  [ fsoares@pyhooma:~/Documents/projects/challenge_cargox(master✗) ]
 $ rspec /home/fsoares/Documents/projects/challenge_cargox/spec/graphql/mutations/companies/add_company_spec.rb
...

Finished in 0.08713 seconds (files took 0.97256 seconds to load)
3 examples, 0 failures

[  9:38PM ]  [ fsoares@pyhooma:~/Documents/projects/challenge_cargox(master✗) ]
 $ rspec /home/fsoares/Documents/projects/challenge_cargox/spec/graphql/mutations/companies/remove_company_spec.rb
...

Finished in 0.08302 seconds (files took 0.94206 seconds to load)
3 examples, 0 failures

[  9:38PM ]  [ fsoares@pyhooma:~/Documents/projects/challenge_cargox(master✗) ]
 $ rspec /home/fsoares/Documents/projects/challenge_cargox/spec/graphql/mutations/companies/update_company_spec.rb
...

Finished in 0.10011 seconds (files took 0.95889 seconds to load)
3 examples, 0 failures
```

## Melhorias que eu faria no app:
- Tratamento de dados exemplo validar se o CNPJ é válido, se os campos obrigatórios estão preenchidos, nome, sobrenome, etc.
- Autenticação da API.
- Melhoria nas views.
- Etc.

## Versões utilizadas:
`ruby 2.6.3p62`
`docker-compose version 1.25.5`
`Debian GNU/Linux 10 (buster)`
`psql (PostgreSQL) 9.6.19`

Observação: durantes a execução da aplicação e testes manuais, deixe a parte de deletar por último / pois se você deletar algum registro que tenha relação com outro, o update/criação irá falhar dependendo do contexto.
