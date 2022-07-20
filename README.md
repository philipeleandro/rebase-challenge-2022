# Rebase Challenge 2022

API em Ruby para listagem de exames médicos.

## Requisitos

* Docker
* Ruby

## Primeira Run 
Caso seja a primeira vez que esteja fazendo o clone e tendo contato com a aplicação, rode os seguintes comandos:

### Clone do repositório:
```bash
$ git clone git@github.com:philipeleandro/rebase-challenge-2022.git
$ cd rebase-challenge-2022
```

### Cria network:
```bash
$ docker network create rebase-challenge
```

### Cria container do Postgres:
```bash
$ docker run --name postgres -d -v pgdata:/var/lib/postgresql/data --network rebase-challenge -e POSTGRES_PASSWORD=password -d postgres
```

### Roda script que cria container do Redis, Sidekiq e Aplicação:
```bash
$ bash run
```

### Sobe o servidor da aplicação:
```ruby
ruby server.rb
```

## Outra run
Caso não seja a primeira vez que esteja rodando a aplicação e já tenha criado a rede posteriormente, assim como o container do postgres. Siga os passos:

### Entre na pasta da aplicação:
```bash
$ cd rebase-challenge-2022
```

### Inicia container do postgres:
```bash
$ docker start postgres
```
### Roda script que cria container do Redis, Sidekiq e Aplicação:
```bash
$ bash run
```

### Sobe o servidor da aplicação:
```ruby
ruby server.rb
```

## Funcionalidades

### Importa dados CSV para o banco de dados por meio de comando:
A aplicação pode popular o banco de dados Postgres através um arquivo csv com o caminho`./data.csv` na pasta da API. Rodando os seguintes comandos, pode-se importar os dados do arquivo para o banco de dados.

Após rodar o comando que cria o container da aplicação, redis e sidekiq, tanto na primeira run, quanto em outra vez rodando, **antes de subir o servidor da aplicação**, dentro da pasta raiz, rode o comando:

```ruby
ruby './helper/import_from_csv.rb'
```

Logo após terminar de popular o banco de dados, pode-se subir o servidor e acessar o endpoint `/tests`, no qual lê dados do banco de dados e renderiza no formato JSON.

```ruby
ruby server.rb
```

Depois de subir o servidor, digite a URL `http://localhost:3000/tests`

### Popula o banco de dados de forma assíncrona por meio de endpoint que recebe um CSV no HTTP request

Com o servidor levantado e todos os containers em funcionamento, o usuário da API pode realizar um `POST` para o endpoint `/import` passando o arquivo CSV no request para atualizar os dados.

Exemplo utilizando o Insomnia:
![image](https://user-images.githubusercontent.com/92264330/179831630-ba737014-7426-4238-bfca-c7ae332a2c14.png)


### Endpoint para mostrar os detalhes de um exame médico

Depois de ter populado o banco de dados através do comando `ruby './helper/import_from_csv.rb` ou por meio do POST no endpoint `/import` passando o arquivo CSV no HTTP request, pode-se verificar os detalhes dos exames médicos no formato JSON.

O endpoint `/tests/:token` permite que o usuário da API, ao fornecer o token do exame, possa ver os detalhes daquele exame no formato JSON, tal como está implementado no endpoint `/tests`. A consulta deve ser feita na base de dados.

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
