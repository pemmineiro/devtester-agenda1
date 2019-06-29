#language: pt

Funcionalidade: Login

    Sendo um usuário já cadastrado
    Posso acessar o sistema com email e senha
    Para que somennte eu possa ver meus contatos e gerenciar minha agenda

    Cenário: Login do usuário

        Dado que eu acessei a página principal
        Quando eu faço login com "eu@papito.io" e senha "abc123"
        Então sou autenticado com sucesso

    Cenário: Email não cadastrado

        Dado que eu acessei a página principal
        Quando eu faço login com email não cadastrado
        Então vejo a mensagem de alerta "Email e ou senha incorretos."

    Cenário: Senha inválida

        Dado que eu acessei a página principal
        Quando eu faço login com senha incorreta
        Então vejo a mensagem de alerta "Email e ou senha incorretos."