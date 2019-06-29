# script para preparar a massa de testes
# limpar a collection - MongoDB é banco de dados não relacional, orientado a documento
# para fazer isso, tem que ir no CMD e executar: ruby features/support/lib/dao.rb
require 'mongo'



client = Mongo::Client.new('mongodb://127.0.0.1:3001/meteor')
contatos = client[:contatos]
contatos.delete_many
