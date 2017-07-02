# Acessando o banco de dados para fins de teste.

Fala pessoal, de uns tempos para cá algumas pessoas me abordam com a seguinte dúvida: "É possível persistir os dados no banco de dados?" e a resposta é sim, é possível realizar qualque ação no BD, desde consulta até deleção. Bem, eu vou falar um pouco de uma gem chamada [mysql2](https://github.com/brianmario/mysql2) que executa bem esse papel.

Mas não é assim tão fácil de configurar um ambiente para essa gem, ou seja, não adianta sair dando "gem install mysql2" que não vai funcionar. Para que a instalção faça sentido, vamos precisar dos pré requisitos:

```ruby
Instalar:
- PostgresSQL = sudo apt-get install postgresql
- Phyton = sudo apt-get install python-psycopg2
- Libs = sudo apt-get install libpq-dev
```
E vamos precisar das seguintes gems instaladas:

```ruby
Obs.: Sabe que o ideal é colocar no Gemfile certo??

gem install pg
gem install mysql2
gem install sqlite3
```
Então se você tem uma aplicação cujo o banco de dados seja MySql então essa gem vai servir pra ti. Caso tenha outros BDs, aguarde o complemento desse, que vai falar de outra gem, mas por hora concentre nesse =).

Eu acho interessante a vontade de persistir os dados no banco de dados, mas indo um pouco além, quando passamos a pensar em testes na camada de BI (em breve farei um repositório sobre isso) faz muito mais sentido.

Bem, então como vai ficar nosso Gemfile:

```ruby
source "https://rubygems.org"

gem 'capybara'
gem 'cucumber'
gem 'selenium-webdriver'
gem 'pg'
gem 'sqlite3'
gem 'mysql2'
gem 'rspec'
```

E nosso env:

```ruby
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'pg'
require 'sqlite3'
require 'mysql2'
require 'rspec'
```

# Usando o Mysql2

Vamos imaginar que ja temos um step e queremos fazer uma consulta no banco para sei lá, validar se o nome que colocamos no teste está registrado de forma correta. Com esse cenário, vamos trabalhar da seguinte maneira:

```ruby
Entao(/^o nome cadastrado devera estar salvo no banco de dados$/) do
  @acessa_bd = Mysql2::Client.new(:host =>"000.000.00.000", :database =>"base_meu_app", :username =>"root", :password =>"root")
  @resultados = @acessa_bd.query("select * from usuarios where nome_usuario = 'BiroBiro'")
  @resultados.each do |row|
    puts row["nome_usuario"]
    expect(row["nome_usuario"]).to eq 'BiroBiro'
  end
end
```
Então vamos desmembrar esse método:

```ruby
@acessa_bd = Mysql2::Client.new(:host =>"000.000.00.000", :database =>"base_meu_app", :username =>"root", :password =>"root")

Dentre os diversos métodos que o Mysql2 tem, o Client é um que, instanciando, eu tenho que passar os parâmetros:
:host => devemos pegar esse acesso do host de QA;
:database => O nome do banco que estamos trabalhando (qa, stg, flube);
:username => Do banco de dados;
:password => Do banco de dados.

Com apenas essas informações e claro, com o acesso permitido, conseguimos conectar com o banco já na nossa automação. E isso é bom, porque nos da garantia de raalizar as ações que tanto almejamos (select, alter, delete, etc.).
```

```ruby
@resultados = @acessa_bd.query("select * from usuarios where nome_usuario = 'BiroBiro'")

Nesse caso não tem muito o que traduzir certo, estamos ja realizando um select na tabela usuarios com where no campo nome_usuario.
```

```ruby
@resultados.each do |row|
  puts row["nome_usuario"]
  expect(row["nome_usuario"]).to eq 'BiroBiro'
end

Nesse caso criamos um each setando o parâmetro |row| (coluna) para que consigamos realizar ações através de alguma coluna específica, e no nosso caso, estamos dando um print na tela na coluna nome_usuario e logo em seguida estamos dando um expect para garantir que o a coluna nome_usuario possua o valor 'BiroBiro'. Caso tenha algo diferente disso, o teste vai quebrar.
```

Bem, o mesmo se aplica para Alter, Delete e todas as outras ações que realizamos no banco de dados. Podemos criar queries mais sofisticadas, e conseguir trabalhar com o expect para validar se o que esperamos é exatamente aquilo que registramos.

No próximo vou falar um pouco mais sobre outra gem interessante para acesso ao banco de dados.

Enjoy.
