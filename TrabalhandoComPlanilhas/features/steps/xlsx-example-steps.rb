Dado("que eu acesse a planilha xlsx") do
  # Aqui você acessa a planilha. Eu passei o caminho completo mas tu pode passar o relativo OK.
  @acessa_planilha = Roo::Spreadsheet.open('../TrabalhandoComPlanilhas/features/steps/xlsx_example.xlsx')
end

Quando("eu identificar as celular com os dados de usuario e senha") do
  # Como falado no README, nesse momento eu seto o nome da planilha que eu quero e procuro a célula onde está meu usuario e senha
  @user = @acessa_planilha.sheet('data_login').cell('A', 4).to_s
  @password = @acessa_planilha.sheet('data_login').cell('B', 4).to_s
end

Entao("consigo usar em qualquer lugar da minha automacao") do
  expect(@user).to eq 'admin'
  expect(@password).to eq 'Inicial1234'
  puts 'Aqui você tem o usuário: ' + @user
  puts 'Aqui você tem o password: ' + @password
end
