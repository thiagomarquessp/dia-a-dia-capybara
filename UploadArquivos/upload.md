# Upload de arquivos

E agora estamos diante de um problema que volta e meia atormenta QAs que automatizam com capybara, que é justamente fazer upload de arquivos, e sim, isso é um parto, porque temos tanta informação por ai, mas as vezes o conceito pode ser mal interpretado ou de repente não da certo e pronto, mas vamos lá, vou tentar explicar aqui de forma que possa ajudar, caso alguém saiba outro método para realizar upload com o capybara, fiquem a vontade para colaborar com o repositório.

Como sabemos, o capybara infelizmente não faz interage com as janelas nativas do Sistema Operacional, então temos soluções para conseguir fazer nosso upload de forma elegante.

## Buscando o tipo de elemento que faça sentido

Parta do princípio que todo elemento que você clique e faça alguma iteração para fazer upload guarda bem no seu íntimo o tipo '<input>' e é exatamente ai que devemos nos esforçar e encontrar esse '<input>' mas de repente pode estar na cara =) e basta usar o comando do find passando o path da imagem, por exemplo:

```ruby
<div id="id-xpto" class="flube xpto htmlbutton ">
  <input type="file" name="name-element" class="file blabla input-image">
</div>
```

Agora que encontramos o elemento find que recebe o upload, basta fazer um find e passar o caminho do seu upload:

```ruby
find(:xpath, '//input[@name="name-element"]').set('/home/path/upload.png')
```

Nesse exemplo repare que eu usei o caminho absoluto do arquivo que eu desejo fazer upload, mas posso passar o caminho relativo também:

```ruby
find(:xpath, '//input[@name="name-element"]').set(File.expand_path File.dirname(__FILE__) << "/../upload.png")
```

Para facilitar a vida, coloque o arquivo na mesma estrutura do seu projeto para que possa fazer sentido.
