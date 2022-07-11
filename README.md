# Rebase Challenge 2022

API para listagem de exames médicos.

```bash
$ bash run
$ open http://localhost:3000/tests
```

## Desafio 1: Importar os dados do CSV para um database SQL

Esta API tem apenas um endpoint `/tests` que lê os dados de um arquivo CSV e renderiza no formato JSON. Você pode _modificar_ este endpoint para que, ao invés de ler do CSV, faça a leitura **diretamente de
uma base de dados SQL**.

### Script para importar os dados

Este desafio de "importar" os dados do CSV para um **database SQL** (por ex. PostgreSQL), pode ser feita com um script Ruby simples ou **rake** task, como preferir.

Idealmente deveríamos ser capazes de rodar o script:
```bash
$ ruby import_from_csv.rb
```
E depois, ao consultar o SQL, os dados deveriam estar *populados*.

* _Dica 1_: consultar o endpoint `/tests` para ver como é feita a leitura de um arquivo CSV
* _Dica 2_: utilizar um container para a API e **outro container** para o PostgreSQL. Utilize **networking** do `Docker` para que os 2 containers possam conversar entre si
* _Dica 3_: comandos SQL -> `DROP TABLE`, `INSERT INTO`

### Modificar endpoint /tests

O resultado atual que o endpoint traz ao fazer a leitura do CSV, deve ser o mesmo quando modificarmos para ler direto do database.

* _Dica 1_: primeiramente, separar o código que busca os dados em uma classe Ruby separada, pois além de ser mais fácil para testar, facilita o refactoring para quando fizermos a leitura direto do database SQL
* _Dica 2_: testar primeiro as queries SQL direto no database, `SELECT` etc. Depois utilizar um **driver** para o PostgreSQL para que a app Ruby saiba "conversar" com o database. Ferramentas: `pgAdmin4` para fazer queries no PostgreSQL, gem `pg` para utilizar na app Ruby.

## Desafio 2: Criar endpoint para importar os dados do CSV de forma assíncrona

Com o desafio 1 completo, fazemos o import através de um script. Mas este script tem que ser executado por alguém developer ou admin do sistema.

Idealmente, qualquer usuário da API poderia querer chamar um endpoint para atualizar os dados. Assim, o ednpoint aceita um arquivo CSV dinâmico e importa os dados para o PostgreSQL.

Exemplo:
```bash
$ POST /import
```

### Implementar endpoint para receber um CSV no HTTP request

Neste passo, devemos focar apenas em receber o CSV via HTTP e utilizar o mesmo código do script de import para popular o database.

* _Dica 1_: receber o conteúdo do CSV no HTTP request body ou então apenas o caminho para o CSV no servidor, o que for mais cômodo para você nesta fase
* _Dica 2_: pode usar a ferramenta `Postman` para testar os pedidos HTTP
* _Dica 3_: nesta fase, ainda fazer o processo "síncrono", ou seja, o usuário que chamar o endpoint `POST /import` deve ficar à espera

### Executar o import do endpoint de forma assíncrona em background

Uma vez que fizemos o endpoint de `POST /import`, agora vamos focar numa implementação que permita que o usuário não fique _à espera_, ou seja, executar em um **background job**, mesmo o usuário sabendo que
não vai ficar pronto imediatamente. Neste caso, o processo de import fica pronto **eventualmente**.

* _Dica 1_: utilizar o `Sidekiq` para o processamento assíncrono
* _Dica 2_: o Sidekiq roda em um container separado da API
* _Dica 3_: subir um container para a visualização "Web" das filas do Sidekiq

## Desafio 3: Criar endpoint para mostrar os detalhes de um exame médico

Implementar o endpoint `/tests/:token` que permita que o usuário da API, ao fornecer o token do exame, possa ver os detalhes daquele exame no formato JSON, tal como está implementado no endpoint
`/tests`. A consulta deve ser feita na base de dados.

### Exemplo
Request:
```bash
GET /tests/T9O6AI
```

Response:

```json
{
   "result_token":"T9O6AI",
   "result_date":"2021-11-21",
   "cpf":"066.126.400-90",
   "name":"Matheus Barroso",
   "email":"maricela@streich.com",
   "birthday":"1972-03-09",
   "doctor": {
      "crm":"B000B7CDX4",
      "crm_state":"SP",
      "name":"Sra. Calebe Louzada"
   },
   "tests":[
      {
         "type":"hemácias",
         "limits":"45-52",
         "result":"48"
      },
      {
         "type":"leucócitos",
         "limits":"9-61",
         "result":"75"
      },
      {
         "test_type":"plaquetas",
         "test_limits":"11-93",
         "result":"67"
      },
      {
         "test_type":"hdl",
         "test_limits":"19-75",
         "result":"3"
      },
      {
         "test_type":"ldl",
         "test_limits":"45-54",
         "result":"27"
      },
      {
         "test_type":"vldl",
         "test_limits":"48-72",
         "result":"27"
      },
      {
         "test_type":"glicemia",
         "test_limits":"25-83",
         "result":"78"
      },
      {
         "test_type":"tgo",
         "test_limits":"50-84",
         "result":"15"
      },
      {
         "test_type":"tgp",
         "test_limits":"38-63",
         "result":"34"
      },
      {
         "test_type":"eletrólitos",
         "test_limits":"2-68",
         "result":"92"
      },
      {
         "test_type":"tsh",
         "test_limits":"25-80",
         "result":"21"
      },
      {
         "test_type":"t4-livre",
         "test_limits":"34-60",
         "result":"95"
      },
      {
         "test_type":"ácido úrico",
         "test_limits":"15-61",
         "result":"10"
      }
   ]
}
```

* _Dica_: consultar no database SQL com `SELECT` e depois, trabalhar em cima dos dados de resposta **antes** de renderizar o JSON