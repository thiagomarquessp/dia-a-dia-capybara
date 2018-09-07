## Utilizando o Options do Selenium Webdriver para Chrome

Nas novas versões do Selenium Webdriver, temos uma biblioteca chamada Chrome::Options, que mostra de forma mais "elegante" como podemos configurar o driver para poder executar os testes. Vou listar aqui alguns options que julgo ser importantes na hora de execução.

### Windows Size

No arquivo de configuração (no meu caso o env.rb), podemos definir o windows size da seguinte maneira: 

```ruby
Capybara.register_driver :selenium do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--window-size=1920,1080')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
```

Como vimos, utilizamos a biblioteca Chrome::Options (::Selenium::WebDriver::Chrome::Options.new) instanciada na variável "options" e utilizamos "add_argument" para nesse caso, definir o tamanho da janela (responsividade). Podemos também definir que a janela abra "maximizada", então nesse  caso usamos: 

```ruby
  options.add_argument('start-maximized')
```

### Emulando devices nativos do Google Chrome

Para emular um device nativo no Google Chrome de forma manual, temos que inspecionar elemento e escolhe a opção Devices para fazer alguns testes e nesse caso, temos a opção de escolher o device e dentro do Editar, temos uma outra quantidade de devices que podemos utilizar e eu consigo emular o device passando isso como configuração também com a biblioteca Chrome::Options, segue o exemplo: 

```ruby
Capybara.register_driver :selenium do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new
  options.add_emulation(device_name: 'iPhone 6')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
```

Nesse caso utilizamos o parâmetro "device_name:" e colocamos o nome do device tal qual está escrito no inspect element como falamos acima. Nesse caso, passando o device_name, eu tenho que passar o nome exatamente da forma como está. 

Obs:. Só para entender, eu não gosto muito de usar os devices através do inspect element, porém, as vezes é o que a casa oferece, e se seu caso for executar algum teste em PWA, acaba sendo uma solução OK. 

Podemos também ter algum device não descrito no Chrome como default, porém podemos definir o tamanho da tela do device, e isso é simples de pegar com nossos amigos UX e UI, ou olhando nos sites oficiais (Android, IOs e Windows Phone). Nesse caso ussamos: 

```ruby
Capybara.register_driver :selenium do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new
  options.add_emulation(device_metrics: {width: 400, height: 800, pixelRatio: 1, touch: true})
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
```

Nesse caso, passamos as medidas de Largura(W) e Altura(H), assim como [Pixel Ratio](https://en.wikipedia.org/wiki/Pixel_aspect_ratio) e definindo se com essas medidas vou ativar o touch ou não.

### Utilizando o argumento headless para execução em headless chrome

Também podemos de forma elegante usar a biblioteca Chrome::Options para definir que nossos testes deverão ser executados em headless chrome. No início do headless chrome eu não sentia tanta diferença na performance, coisa que utilizando webkit por exemplo te dava, porém as últimas versões do chromedriver deixou a performance melhor, o que nos leva a crer que vale muito utilizar o headless chrome. Para utilizar segue a configuração: 

```ruby
Capybara.register_driver :selenium do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
```

### User Agents

E também é possível utilizar os user agents que são nativos do chrome ou que sua equipe de desenvolvimento cria, e também passamos como argumento dentro da biblioteca Chrome::Options da seguinte maneira: 

```ruby
Capybara.register_driver :selenium do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--user-agent=Mozilla/5.0 (Windows NT 6.1; WOW64; rv:33.0) Gecko/20120101 Firefox/33.0')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
```
Nesse caso, utilizamos o user agent do Firefox para Windows na versão 33. Caso queira saber todos os user agents do chrome segue [aqui](https://developers.whatismybrowser.com/useragents/explore/software_name/chrome/). O parâmetro que foi passado foi o "'--user-agent=UserAgent'". Ou seja, consigo simular qualquer navegador através do chrome, o que pode ser muito bom para aqueles que não trabalham com browserstack por exemplo. Não é a forma ideal, mas é a que a casa oferece. 

Para quem quer saber mais como funciona a biblioteca, clique [aqui](https://www.rubydoc.info/gems/selenium-webdriver/3.14.0/Selenium/WebDriver/Chrome/Options#add_argument-instance_method)