# require 'mongo'

# Before(@sprint1) do
#     # limpar a collection - MongoDB é banco de dados não relacional, orientado a documento
#     client = Mongo::Client.new('mongodb://127.0.0.1:3001/meteor')
#     contatos = client[:contatos]
#     contatos.delete_many

# end


Before do
    @contato_page = ContatoPage.new
    @acesso_page = AcessoPage.new
end

After('@logout') do
    click_button 'Sair'
    page.has_css?('form[id=login]')
end

After('@insert_contato') do   #para verificar se foi inserido corretamente no banco de dados
    res = DAO.new.busca_por_celular(@novo_contato[:celular])

    expect(res[:nome]).to eql @novo_contato[:nome]    # para verificar se o que foi inserido bate com o banco de dados
    expect(res[:email]).to eql @novo_contato[:email] 
    expect(res[:celular]).to eql @novo_contato[:celular]
    expect(res[:tipo]).to eql @novo_contato[:tipo]

end