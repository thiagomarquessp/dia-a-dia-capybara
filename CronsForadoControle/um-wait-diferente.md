# Um Wait diferente. 

Bem, imaginem a seguinte situação que se vocês ainda não passaram por ela, com certeza em algum momento vão se deparar com aqueles testes onde dependemos de uma cron rodando para ativar as coisas, por exemplo, ativação de plano de telefone (péssimo eu sei). Nas andanças pelo github, um colega de trabalho achou uma gem chamada [WaitUtil](https://github.com/rubytools/waitutil), que me deixa ter o controle de fazer refresh a cada X tempo entrando em um condicional caso eu alcance um objetivo.

Para instalar a gem, basta: 

```ruby
gem install waitutil
```
Só lembrando que podemos deixar essa gem no nosso Gemfile caso faça sentido essa gem pra ti. 

```ruby
source 'https://rubygems.org'

gem 'waitutil', '~> 0.2.1'
```

Não esquecer que para utilizar, no env temos que colocar também o chamado da gem: 

```ruby
require 'waitutil'
```

Para utilizar é bem simples, no momento em que tivermos que "esperar" para ativar ou esperar algum elemento na tela, devemos utilizar: 

```ruby
   WaitUtil.wait_for_condition("o que deve acontecer!!!", :timeout_sec => 30, :delay_sec => 1) do
      expect(page).to have_content 'Ativo'
   end
```

Explicando agora:

```ruby
"o que deve acontecer!!!" é apenas uma string que indica qual é a validação que você espera, por exemplo: "esperar o plano de dados estar ativo.".

:timeout_sec => 30 é o tempo que vai ficar tentando até dar time out. Conversem com os amigos devs para ver mais ou menos o tempo que se leva para a cron rodar e ativar o plano, para não ficar colocando um tempo muito grande e ficar com um falso positivo ok.

:delay_sec => 1 é o tempo de tentativa, ou seja, a cada 1 segundo, ele faz refresh na tela. 

expect(page).to have_content 'Ativo' é a validação que quero fazer, no caso, de 1 em 1 segundo ele faz um expect procurando pela palavra "Ativo" na tela.
```
Bem, é bem isso! ajuda bastante em alguns casos!