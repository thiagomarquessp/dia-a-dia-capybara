# Chromedriver

### Instalação

Bom, assim como o geckodriver, para executar os testes no Google Chrome temos que instalar um carinha chamado Chromedriver. Para o chromedriver, vamos seguir a mesma ideia de instalação do geckodriver, via node, só que os comandos serão:

```ruby
sudo npm install -g chromedriver
```
Se não tiverem o NodeJs instalado, os comandos são:

```ruby
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install jq nodejs curl -qy
```

Obs.: Importante ter o Google Chrome instalado!!! Sim, é óbvio mas tem gente que pergunta se é necessário ou não! Mas, para aqueles que usam Linux, seguem os comandos para instalar o Google Chrome (que não vem nativo no Linux):

```ruby
sudo apt-get install libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb
sudo apt-get install -f
```

Para configurar o chrome como navegador para os meus testes, colocar da seguinte maneira no arquivo de environment (env.rb):

```ruby
require "capybara/cucumber"
require "selenium-webdriver"

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.default_driver = :selenium
Capybara.default_max_wait_time = 60

Capybara.app_host = "https://www.flube.com.br/"
```

Antes de sair executando os testes, no Gemfile será necessário colocar gem 'chromedriver-helper'

Agora sim podem executar os seus testes que eles agora vão rodar no Google Chrome.

### ChromeOptions

Na criação do driver, podemos também passar parâmetros específicos do Chrome, que são as [ChromeOptions](https://sites.google.com/a/chromium.org/chromedriver/capabilities). Por exemplo, caso quisermos que o navegador inicie maximizado, podemos passar a option `start-maximized`:

```ruby
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      'chromeOptions' => {
        'args' => ['--start-maximized']
      }
    )
  )
end
```

### Obtendo logs

Quando rodamos nossos testes em um servidor de CI ou até mesmo localmente, podemos encontrar problemas relacionados ao Chromedriver. Para fins de debug, é importante salvarmos o log do Chromedriver.

Para salvar o log, basta adicionar mais um parâmetro na criação do driver:

```ruby
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      'chromeOptions' => {
        'args' => ['--start-maximized']
      }
    ),
    driver_opts: {
      verbose: true,
      log_path: 'log/chromedriver.log'
    }
  )
end
```

Onde o atributo `verbose: true` serve para obtermos os logs no nível de debug, e no atributo `log_path` você define em qual diretório o log será armazenado.
