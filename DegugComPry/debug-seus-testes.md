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
![alt text](https://github.com/thiagomarquessp/dia-a-dia-capybara/tree/TP-DebugPry/DegugComPry/common-images/steps-pry.png "Arquivos de Step Definitions")
