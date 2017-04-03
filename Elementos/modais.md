# Lidando com Modais

Dessa vez vamos aborar a busca de elemento em Modais, pois tem sido pedra no sapato de muito QA.

O problema: Buscar um elemento no QA.
Resultado do problema: "Unable to find ... (Capybara::ElementNotFound)"

Ai vem o desespero de geral, achando que a página ta errada, ou por algum motivo bizarro não encontra o elemento e nessas vem a frase: "Mas eu to passando o ID certinho, e não ta dando certo."

O que acontece com o capybara é que ele é meio burro para algumas coisas, e nesse caso, você tem que dizer pra ele o que ele tem que fazer exatamente, no caso do Modal, você tem que explicar que ele tem que entrar no Modal e depois trabalhar dentro dele pra depois ele sair e seguir a vida e se não o fizer, ele vai abrir o modal e vai se comportar na tela de trás do modal, tentando achar algo que não existe de fato.

Para resolver esse problema, o capybara tem o seguinte comando:

```ruby
  within('#id_modal') do
    comandos para interagir dentro do modal
  end

Exemplo:

Imaginem o seguinte HTML:

<div class="modal fade in" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: block; padding-right: 15px;">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
          <h4 class="modal-title" id="myModalLabel">Modal Header</h4>
        </div>
        <div class="modal-body">
          <p>Some text in the modal.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
        </div>
      </div>
    </div>
</div>

E queremos clicar no botão Fechar desse modal, então para conseguir clicar no botão de dentro do modal temos que procurar o elemento modal, pegar seu id e definir da seguinte maneira:

  within('#myModal') do
    click_button 'Close'
  end
```
Depois é vida que segue.

Agora sem a desculpa que não acha o elemento hein =).

Um abraço.
