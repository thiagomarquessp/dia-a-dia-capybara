# Usando planilhas como base de dados para sua automação

Faz algum tempo que uma pessoa me indagou sobre a possibilidade de ter que utilizar informações que estão dentro de planilhas excel e queria saber como que poderia fazer isso de forma automática, e me lembrei que lá atrás quando comecei a automatizar testes, usava planilhas csv para que eu pudesse extrair os dados e utilizar em algum lugar, ou como quem gosta de nomes e termos para as coisas, é o nosso famoso Data Driven. Tem algumas maneiras de se fazer isso usando o próprio selenium, mas nas minhas andanças e hábitos "rubysticos" encontrei uma gem que faz esse trabalhinho maroto de forma elegante.

A gem em questão é [essa](https://github.com/roo-rb/roo) e é muito simples de utilizar, e criei uma estrutura básica de cucumber para explicar, assim como tem uma planilha que contém duas células contendo usuário e senha apenas e aprendendo o conceito, tu poderá utilizar sempre =).

A base do uso da gem é bem simples:

1. Abrir a planilha em questão;
2. Encontrar a(s) celula(s) que deseja guardar;
3. Usar em qualquer lugar =).

Bom, para conseguir usar a gem, vai ser necessário instalar primeiro:

```ruby
Para instalar de forma manual:

gem install roo

Ou adicionar no Gemfile

gem "roo", "~> 2.7.0"
```

# Usando e abusando

É bem simples o uso da gem, antes de mais nada crie um xlsx do jeito que tu ache melhor, colocando lá a base de dados que queira utitilizar no seu teste. No meu caso, eu to usando uma planilha chamada 'data_login' e na célula A3 eu tenho o cabeçalho User e B3 tenho password e nas células abaixo eu tenho o que eu realmente preciso utilizar "admin" para user e "inicial1234" para password.

Importante dar nomes as planilhas do seu arquivo, de repente você tem um documento onde queira armazenar dados de login, dados de compra, dados de flube e tu coloca isso em um só arquivo e define nome para as planilhas.

Para abrir uma planilha de forma "lógica" use:

```ruby
Roo::Spreadsheet.open('path/arquivo.xlsx')
```

Depois podemos simplesmente saber os nomes de todas as nossas planilhas do nosso arquivo em questão:

```ruby
nomes_plan = Roo::Spreadsheet.open('path/arquivo.xlsx')
nomes_plan.sheets
puts nomes_plan
data_login
```

Sabendo que eu tenho uma planilha chamada data_login, é com ela que vou trabalhar, buscar as células, armazenar em variáveis para usar em qualquer lugar:

```ruby
data_login = Roo::Spreadsheet.open('path/arquivo.xlsx')
@user = data_login.sheet('data_login').cell('A', 4).to_s # Para user
@pass = data_login.sheet('data_login').cell('B', 4).to_s # Para password
```

E pronto .. tu com esse conceito básico, consegue trabalhar com as células e pegar seus valores e através dessas variáveis, usar em qualquer lugar.

No exemplo eu coloquei a planilha, e todos esses comandos OK, deem uma vista de olhos =). E até a próxima.

Ahh.. e não deixem de olhar a gem e estudá-la OK.
