# Debugar é sempre preciso

Bem, esse talvez seja o mais simples da série do dia a dia do capybara, porém muitas pessoas que falam comigo sobre automação com capybara por exemplo, me mostram seus testes quebrando sem saber porque em algum ponto da execução, mas sempre executam os mesmos testes para tentar perceber onde que está o problema. E isso é bem chato, e as vezes temos testes tão longos que passamos até horas para tentar entender (com tantas execuções) onde que estão os problemas e sabendo disso, temos uma gem que nos ajuda a fazer o debug e assim não preciso me desesperar tanto olhando para tela. A gem se chama [PRY](https://github.com/pry/pry), que nada mais vai fazer que abrir um IRB (Iterative ruby shell).

## Instalando a Gem

Eu tenho por padrão antes de sair instalando as coisas, vou até o **[rubygems]**(https://rubygems.org/) e procuro pela gem para ver a questão da versão que eu quero utilizar, se ela ta estável, mas pronto, podemos simplesmente instalar ou colocar no Gemfile:

```ruby
gem 'pry', '~> 0.12.2'
``` 
Depois dar um **bundle install** ou de forma manual:

```ruby
gem install pry -v 0.12.2
``` 

## Deixando pronto para utilizar

Instalou a gem, agora vamos no nosso arquivo **env.rb** e deixar mais ou menos assim: 

```ruby
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'pry'
```

## Usando =)

Bem, o uso do **pry** é bem simples e com apenas um comando para que ele pare deixando pronto pra usar, que é ***binding.pry***. Vou colocar uma estrutura básica para exemplificar: 

Exemplo utilizando o pry nos arquivos de steps:

```ruby
Given("I access the store") do
    visit '/'
    binding.pry -- Esse é o comando para a execução do script parar exatamente nesse ponto do teste
end
  
When("I click on my account") do
    expect(page).to have_content 'My Account'
    click_link 'My Account'
end
  
Then("I see the obrigatory fields to login") do
    expect(page).to have_content 'Username'
    expect(page).to have_content 'Password'
end
```

Quando a execução chegar no **binding.pry** no nosso terminal vai aparecer: 

```shell
cucumber -p chrome -p qa-environment --tags @simple

Using the chrome and qa-environment profiles...
Feature: Simple test to try to use pry
   I as QA
   Would like to test a simple example

From: /Users/thiagopereira/workspace/articles/dia-a-dia-capybara/DegugComPry/cucumber/features/step_definitions/simple-example.rb @ line 3 :

    1: Given("I access the store") do
    2:     visit '/'
 => 3:     binding.pry
    4: end
    5:
    6: When("I click on my account") do
    7:     expect(page).to have_content 'My Account'
    8:     click_link 'My Account'

[1] pry(#<Object>)>
```

Nesse caso o que nós temos: 

**=> 3:     binding.pry**  - Local onde o teste parou e olha que interessante, o que é preciso fazer agora é ***testar*** nossa implementação, e copiar e colar os comandos que estão nos nossos arquivos de steps, por exemplo: 

```shell
    1: Given("I access the store") do
    2:     visit '/'
 => 3:     binding.pry
    4: end
    5:
    6: When("I click on my account") do
    7:     expect(page).to have_content 'My Account'
    8:     click_link 'My Account'

[1] pry(#<Object>)> expect(page).to have_content 'My Account'
=> true
[2] pry(#<Object>)>
```

Nesse caso, o teste foi verdadeiro.

Obs.: Por mais que seja um debug, precisamos realizar uma ação no terminal e ver como correu no browser em questão e ver se o teste foi executado com sucesso. Um teste legal é quando damos find em algum elemento, por exemplo: 

```shell
[2] pry(#<Object>)> find('#account a')
=> #<Capybara::Node::Element tag="a" path="/html/body/div[2]/div/div/header/div[2]/a">
```

Medonho, eu sei. mas paciência.

## Saindo do debug

Terminou os testes que queria realizar via debug, não esqueçam de passar esses comandos para o projeto viu (normal esquecer), então caso tenha algum sucesso, copia e cole direto no seu arquivo de steps ou onde quer que seja. Nesse caso, temos 3 frentes: **terminal, editor de texto e browser**.

Terminando, basta dar um **exit**: 

```shell
[3] pry(#<Object>)> exit
  @simple
  Scenario: Access and asserts                # features/specs/simple-example-to-test.feature:7
    Given I access the store                  # features/step_definitions/simple-example.rb:1
    When I click on my account                # features/step_definitions/simple-example.rb:6
    Then I see the obrigatory fields to login # features/step_definitions/simple-example.rb:11

1 scenario (1 passed)
3 steps (3 passed)
7m16.012s
```

E pronto, termina a execução. E olha que interessante, o tempo que foi feito essa execução foi de sete minutos, justamente o tempo que levei escrevendo e tirando prints rsrsrs . 


## Dica útil

Não esqueçam de tirar o debug depois que terminarem =) senão o teste vai ficar parado e vou falar que esquecer e enviar pra master e o ci ficar preso por conta de debug **Não é legal** #quenunca.

Enfim, obrigado por acompanhar até aqui, qualquer dúvida, gritem ai.
