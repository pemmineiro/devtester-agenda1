Dado("que estou autenticado com {string} e {string}") do |email, senha|
    @acesso_page.acesso_page
    @acesso_page.logar(email,senha)
    expect(@contato_page.titulo).to eql 'Meus Contatos'
    @email_usuario = email
    @contato_page.fecha_salert
end


# Dado("que {string} é meu novo contato") do |nome|
#     @nome = nome   #variável de que fica disponível durante toda a execução do cenário, como se fosse uma variável estática do JAVA
    
# end
  
# Dado("este contato possui os seguintes dados:") do |table|
#     @dados_contato = table.rows_hash
# end

Dado("que possuo o seguinte contato:") do |table|
    @novo_contato = table.rows_hash
end

Dado('já existe um contato cadastrado com este celular') do
    @contato_page.visita
    @contato_page.salvar(@novo_contato)
end

  
Quando("faço o cadastro deste novo contato") do

    @contato_page.visita
    @contato_page.salvar(@novo_contato)

#    fill_in 'nome', with: @nome
#    fill_in 'email', with: @dados_contato[:email]
#    fill_in 'celular', with: @dados_contato[:celular]    
end


Quando("faço o cadastro dos seguintes contatos:") do |table|
    @contatos = table.hashes
    @alertas = []

    @contatos.each do |c|
        @contato_page.salvar(c)
        @alertas.push(@contato_page.msg_alert_box.text)
        @contato_page.fecha_salert
    end
end


Então("devo ver a seguinte mensagem de alerta {string}") do |mensagem|
    expect(@contato_page.msg_alert_box).to have_content mensagem
end

# foi jogado para o arquivo hooks
# Então("este contato deve ser inserido no banco de dados") do
    
#     res = DAO.new.busca_por_celular(@novo_contato[:celular])

#     expect(res[:nome]).to eql @novo_contato[:nome]    # para verificar se o que foi inserido bate com o banco de dados
#     expect(res[:email]).to eql @novo_contato[:email] 
#     expect(res[:celular]).to eql @novo_contato[:celular]
#     expect(res[:tipo]).to eql @novo_contato[:tipo]
# end
  
Então("este contato não deve ser inserido no banco de dados") do
    
    res = DAO.new.busca_por_celular(@novo_contato[:celular])

    expect(res).to be_nil
end

# Então("devo ver a seguinte mensagem de sucesso {string}") do |mensagem|
#     # expect(page).to have_content mensagem      (se fosse uma página)

#     alert = page.driver.browser.switch_to.alert.text    # para pegar o texto do pop up de confirmação
#     expect(alert).to eql mensagem
# end

# Então("devo ver a seguinte {string} de alerta") do |mensagem|
#     alert = page.driver.browser.switch_to.alert.text
#     expect(alert).to eql mensagem
#     sleep 3
# end
  
Então("devo ver {string} como mensagem de alerta") do |msg_alerta|
    @alertas.each do |a|
        expect(a).to eql msg_alerta
    end
end


# Lista


Dado('tenho a seguinte lista de contatos para cadastro:') do |table|
    @lista_contato = table.hashes

    @contato_page.visita

    @lista_contato.each do |contato|
        @contato_page.salvar(contato)
    end

# Caso o time tenha priorizado a tela de listar contato antes de fazer a de incluir, o teste terá que ser 
# feito pelo banco de dados:
# Substituir o Page Object Salvar COntato por Insert no Banco
# https://docs.mongodb.com/ruby-driver/master/quick-start/#insert-a-document
end

Dado("não possuo contatos cadastrados") do
    DAO.new.limpa_contatos(@email_usuario)
end

Quando('acesso a minha agenda') do
    @contato_page.visita
end

Quando("solicito a exclusão deste contato") do
    @celular = @lista_contato.first[:celular]
    @contato_page.remover(@celular)
end

Quando("confirmo a exclusão") do
    @contato_page.cancela_modal

end

Quando("desisto da exclusão") do
    @contato_page.confirma_modal
end


Então('devo ver estes registros na lista de contatos') do
    # tabela = find('.table')
    # expect(lista).to have_content @lista_contato[0][:nome]
    # expect(lista).to have_content @lista_contato[0][:email]
    # expect(lista).to have_content @lista_contato[0][:celular]
    # expect(lista).to have_content @lista_contato[0][:tipo]

    # Esse código não pega o bug de estar cadastrado email incorreto no banco de dados. tem que validar linha por linha
    # @lista_contato.each do |contato|
    #     expect(tabela).to have_content contato[:nome]
    #     expect(tabela).to have_content contato[:email]
    #     expect(tabela).to have_content contato[:celular]
    #     expect(tabela).to have_content contato[:tipo]
    # end

    trs = @contato_page.retorna_trs
    @lista_contato.each_with_index do |v, i|
        expect(trs[i]).to have_content v[:nome]
        expect(trs[i]).to have_content v[:email]
        expect(trs[i]).to have_content v[:celular]
        expect(trs[i]).to have_content v[:tipo]

    end
end

Então("devo ver a mensagem {string}") do |msg_alerta|
    expect(@contato_page.msg_alert_info).to eql msg_alerta   # como retorna string, tem que usar eql

end

Então('eu não devo ver este contato na minha agenda') do
    res = DAO.new.busca_por_celular(@celular)
    expect(res)to be_nil
end

Então("este contato permanece na minha agenda") do
    res = DAO.new.busca_por_celular(@celular)
    expect(res[:celular]).to eql @celular
end