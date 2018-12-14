# Vamos falar um pouco de estrutura

Olá pessoal, como estamos? 

Bem, o dia a dia de hoje vai ser dedicado aos QAs que por algum momento se perguntou porque eu tenho que alterar na mão meu arquivo env.rb para colocar firefox ou chrome ou até mesmo mudar o host utilizado.

Para entender um pouco, quando criamos um projeto com o **capybara --init**, um dos arquivos criados é chamado de **env.rb**, onde aprendemos que devemos colocar as informações básicas como por exemplo: 
- Dar require nas gems que iremos utilizar;
- Definir e configurar o driver do Selenium;
- Colocar o host (ou não) do produto que estamos querendo acessar.

Basicamente, no início das coisas, o **env.rb** ficava assim: 

```ruby
require "capybara/cucumber"
require "selenium-webdriver"

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.default_driver = :selenium
Capybara.default_max_wait_time = 60

Capybara.app_host = "http://flube.com/"
```

Essa estrutura básica resolvia boa parte dos nossos problemas, é de fácil interpretação, de fácil configuração e com isso nossos testes rodavam muito bem, mas com o decorrer do tempo, algumas pessoas me abordavam querendo realizar o teste tanto em QA, como Staging, como Produção, mas não queriam fazer isso alterando o **Capybara.app_host** no ***env.rb*** e então chegamos aqui nesse material. 

Bem, basicamente teremos que criar algumas coisas: 
- Arquivos YAML;
- Criar variáveis de ambiente no **env.rb** para Browser e do Tipo de Ambiente que queremos executar.

## Arquivo o que??? 

[**YAML (YAML Ain't Markup Language)**](https://yaml.org/). 
No link tem a versão educada, explicando o que é um YAML, mas como eu gosto de falar do meu jeito, um arquivo YAML nada mais é do que um arquivo cujo a interpretação passa a ser fácil (quase humana)e que serve basicamente como um "banco de dados" de parâmetros que podemos usar a qualquer momento. No nosso caso, vamos definir parâmetros para execução do teste. Veremos a seguir:

## Cucumber YAML

O primeiro arquivo a ser criado vai se chamar ***cucumber.yaml*** e vamos definir os parâmetros (no caso, vou usar o mesmo do exemplo que temos):

```ruby
##YAML Template
---
default: -p chrome -p qa-environment
ci: -p json_report -p chrome_headless -p qa-environment
html_report: --format pretty --format html --out=features_report.html
json_report: --format pretty --format json --out=report/features_report.json
chrome: BROWSER=chrome
chrome_headless: BROWSER=chrome_headless
qa-environment: ENVIRONMENT_TYPE=qa-env
staging-environment: ENVIRONMENT_TYPE=staging-env
prod-environment: ENVIRONMENT_TYPE=prod-env
```
Nesse arquivo para deixar de fácil interpretação, deixei apenas o que eu julgo ser básico, onde eu defino a execução **default**, ou seja, quando eu executar o comando ***cucumber*** vai executar com os parâmetros que estão lá descritos, onde: 

- -p chrome (parâmetro para browser a ser executado)
- -p qa-environment (parâmetro para executar no ambiente de QA os testes)

Se eu quiser executar os testes em outro ambiente ou browser, alterno os valores, por exemplo: 

- -p firefox (nesse caso vou ter que configurar o driver no env.rb)
- -p prod-environment (executa os testes no ambiente de produção)

Criei os parâmetros referentes aos ambientes que vamos utilizar (qa-environment, staging-environment e prod-environment) passando a variável de ambiente ENVIRONMENT_TYPE.

Também criei parâmetros para quando eu quiser um report em formato html ou json e também devem ser passados com o -p, por exemplo:

-p json_report -p chrome -p qa-environment

## Criar YAML com o app_host que vamos utilizar no produto para cada ambiente

Essa é a parte fácil, onde vamos tirar o ***env.rb*** a responsabilidade de ter o app_host, onde colocamos a url que vamos utilizar, acessar, testar. Bem, geralmente EU coloco uma pasta chamada **config** dentro da pasta **support** e nessa pasta ***contig*** contém um arquivo YAML para cada parâmetro referente ao ambiente que definimos no arquivo **cucumber.yaml**. Lembra do ENVIRONMENT_TYPE, o valor que ele possue vai levar o nome dos meus novos arquicos, ou seja, teremos: 

```ruby
qa-env.yaml 
    url: 'https://qa-env.qa.com'

prod-env.yaml
    url: 'https://prod-env.qa.com'

staging-ev.yaml
    url: 'https://staging-env.qa.com'
```

Agora sabemos que se tivermos 20 ambientes para testar, podemos realizar em cada um deles, basta definir um novo arquivo yaml e colocá-los no ***cucumber.yaml***.

Só para lebrar, quando eu passar o parâmetro **cucumber -p qa-environment**, o meu **visit '/'** vai acessar a url ***https://qa-env.qa.com*** e por ai vai =).

## Arquivo env.rb

Agora, vamos no nosso arquivo **env.rb** para definir variáveis de ambiente para Browser e Tipo de Ambiente e remodelar a forma de como configuramos o driver: 

```ruby
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'selenium-webdriver'

## Aqui eu defini dois tipos de variável, BROWSER, passando com
BROWSER = ENV['BROWSER']
ENVIRONMENT_TYPE = ENV['ENVIRONMENT_TYPE']

## Uma forma elegante de dar load no arquivo de YAML sem ter que passar o path completo, e dessa forma passo de forma abstrata. Crio geralmente no env pq a execução passa primeiramente por ese arquivo e já carrega tudo que eu preciso.
CONFIG = YAML.load_file(File.dirname(__FILE__) + "/config/#{ENVIRONMENT_TYPE}.yaml")

## Reconfiguração do browser, passando agora a variável BROWSER que criamos, e nesse caso, quando o parâmetro for igual o que está entre parênteses, ele sabe que a execução tem que passar no if em questão.
Capybara.register_driver :selenium do |app|
  if BROWSER.eql?('chrome')
    options = ::Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--window-size=1920,1080')
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  elsif BROWSER.eql?('chrome_headless')
    options = ::Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--window-size=1920,1080')
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end
end
```
Com essa configuração **base** conseguimos deixar os nossos testes prontos para escalar.

Para então executar os testes, basta agora **cucumber -p chrome -p qa-environment** e deixar fluir.

Temos um exemplo pré configurado conforme o que falamos acima dentro da pasta **cucumber** desse arquivo =).

PS: Vou voltar a dar manutenção nesse texto, além de grande, posso melhorar a forma de como conduzo a vossa leitura.

Obrigado, e dúvidas, ***thiagomplk@gmail.com***.

