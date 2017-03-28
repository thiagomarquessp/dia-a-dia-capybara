# Um problema bem chato não é mesmo???

Bom, quando eu aprendi a automatizar testes eu fui condicionado a buscar elementos da seguinte maneira: "SEMPRE BUSQUE PELO ID" e se não tiver ID, botão direito -> copiar CSS ou Xpath. E com o passar dos tempos eu condenava os devs quando eles não colocavam IDs e fazia um mimimi lascado (vocês sabem do que eu to falando rs).

Ai passou o tempo e aprendemos que buscar elemento usando um seletor (jQuery por exemplo) é uma solução legal para pegar o elemento de forma mais certeira. Vou dar um exemplo de como buscamos elementos com jQuery:

```ruby
Pense no seguinte elemento, considerando que não temos ID :

<input class="field-input-first-name" type="text" name="first-name">

Então estamos falando que temos um campo de input onde eu vou colocar o Primeiro Nome OK, então no console do navegador para encontrar esse elemento fazemos da seguinte maneira:
  $('.field-input-first-name')
  <input class="field-input-first-name" type="text" name="first_name">

Quando eu passar o mouse em cima desse resultado, ele vai deixar identificar esse elemento. Depois pegamos essa classe e passamos no find por exemplo.:

find(:css, '.field-input-first-name').set("Primeiro nome do Cliente")
```

Ai com o passar dos anos e sendo criados diversos frameworks modernos de desenvolvimento Front-End (ember, React, Bootstrap, etc) caímos no seguinte cenário: Ids dinâmicos e classes iguais (por tipo de componente). Aí virou um Eru nos acuda, bateu um desespero na galera, e muitos chegam pra mim e falam "E agora, o que eu faço nesse contexto?". A documentação do capybara nos fornece um comando chamado "all", que você pega e passa o índice (posição do elemento) e depois passa a iteragir com o elemento, ficando dessa forma:

```ruby
Considerando que eu esteja em um formulário e o componente utilizado tem uma classe e os ids são dinâmicos.
  <input class="field-input" id="ember890" type="text" name="first-name">

No console do navegador vamos buscar pela classe:

  $('.field-input')
  <input class="field-input" id="ember890" type="text" name="first-name">
  <input class="field-input" id="ember890" type="text" name="last-name">
  <input class="field-input" id="ember890" type="text" name="address">
  <input class="field-input" id="ember890" type="text" name="cellphone">
  <input class="field-input" id="ember890" type="text" name="zipcode">
  <input class="field-input" id="ember890" type="text" name="cpf">

No nosso arquivo de step podemos pegar o índice e passar:

all(:css, '.field-input')[0].set("Primeiro nome do Cliente"), onde [0] é o índice e simboliza a primeira posição.
```
Vai funcionar? Sim!!! Mas vai ficar feio pra caramba! Então temos uma solução, de usar o XPATH para poder trabalhar?

Ai vem a mesma escola que aprendeu que XPATH é uma porcaria e etc. Sim, é uma porcaria porque você aprendeu a clicar com o botão direito do mouse e copiar o xpath ficando desse jeito:

```ruby
//div/a/a/a/span/div/div/input[10]/div/input[0]
```

Isso é feio demais, e se mudar qualquer coisa no meu html, ele vai varrer e não vai achar meu elemento.

Mas tem uma forma elegante de trabalhar nesse caso, usando XPATH e observando direito meu HTML. E o segredo para quem desenvolve nesses frameworks é que sempre terá um atributo no meu HTML que será diferente para cada elemento, no nosso exemplo, temos o atributo "name" e vamos fazer da seguinte forma:

```ruby
find(:xpath, '//input[@name="first-name"]').set("Primeiro nome do Cliente")
```

E pronto, ficou clean e o elemento pode mudar de posição, que ele não vai sofrer alteração, pois sempre será encontrado, porque o name para cada elemento é único. Pra colocar no SitePrism é tranquilo também:

```ruby
class MeusElementos <SitePrism::Page
  element :first_name, :xpath, '//input[@name="first-name"]'
end

E no arquivo de steps chamaria assim:

cadastro = MeusElementos.new
cadastro.first_name.set("Primeiro nome do Cliente")
```

Então a dica é: IDs dinâmicos, Classes iguais, antes de sair batendo nos devs, leia o HTML e identifique o atributo único daquele elemento. Se mesmo assim não tiver (sim acontece), basta conversar com o dev front e pedir pra ele inserir ou na pior de todas as hipóteses, usar o [all] (https://goo.gl/bf1VAJ) e passando o índice do elemento.

Valeu galera!
