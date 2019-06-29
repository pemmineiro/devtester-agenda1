#language: pt

@busca
Funcionalidade: Busca contato
    Sendo um usuário
    Posso buscar contatos pelo celular
    Para que seja fácil filtrar os dados da minha agenda

    Contexto: Lista para busca
        Dado que estou autenticado com "papito@teste.com" e "abc123"
        E tenho a seguinte lista de contatos para cadastro:

            |nome        |email          |celular   |tipo     |
            |Wade Wilson |wade@marvel.com|1199991001|Whats    |
            |Tony Stark  |tonny@stark.com|1199991002|Telegram |
            |Steve Rogers|rogers@aol.com |1199991003|SMS      |
            |Bruce Barner|               |1199991004|SMS      |


    Cenário: Buscar pelo celular
        Quando faço a busca pelo celular "1199991002"
        Então devo somente ver o seguinte contato "Tony Stark"

    Cenário: Dados não encontrados
        Quando faço a busca pelo celular "21999999999"
        Então devo ver a seguinte mensagem "Nenhum contato encontrado."
