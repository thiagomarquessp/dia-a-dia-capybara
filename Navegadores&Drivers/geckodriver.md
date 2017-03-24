# Instalação e Configuração dos Drivers do Firefox e Google Chrome

Esse é um assunto que vem tomando horas de trabalho da galera quando estão iniciando em cucumber + capybara, pois quando eu tenho crio um projeto novo em cucumber por exemplo, ele não traz as configurações necessárias (arquivo env.rb) para que os testes possam ser executados abrindo um navegador e quando criamos um arquivo de environment (env.rb) na pasta support, para quem ta iniciando colocamos da seguinte maneira:

```ruby
require "capybara/cucumber"
require "selenium-webdriver"

Capybara.default_driver = :selenium
Capybara.default_max_wait_time = 60

Capybara.app_host = "https://sitequevamostestar.com/"
```
Até a versão 3.0 do Selenium e versão 46 do Firefox, quando eu passava o :selenium como driver padrão, ele já entendia que eu usaria o Firefox e quando o teste iniciava por exemplo com o comando visit "https://google.com.br", ele abria o Firefox e dava um visit na url do Google, mas, como sabemos, o Firefox gosta de ficar se atualizando de tempos em tempos, e a partir da 47, passando o parâmetro :selenium, ele simplesmente não rodava e deixava a tela em branco e com isso, bastava desinstalar o Firefox 47> e simplesmente instalar a 46, mas sabemos que isso não é muito legal certo?

Então nos vimos obrigados a ter que atualizar a gem do selenium para a 3.0, ai achamos que apenas dando update na gem, as coisas iriam continuar do mesmo jeito, até que executamos os testes e aparecia uma mensagem assim:

```ruby
unable to connect to Mozilla geckodriver 127.0.0.1:4444 (Selenium::WebDriver::Error::WebDriverError)
```
Agora vem o desespero de todo mundo, pois tem N tutoriais explicando como instalar o geckodriver, baixando o pacote, colocando aqui e ali, e rezando três marias, e acendendo vela, vários pulinhos comendo lentilha para que no final um ou outro conseguir configurar e ainda passar a configuração no env.rb dessa maneira:

```ruby
require "capybara/cucumber"
require "selenium-webdriver"

Capybara.register_driver :selenium_firefox do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox, marionette: true)
end

Capybara.default_driver = :selenium
Capybara.default_max_wait_time = 60

Capybara.app_host = "https://www.flube.com.br/"
```

Funciona??? Sim, mas não precisamos perder horas pra configurar e vamos utilizar o NodeJs para instalar o geckodriver, então para isso, vamos seguir o tutorial básico abaixo:

```ruby
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install jq nodejs curl -qy
sudo npm install -g geckodriver

O parâmetro "-g" coloca o pacote exatamente onde ele deve estar =)
```
Depois do geckodriver instalado, no arquivo de environment (env.rb) colocar dessa maneira:

```ruby
require "capybara/cucumber"
require "selenium-webdriver"

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.default_driver = :selenium
Capybara.default_max_wait_time = 60

Capybara.app_host = "https://www.flube.com.br/"
```

Agora basta executar os testes que eles vão rodar sempre na última versão do Firefox!!!

Quer aprender a usar o Chromedriver, acessa ai:

[Chromedriver] (https://github.com/thiagomarquessp/capybaraforall/blob/master/README.md);
