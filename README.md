# CargoX Coding Challenge - ADM Project

## Problem

The conglomerate CargoX Corp. acquired some smaller companies and we need to build an application to register all the employees of each company.

The relationships and attributes follow the following diagram:

```
+-------------+ *      1 +--------------+ 1      1 +-------------+
|   Company   +----------+   Foundator  +----------+    Lead     |
|             |          |              |          |             |
|  name       |          |  name        |          |  name       |
|  CNPJ       |          |  surname     |          |  surname    |
|  foundation |          |  age.        |          |  age.       |
|             |          |              |          |  area       |
+-------------+          +--------------+          |             |
                                                   +------+------+
                                                          | 1
                                                          |
                                     +--------------------+
                                     |
                                   * |
                            +--------+--------+
                            |   Coordinator   |
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
            |   Junior Employee    |   |   Senior Employee    |
            |                      |   |                      |
            |  name                |   |  name                |
            |  surname             |   |  surname             |
            |  age.                |   |  age                 |
            |  age.                |   |  salary              |
            |  experience period?  |   |  experience period?  |
            |                      |   |                      |
            +----------------------+   +----------------------+

```

## Tasks

Task 1. Build an API **using JSON API** so that you can create, query, change and remove (CRUD) resources:
   - Company
   - Founder
   - Leader
   - Coordinator
   - Junior Employee
   - Senior Employee

#### Solution for Task 1:
- Mutations (app/graphql/mutations) and Queries (app/graphql/queries) were created in GraphQL to solve the part of this CRUD.
- Then I took advantage of the CRUD made in GraphQL and used a client to be able to consume the Project API, where I made a Service since at various times I would need to use the API (app/services/client_graphql.rb)
- To test CRUD by GraphQL, you can upload the project with Docker or locally, and access the url http://localhost:3000/graphiql and make the mutations/queries, examples:

*Mutation for create a um Foundator:*
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

*Query to search all Foundators:*
```ruby
query {
  fetchFoundators {
    name
    surname
    age
  }
}
```

Task 2. Provide a route for consulting a `summary` of the company with the following data:
  - name of company
  - CNPJ
  - Foundators name
  - number totally employees
  - number totally leads
  - number totally coordinators
  - number totally senior employees
  - number totally junior  employees

Note: Companies should be sorted in **ascending** order by: `name`, `founder name`, `number of employees`

#### Solution for Task 2:
I created a report by extracting the information above. The same was resolved in the files:
- app/controllers/reports_controller.rb
- app/views/reports/index.html.erb

Note: I chose to use ActiveRecord to perform the queries instead of the API.

Task 3. Provide a route for hiring new employees (Junior or Senior) that receives the following parameters:
   - name
   - surname
   - age
   - salary
   - level (junior or senior)

#### Solution for Task 3:
I did available a registration screen for each Endpoint, for Employees it is possible to find the code at:
- app/controllers/employees_controller.rb
- app/views/employees

Task 4. Route documentation and `curl` examples for API testing. If using `GraphQL`, add the `graphiql` panel for testing and documenting queries and mutations.

#### Solution for Tarefa 4:
As I used the GraphQL and Graphiql-Rails gems it is possible to consult all queries and mutations in the Documentation of the page http://localhost:3000/graphiql
- Examples of API consumption via with `cURL`:

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

## Differentials

1. Construction of a front-end panel that implements creation, editing, consultation and removal of **each one of the mentioned resources** (Founder, Leader, etc). The panel doesn't have to be pretty, just work. Here at CargoX we use `VueJS`, but feel free to choose the library or framework that suits you best.

#### Solution for ifferential:
`done :D`
As said before, I did a front with Rails for all endpoints.

2. Construir a API utilizando `GraphQL`
`done :D`

## My final considerations
- I use docker in the project :)

To use docker just run the commands:
Note.: check the config/database.yml if you are NOT using docker, you must change the host/password.
```console
$ docker-compose build
$ docker-compose up -d
$ docker-compose run web bundle exec rails db:create db:migrate db:seed
```

Or to run the project locally without docker, just clone and run:
```console
$ bundle install && bundle exec rails db:drop db:create db:migrate db:seed && rails s
```
Evidence of the unit specs:
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

[  9:38PM ]  [ fsoares@pyhooma:~/Documents/projects/challenge_cargox(master✗) ]
 $ rspec /home/fsoares/Documents/projects/challenge_cargox/spec/graphql/queries/fetch_companies_spec.rb
...

Finished in 0.17558 seconds (files took 3.3 seconds to load)
3 examples, 0 failures

[  9:38PM ]  [ fsoares@pyhooma:~/Documents/projects/challenge_cargox(master✗) ]
 $ rspec /home/fsoares/Documents/projects/challenge_cargox/spec/graphql/queries/fetch_company_spec.rb
...

Finished in 0.09309 seconds (files took 1.14 seconds to load)
3 examples, 0 failures
```

## Improvements I would do to this app:
- Add validations in CNPJ, mandatory fields, name, surname, etc.
- API authentication.
- Improved views.
- Deploy on Heroku.
- CI (Buddy/SemaphoreCI/CircleCI)
- Helpers.
- Factories.
- Etc.

## Versões utilizadas:
`ruby 2.6.3p62`
`docker-compose version 1.25.5`
`Debian GNU/Linux 10 (buster)`
`psql (PostgreSQL) 9.6.19`

Note: during application execution and manual testing, use the delete feature for last / because if you delete any record that is related to another, the update/creation will fail depending on the context.
