#language: pt

Funcionalidade: Novo Contato
    Sendo um usuario 
    Posso realizar um novo cadastro
    Para poder gerenciar minha rede de contatos

    @sprint1 @insert_contato @logout
    Esquema do Cenario: Novo contato

        Dado que estou autenticado com "eu@papito.io" e "abc123"

        E que possuo o seguinte contato:
            |nome   |<nome>   |
            |email  |<email>  |
            |celular|<celular>|
            |tipo   |<tipo>   |
        Quando faço o cadastro deste novo contato
        Então devo ver a seguinte mensagem de alerta "Contato cadastrado com sucesso."
               
        Exemplos:
        |nome        |email          |celular   |tipo     |
        |Wade Wilson |wade@marvel.com|1199991001|Whats    |
        |Tony Stark  |tonny@stark.com|1199991002|Telegram |
        |Steve Rogers|rogers@aol.com |1199991003|SMS      |
        |Bruce Barner|               |1199991004|SMS      |

    Cenário: Lista de contatos
        Dado que estou autenticado com "fernandou@ninjalive.com.br" e "abc123"
        Quando faço o cadastro dos seguintes contatos:

            |nome        |email          |celular   |tipo     |
            |Wade Wilson |wade@marvel.com|1199991001|Whats    |
            |Tony Stark  |tonny@stark.com|1199991002|Telegram |
            |Steve Rogers|rogers@aol.com |1199991003|SMS      |
            |Bruce Barner|               |1199991004|SMS      |

        Então devo ver "Contato cadastrado com sucesso." como mensagem de alerta


    @sprint2
    Esquema do Cenário: Campos obrigatórios

        Dado que estou autenticado com "fernandou@ninjalive.com.br" e "abc123"
        E que possuo o seguinte contato:
            |nome   |<nome>   |
            |celular|<celular>|
            |tipo   |<tipo>   |
        Quando faço o cadastro deste novo contato
        Então devo ver a seguinte mensagem de alerta "<mensagem>"
        E este contato não deve ser inserido no banco de dados

        Exemplos:
        |nome        |celular   |tipo     |mensagem                                    |
        |            |1199991005|Whats    |Ops. O nome deve ser preenchido.            |
        |Peter Parker|          |Telegram |Ops. O celular deve ser preenchido.         |
        |Scott Lang  |1199991006|         |Ops. Por favor selecione um tipo de contato.|

    
    @sprint3
    Cenário: Celular não pode ser duplicado

        Dado que estou autenticado com "eu@papito.io" e "abc123"
        E que possuo o seguinte contato:
            |nome   |Fernando Papito   |
            |email  |eu@papito.io      |
            |celular|11946800923       |
            |tipo   |Whats             |
        Mas já existe um contato cadastrado com este celular
        Quando faço o cadastro deste novo contato
        Então devo ver a seguinte mensagem de alerta "Contato já cadastrado."