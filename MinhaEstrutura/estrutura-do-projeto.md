# Como estruturar meus testes em Capybara e Cucumber

A pergunta de 1,5MM de Reais (a de 1 Milhão é "Testes automatizados, por onde eu começo?") é justamente sobre o tipo de estrutura a ser seguida dentro de um projeto de testes baseado em Cucumber e Capybara. 

Vamos colocar uma coisa na cabeça, **NÃO EXISTE UMA VERDADE**, ou seja, vai ser adaptado conforme o seu ***contexto***. Se olharmos bem nos olhos do **cucumber**, quando damos um ***cucumber --init***, ele traz a seguinte estrutura **BÁSICA**:

```ruby
$ cucumber --init
  create   features
  create   features/step_definitions
  create   features/support
  create   features/support/env.rb
```
E pronto, podemos pegar e assumir isso como verdade absoluta, porque o próprio framework nos criou dessa maneira, tanto que ao executarmos o comando **cucumber**, o resultado passa a ser esse: 

```ruby
$ cucumber
0 scenarios
0 steps
0m0.000s
```
Que quer dizer que ta tudo certinho, basta escrever **.features** e implementar os **steps**.

Tanto que se implementarmos nossos testes dentro dessa estrutura, vai funcionar e pronto.

## Ok, e a estrutura? 

Bem, vou colocar algumas coisas que eu julgo ser interessantes para uma estrutura de testes dentro desse ecossistema e geralmente eu divido em estrutura básica e uma estrutura para escalar os testes, ou seja, quando falamos de uma estrutura básica é para simplesmente aquelas pessoas que estão iniciando possam não se perder com tanta informação, ou seja, os testes vão estar super bem definidos e vão executar numa boa e quando eu vou escalar eu passo a deixar a estrutura de um jeito onde eu passo parâmetros de execução, altero a forma de configuração dos drivers, etc e ambas atendem sua demanda.

## Estrutura básica

Eu gosto de chamar de estrutura básica porque é básica (para mim), e nesse caso além da base criada pelo **cucumber --init** eu deixo mais ou menos assim: 

```shell
nome-do-projeto
    cucumber
        features
            pages
            specs
            steps
            support
```

Muitos me perguntam porque eu coloquei uma pasta chamada ***cucumber*** no projeto, e a resposta é bem simples: "Porque nosso projeto é em cucumber". Eu poderia dentro desse projeto ter parte em APIs que não faz sentido eu ter uma camada de abstração em cucumber e eu crio meu projeto em RSPEC pode exemplo, e ficaria assim: 

```shell
nome-do-projeto
    cucumber
    rspec
        specs
        pages
```

Mas vamos entender um pouco sobre cada uma das pastas e o que é suposto eu colocar dentro delas, assim como vou dar uma visão base de como escrever os nomes de cada um dos arquivos:

- cucumber - Porque os teste são em cucumber;
- pages - Dedicada para poder criar meus arquivos de page objects, step objects, map objects, etc.;
- specs - Onde armazeno toda a documentação feita em linguagem gherkin;
- steps - Não precisa falar muito, é onde eu implemento os testes com base no que escrevemos nas specs;
- support - Por base, é criado o env.rb, que é o arquivo de configuração básica pro meu teste conseguir ser executado, como por exemplo, configuração do browser, require nas gems neessárias para execução dos testes, etc.

## Contextualizando nosso projeto

Acho que essa seja a parte mais complexa de se trabalhar e organizar um ecossistema saudável e escalável no projeto e com isso eu gosto de falar que temos que contextualizar nossos testes, que eu carinhosamente dei o nome de **DEC (Defined and Copy ou Defina e Copie)**, ou seja, vou a forma de como eu defino primeiro nas ***specs***, vou definir nas demais, ex: 

```ruby
nome-do-projeto
    cucumber
        features
            pages
                login
                    login-pages.rb
                cadastro
                compra
                pagamento
            specs
                login
                    login.feature
                cadastro
                compra
                pagamento
            steps
                login
                    login-steps.rb
                cadastro
                compra
                pagamento
            support
```

É uma forma tranquila de trabalhar, porque sabemos o contexto e com esse contexto, aplicamos para todas as frentes que fazem parte do nosso projeto.

## Sobre nomes a serem dados

Bem, nomes de arquivo devem estar com letras minúsculas e com traço separando os nomes, como ***login-sucesso.rb*** e não **login_sucesso ou LoginSucess ou Login_Sucesso** e isso se aplica a todos os nomes de arquivos.

O mesmo se aplica a nome de pastas Ok =).

Caso queiram saber da estrutura para escalar, acesse [aqui](https://github.com/thiagomarquessp/dia-a-dia-capybara/tree/master/PreparandoParaEscalar), que foi um material recente que eu criei. 

## Finalizando

Como eu disse lá em cima, não existe uma fórmula mágica e nem uma regra ou convenção para criação de uma estrutura em Capybara, então o que tem que ser **default** é que tenha que fazer sentido e que esteja minimamente organizado.

Obrigado e se precisarem, meu email fica a disposição: ***thiagomplk@gmail.com***

