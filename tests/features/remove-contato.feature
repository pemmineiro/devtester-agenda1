#language: pt

@remover
Funcionalidade: Remover contatos
    Sendo um usuário cadastrado que possui contatos indesejados
    Posso apagar um contsto
    Para manter minha agenda organizada e atualizada
    
    Contexto:

        Dado que estou autenticado com "papito@teste.com" e "abc123"

    @logout
    Cenário: Excluir um contato

        E que possuo a seguinte lista de contatos para cadastro:

            |nome   |email            |celular   |tipo       |
            |Fulano |fulano@marvel.com|2199991991|Whats      |
           
            
        Quando solicito a exclusão deste contato
        E confirmo a exclusão
        Então eu não devo ver este contato na minha agenda

    @logout
    Cenário: Desistir

        E tenho a seguinte lista de contatos para cadastro:

            |nome    |email             |celular   |tipo     |
            |Ciclano |ciclano@marvel.com|2199999999|SMS      |
        
        Quando solicito a exclusão deste contato
        E desisto da exclusão
        Então este contato permanece na minha agenda
