#language: pt

Funcionalidade: Cadastro
    Sendo um visitante
    Posso fazer meu cadastro com email e senha
    Para que eu possa acessar minha agenda de contatos

    @logout
    Cenário: Cadastro simples

        Dado que eu acessei a página principal
        Quando faço meu cadastro com "eu@papito.io" e senha "abc123"
        Então sou autenticado com sucesso
    
    Cenário: Usuário já cadastrado

        Dado que acessei a página princiál
        Quando faço meu cadastro usando email já cadastrado
        Então vejo a ensagem de alerta "Você já está cadastrado"
