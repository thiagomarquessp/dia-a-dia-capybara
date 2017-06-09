# Page Objects com Site Prism

Bom, vamos lá.

Usar o SitePrism para mapear os elementos(objetos) de uma página faz com que fique mais fácil definir nomes dos mesmos elementos de acordo com a sua necessidade e com isso, realizar a manutenção em apenas um lugar também, ou seja, eu vou mapear o elemento nome_usuario com SitePrism e toda vez que esse elemento sofrer algum tipo de alteração, você irá ajustar apenas em um lugar, sem interferir os testes. Puramente falando, vamos imaginar o seguinte cenário com capybara:

```ruby
Dado(/^que eu realizo o cadastro de cliente$/) do
  visit '/'
  find(:id, 'id_elemento_nome').set("Teste Nome do Usuario")
  find(:css, '.css_elemento.endereco').set("Rua teste do Usuário")
  find(:xpath, '//input[@name="xpath_cpf"]').set("1234567890")
  click_button 'Cadastrar'
  expect(page).to have_content 'Cadastro realizado com sucesso'
end
```
Imagine sempre que eu precisar dos elementos Nome, Endereco e CPF eu tenha que implementar dessa forma. Vai funcionar? Sim .. mas imagine que eu faça isso em dez steps e com isso a manutenção passa a ser em dez steps diferentes, correndo o risco de dar ruim e eu esquecer de implementar um step ou indo além, implementar errado.

Por isso o SitePrism resolve esse problema, pois eu vou encapsular os elementos, dar nomes para eles e a manutenção será feita em apenas um lugar. Vamos ver como vai ficar:

```ruby
Geralmente se cria um arquivo com extensão .rb, eu gosto de referenciar usando mais ou menos assim: 'cadastro-page.rb'

class Cadastro < SitePrism::Page
  element :nome_do_usuario, '#id_elemento_nome'
  element :endereco_do_usuario, '.css_elemento.endereco'
  element :cpf_do_usuario, '//input[@name="xpath_cpf"]'
  element :botao_cadastrar, '.classe_btn'
end
```
Basicamente criamos uma classe Cadastro e instanciamos o método Page do SitePrism. Para se aprofundar um pouco mais acesse o [github](https://github.com/natritmeyer/site_prism) do SitePrism.

E agora vem a parte interessante da história, que é refatorar aquele nosso código:

```ruby
Dado(/^que eu realizo o cadastro de cliente$/) do
  visit '/'
  @cadastro_usuario = Cadstro.new
  @cadastro_usuario.nome_do_usuario.set("Teste Nome do Usuario")
  @cadastro_usuario.endereco_do_usuario.set("Rua teste do Usuário")
  @cadastro_usuario.cpf_do_usuario.set("1234567890")
  @cadastro_usuario.botao_cadastrar.click
  expect(page).to have_content 'Cadastro realizado com sucesso'
end
```
Ficou muito mais clean o código, mais legível e agora sabemos que se eu tiver que dar manutenção em algum desses campos, basta eu ir na classe e ajustar. Para ficar claro, olhem as duas versões:

```ruby
Antes:

find(:id, 'id_elemento_nome').set("Teste Nome do Usuario")
find(:css, '.css_elemento.endereco').set("Rua teste do Usuário")
find(:xpath, '//input[@name="xpath_cpf"]').set("1234567890")
click_button 'Cadastrar'

Depois com SitePrism:

@cadastro_usuario = Cadstro.new
@cadastro_usuario.nome_do_usuario.set("Teste Nome do Usuario")
@cadastro_usuario.endereco_do_usuario.set("Rua teste do Usuário")
@cadastro_usuario.cpf_do_usuario.set("1234567890")
@cadastro_usuario.botao_cadastrar.click
```

Não percam esse exemplo, porque vou usá-lo no outro modelo de Page Objects, que carinhosamente eu chamo de Page Step Objects e também irei usar para falar sobre Hooks =).

Até! 
