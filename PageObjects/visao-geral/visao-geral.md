# Page Objects - Uma visão além das palavras bonitas.

Page objects é um assunto que assombra a vida de um automatizador de testes desde sempre, pois sempre tem formas diferentes que são pensadas em como trabalhar com esse conceito. Mas vamos lá, para que serve então o Page Objects.

Em meias palavras, a técnica de Page Object vem com a intenção de você deixar seu código mais limpo, elegível e de fácil manutenção, utilizando orientação a objetos, encapsulando atributos, métodos em cada classe e do seu teste, você vai e chama essa classe e esse método. Essa é a definição mais "porca" de falar sobre Page Objects, ou em outras palavras, se eu tenho uma rotina que será usada em todo cenário (login na página), eu isolo essa funcionalidade dentro de uma classe e dentro de um método e, em qualquer teste quando eu chamar o método de login, ele vai executar aquela rotina.

O porque dessa chatice é bem simples: não precisar desenvolver a rotina de login em cada teste feito.

Simples de se entender, e essa parte acima eu apelidei de Page Step Objects, pois no método eu tenho uma rotina de step by step que vão resultar em um objetivo (por exemplo, realizar o Login). Como eu chamei de Page Step Object, eu criei um arquivo que trata apenas desse conceito:

[Sobre Page Step Objecs](https://github.com/thiagomarquessp/dia-a-dia-capybara/blob/master/PageObjects/page-step-objects/page-step-objects.md)

PS: PARA SABER SOBRE O PAGE OBJECT DE ACORDO COM O GURU DA BAGAÇA, SEGUE O [LINK](https://martinfowler.com/bliki/PageObject.html)

# Page Objects de uma forma diferente

Dado que o repositório se chama Dia a Dia Capybara, tem uma forma de se trabalhar com esse conceito de page objects em capybara utilizando uma gem chamada [site-prism](https://github.com/natritmeyer/site_prism), onde o conceito para essa técnica é de mapear os objetos de uma tela, por exemplo, se eu tenho um formulário de login com "usuário", "senha", "botão de Login" e "link de Esqueci minha Senha", já temos ai 4 elementos, ou 4 objetos que podemos. E agora vem a pergunta: Pra que eu vou querer mapear os elementos(objetos) da tela? E a resposta também é baseada em clean code, manutenção, etc. Para dar um exemplo prático imagina que toda vez que eu for implementar o login eu tenha que colocar algo assim:

```ruby
Step da Feature A

find(:id, '#id_elemento_user').set("usuario@teste.com")
find(:id, '#id_elemento_senha').set("senha")
find(:id, '#id_elemento_botao_entrar').click

Step da Feature B

find(:id, '#id_elemento_user').set("usuario@teste.com")
find(:id, '#id_elemento_senha').set("senha")
find(:id, '#id_elemento_botao_entrar').click

Step da Feature C

find(:id, '#id_elemento_user').set("usuario@teste.com")
find(:id, '#id_elemento_senha').set("senha")
find(:id, '#id_elemento_botao_entrar').click
```

Reparem que nesse contexto, eu tive que implementar 3 x a mesma rotina (esquece por hora o primeiro conceito lá em cima OK, foca nesse). Agora imagina se o front resolve fazer um refactory no código, usar um react como framework Web e meter os IDs Dinâmicos? Ok, vc vai ter que refatorar seu código para ele parar de quebrar, mas nesse caso, você terá que alterar em 3 lugares O.o !! Péssimo isso, agora imagina se estivesse assim:


```ruby
Step da Feature A

login.email_usuario.set("usuario@teste.com")
login.senha_usuario.set("senha")
login.botao_entrar.click

Step da Feature B

login.email_usuario.set("usuario@teste.com")
login.senha_usuario.set("senha")
login.botao_entrar.click

Step da Feature C

login.email_usuario.set("usuario@teste.com")
login.senha_usuario.set("senha")
login.botao_entrar.click
```

Ficou bem mais clean certo, então vamos trabalhar com esse conceito no link direto:

[Page Objects com Site Prism](https://github.com/thiagomarquessp/dia-a-dia-capybara/blob/master/PageObjects/page-objects-siteprism/page-objects-siteprism.md)
