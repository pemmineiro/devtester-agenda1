#language: pt

Funcionalidade: Lista contatos
    Sendo um usuário que possui contatos cadastrados
    POsso acessar a minha agenda
    Para que eu possa ver a minha lista de contatos

    @temp1
    Cenário: Listar contatos

        Dado que estou autenticado com "papito@teste.com" e "abc123"
        E tenho a seguinte lista de contatos para cadastro:

            |nome         |email           |celular   |tipo     |
            |Peter Parker |peter@marvel.com|1199991991|SMS      |
            |Nick Fury    |nick@stark.com  |1199991992|Telegram |
            

        Quando acesso a minha agenda
        Então devo ver estes registros na lista de contatos

    @temp2
    Cenário: Nenhum contato cadastrado

        Dado que estou autenticado com "papito@yahoo.com" e "abc123"
        E não possuo contatos cadastrados
        Quando acesso a minha agenda
        Então devo ver a mensagem "Nenhum contato encontrado."