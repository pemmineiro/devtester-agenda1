require 'mongo'


class DAO

    def busca_por_celular(celular)    
        # no ruby, toda última instrução de um método retorna automaticamente, não precisa colocar return
        contatos.find( 'celular' => @novo_contato[:celular] ).first   # celular é a informação que não pode ser igual para contatos diferentes
        
    end

    def busca_por_nome(nome)
        contatos.find('nome' => nome).first
    end

    def delete_por_celular(celular)
        contatos.delete_many('celular' => celular)
    end

    def limpa_contatos(email_usuario)
        u = usuarios.find('emails.address' => email_usuario).first
        contatos.delete_many('dono' => u[:_id])
    end


    private
    def conecta
        Mongo::Logger.logger = Logger.new('log/mongo.log')  # para gravar num arquivo de log ao invés de ficar mostrando no terminal
        Mongo::Client.new('mongodb://127.0.0.1:3001/meteor')
    end

    def usuarios
        conecta[:users]

    def contatos
        conecta[:contatos]
    end

end


