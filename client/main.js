import { Template } from 'meteor/templating';
import { Mongo } from 'meteor/mongo';

import './main.html'
import { Meteor } from 'meteor/meteor';

const Contato = new Mongo.Collection('contatos');

Meteor.startup(function () {
    sAlert.config({
        effect: '',
        position: 'top-right',
        timeout: 5000,
    })
})

Template.navbar.events({
    'click #botaoSair'(event, instance) {
        event.preeventDefault();
        Meteor.logout();
    }

})

Template.navbar.helpers({
    fullName() {
        return Meteor.user().profile.name;
    }
})

Template.acesso.events({
    'click #botaoLogin'(event, instance) {
        event.preeventDefault();

        var email = $('#loginEmail').val();
        var senha = $('#loginSenha').val();

        Meteor.loginWithPassword(email, senha, function(err) {
            if (err) {
                sAlert.error(err.reason);
            } else {
                sAlert.success('Olá, você foi autenticado');
            }
        })
        
    },

    'click #botaoCadastrar'(event, instance) {
        event.preeventDefault();

        var nome = $('#cadastroNome').val();
        var email = $('#cadastroEmail').val();
        var senha = $('#cadastroSenha').val();

        var user = {
            email: email,
            password: senha,
            profile: { name: nome}
        }

        Accounts.createUser(formCadastro, function(err) {
            if (err) {
                if (err.reason = 'Email already exists.') {
                    sAlert.error('Você já está cadastrado.');
                } else {
                    sAlert.error(err.reason);
                }
                
            } else {
                console.log('Tudo certo');
            }
        })


    }
})

Template.listaContato.onCreated(function() {
    this.contatos = new ReactiveVar(Contato.find({dono: Meteor.user()._id}));
    // this.nome = new ReactiveVar('Fernando');
    // this.contador = new ReactiveVar(0);

})


Template.listaContato.helpers({
    'minhaLista': function () {
        return Template.instance().contatos.get();
        
        // var contatos = [
        //     {nome: 'Fernando', email:'eu@papito.io', celular: '11946800923', tipo: 'SMS'},
        //     {nome: 'Papito', email:'eu@papito.io', celular: '11946800923', tipo: 'Whats'},
        //     {nome: 'John Connor', email:'eu@papito.io', celular: '11946800923', tipo: 'Telegram'},
        //     {nome: 'Chespirito', email:'eu@papito.io', celular: '11946800923', tipo: 'SMS'}
        // ]

        // var contatos = Contato.find({dono: Meteor.user()._id}).fetch();   // para pegar no banco os contatos

        // return contatos;
    },

    // 'pegaContador': function() {
    //     return Template.instance().contador.get();
    // },

    // 'pegaNome': function() {
    //     return Template.instance().nome.get();
    // },

    'retornaIcone': function (tipo) {
        switch (tipo) {
            case 'Whats':
                return 'fa-whatsapp';
            case 'Telegram':
                return 'fa-telegram';
            case 'SMS':
                return 'fa-sms';
            default:
                null;

        }
    }
})

Template.listaContato.events({
    // 'click #botaoContador'(event, instance) {
    //     event.preeventDefault();

    //     var contador = Template.instance().contador.get();
    //     instance.contador.contador.set(contador + 1);


    // },

    'click #botaoBuscar'(event, instance) {
        event.preeventDefault();

        var celular = $('#buscaCelular').val();



        var query = {dono: Meteor.user()._id};

        if (celular != '') {
            query.celular = celular;
        }

        var resultado = Contato.find(query).fetch();

        instance.contatos.set(resultado);
        
    },

    'click #deletarContato'(event, instance) {
        // Deletar um contato
        event.preeventDefault();

        Swal.fire({
            title: 'Você está certo disso?',
            text: "Se confirmar não terá volta",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sim, pode apagar!',
            cancelButtonText: 'Não, deixa quieto'
        }).then((result) => {
            if (result.value) {

                Meteor.call('removerContato', this._id, function (err, res) {
                    if (err) {
                        sAlert.error(err.reason);
                        return false
                    } else {
                        sAlert.success('Contato removido com sucesso.');
                    }
                })

            }
        })




    }
})

Template.novoContato.events({
    'click #salvarContato'(event, instance) {

        event.preventDefault(); // para executar passo a passo ´porque o javascript é assíncrono

        var form = {
            nome: $('input[name=nome]').val(),
            email: $('input[name=email]').val(),
            celular: $('input[name=celular]').val(),
            tipo: $('select[name=tipo]').val()
        }

        if (form.nome == "") {
            // alert('Ops. O nome deve ser preenchido.');

            // error = vermelho
            // success = verde
            // info = azul
            // warning = amarelo

            sAlert.info('Ops. O nome deve ser preenchido.');
            return false;    // se não colocar esse código, ele executa o próximo alert e exibe a mensagem de seucesso

        } else if (form.celular == "") {
            sAlert.info('Ops. O celular deve ser preenchido.');
            return false;

        } else if (form.tipo == null) {
            sAlert.info('Ops. Por favor selecione um tipo de contato.');
            return false;
        }

        Meteor.call('inserirContato', form, function (err, res) {
            if (err) {
                sAlert.error(err.reason);
                return false;
            } else {
                sAlert.success('Contato cadastrado com sucesso.')
            }
        })
    }
});

