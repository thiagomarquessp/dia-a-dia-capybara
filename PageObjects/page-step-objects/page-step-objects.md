# Sobre Page Step Objects

Eu carinhosamente o chamo assim porque eu encapsulo uma série de steps (passo a passo) dentro de um método que será comum em diversas partes do meu projeto, por exemlo, Login de usuário, pois a maioria dos produtos o usuário necessita estar logado no sistema para realizar algo (efetuar uma compra, pagar algo, etc.). Então para não ter por exemplo que toda vez implementar uma rotina de Login, eu deixo implementado em um método e sempre que eu precisar dessa rotina, eu chamo esse método.

Quando se fala em cucumber, essa abordagem é mais simples, pois através de uma feature implementada, basta apenas eu chamá-la para que a rotina do login seja executada, por exemplo:

```ruby
login.feature

#language: pt
Funcionalidade: Login

Eu, como usuario do sistema
Desejo realizar o login com sucesso
Para poder realizar minhas transações

Cenario: Login com sucesso

  Dado que eu informe minhas informações de login
  Então sou direcionado para tela de Dashboard

login.rb

Dado(/^que eu informe minhas informações de login$/) do
  visit 'http://flube.com/login'
  find(:css, '#user_name').set('username@user.com')
  find(:css, '#user_password').set('inicial1234')
  click_button 'Login'
end

Dado(/^sou direcionado para tela de Dashboard$/) do
  expect(page).to have_content 'Usuário xpto logado com sucesso'
end
```

Pensando nesse cenário, imagine que eu necessite pagar uma conta no meu sistema, e para isso eu precisaria estar logado:


```ruby
pagamento.feature

#language: pt
Funcionalidade: Realizar pagamento

Eu, como usuario do sistema
Desejo realizar o pagamento das minhas contas
Para ser um usuário sem dívidas

Cenario: Realizar pagamento

  Dado que eu informe minhas informações de login
  Quando eu realizar meu pagamento
  Então o saldo da minha conta devera ser atualizado
```
Notem que a sentença do "Dado" é a mesma para validar o Login e para realizar o Pagamento, o que não quer dizer que eu necessite implementar duas x, porque isso já foi implementado no momento em que fiz o Login. Basta apenas eu organizar bem meus arquivos .rb para que tudo possa fazer sentido se seja fácil implementar. Tanto que nesse caso, quando você executar o comando cucumber para executar, apenas o "Quando" e "Entao" vão ser apresentados para implementar, ficando dessa forma:

```ruby
# language: pt
Funcionalidade: Realizar pagamento
Eu, como usuario do sistema
Desejo realizar o pagamento das minhas contas
Para ser um usuário sem dívidas

  Cenario: Realizar pagamento                          # features/xpto.feature:9
    Dado que eu informe minhas informações de login    # features/xpto.rb:1
    Quando eu realizar meu pagamento                   # features/xpto.feature:12
    Então o saldo da minha conta devera ser atualizado # features/xpto.feature:13

1 scenario (1 undefined)
3 steps (2 undefined, 1 passed)
0m3.328s

You can implement step definitions for undefined steps with these snippets:

Quando(/^eu realizar meu pagamento$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Então(/^o saldo da minha conta devera ser atualizado$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
```
Nesse caso ele mesmo já mostra que o "Dado" já foi implementado, ou seja, sempre que eu precisar estar logado, basta eu enviar um "Dado que eu informe minhas informacoes de login", que ele vai executar essa rotina de login com sucesso.

Bem, mas isso não é o Step Objects rsrsrsr, mas é uma forma de lidar com uma rotina através do cucumber. Vamos implementar essa rotina da forma "Martin Fowleriana" de Page Objects:

```ruby
login-map-objects.rb

class LoginMapObjects < SitePrism::Page
  element :nome_do_usuario, '#user_name'
  element :senha_usuario, '#user_password'
  element :botao_login, '.classe_btn'
end

login-step-objects.rb

class Login
  include Capybara::DSL

    def login_sucesso
      @login = LoginMapObjects.new
      visit "/"
      @login.nome_do_usuario.set('username@user.com')
      @login.senha_usuario.set('inicial1234')
      @login.botao_login.click
    end
end
```
Para entender o que fizemos: Criamos um classe chamada Login dando include no Capybara::DSL para que possamos colocar comandos de capybara dentro dessa classe. Depois criamos um método que chamamos de login_sucesso, onde eu instanciei a classe LoginMapObjects que foi feito com SitePrism, deixando mais clean o nome dos meus objetos da tela.

Agora voltando na implementação do Login, vai ficar assim:

```ruby
login.rb

Dado(/^que eu informe minhas informações de login$/) do
  @login = Login.new
  @login.login_sucesso
end
```

E toda vez que eu necessitar que a rotina de Login seja executada, basta eu dar um new na classe Login, e chamar o método login_sucesso. Vamos mudar um pouquinho a implementação do pagamento pra poder chamar o login sem depender do cucumber:

```ruby
pagamento.feature

#language: pt
Funcionalidade: Realizar pagamento

Eu, como usuario do sistema
Desejo realizar o pagamento das minhas contas
Para ser um usuário sem dívidas

Cenario: Realizar pagamento

  Dado que eu realize um pagamento
  Então o saldo da minha conta devera ser atualizado

pagamento.rb

Dado(/^que eu realize um pagamento$/) do
  @login = Login.new
  @login.login_sucesso
  click_link 'Pagamentos'
  find(:css, '.css.cod_barra').set('00000.00000.00000.000000.00000.000000.0.71150000000000')
  click_button 'Pagar Conta'
end

Então(/^o saldo da minha conta devera ser atualizado/) do
  expect(page).to have_content 'Pagamento efetuado com sucesso'
end
```
Então observe que eu implementei o pagamento, mas iniciei com o login, sem ter que implementar o login novamente e sem ter que depender da feature que eu escrevi no cenario de login.

A vantagem é que se quebrar algo no fluxo de Login, basta eu ir até o método e refatorar e olhando para minha implementação, tudo fica mais clean.

Bem galera é por ai.. Aos poucos vamos melhorando item a item rsrss.
