//
//  Erros.swift
//  sistema-login
//
//  Created by Leonardo Leite on 08/11/22.
//

import Foundation

// MARK: - Protocolos
protocol ErrosGerais {
    func erroAlgumDadoDoUsuarioEstaNulo() -> String
}

protocol ErrosValidacoesNickName {
    func erroNickDeUsuarioVazio() -> String
    
    func erroNickDeUsuarioTemMenosDe5Caracteres() -> String
    
    func erroNickDeUsuarioNaoPodeTerMaisDe32Caracteres() -> String
    
    func erroNickDeUsuarioNaoEUmAlfanumerico() -> String
    
    func erroNickDeUsuarioJaEstaCadastrado() -> String
}

protocol ErrosValidacoesNomeCompleto {
    func erroNomeCompletoVazio() -> String
    
    func erroNomeCompletoSoPodeConterLetrasEEspacos() -> String
    
    func erroNomeCompletoNaoPodeTerMaisDe130Caracteres() -> String
}

protocol ErrosValidacoesEmail {
    func erroEmailVazio() -> String
    
    func erroEmailInvalido() -> String
    
    func erroEmailTemMaisDe150Caracteres() -> String
    
    func erroEmailJaEstaCadastrado() -> String
}

protocol ErrosValidacoesSenha {
    func erroSenhaVazia() -> String
    
    func erroSenhaTemMenosDe8Caracteres() -> String
    
    func erroSenhaTemMaisDe32Caracteres() -> String
}

protocol ErrosValidacoesRepeticaoSenha {
    func erroRepeticaoDeSenhaVazio() -> String
    
    func erroRepeticaoDeSenhaESenhaSaoDiferentes() -> String
}

protocol ErrosLogin {
    func erroEmailNaoEncontrado() -> String
    
    func erroCadastroNaoEncontrado() -> String
}

protocol ErrosCriacaoDeConta {
    func erroAoSalvarUsuario() -> String
}

protocol ErrosRedefinicaoDeSenha {
    func erroAoSalvarNovaSenha() -> String
}

// MARK: - Erros
class Erros {}

extension Erros: ErrosGerais {
    func erroAlgumDadoDoUsuarioEstaNulo() -> String {
        return "Tente novamente!"
    }
}

extension Erros: ErrosValidacoesNickName {
    
    func erroNickDeUsuarioVazio() -> String {
        return "O campo apelido do usuário não pode ser vazio!"
    }
    
    func erroNickDeUsuarioTemMenosDe5Caracteres() -> String {
        return "O apelido de usuário não pode ter menos de 5 caracteres!"
    }
    
    func erroNickDeUsuarioNaoPodeTerMaisDe32Caracteres() -> String {
        return "O apelido de usuário pode conter no máximo 32 caracteres!"
    }
    
    func erroNickDeUsuarioNaoEUmAlfanumerico() -> String {
        return "O apelido só pode conter letras (sem acentos ou espaços) ou números!"
    }
    
    func erroNickDeUsuarioJaEstaCadastrado() -> String {
        return "Apelido escolhido já está em uso! Por favor, escolha outro!"
    }
}

extension Erros: ErrosValidacoesNomeCompleto {
    func erroNomeCompletoVazio() -> String {
        return "O campo nome não pode ser vazio!"
    }
    
    func erroNomeCompletoSoPodeConterLetrasEEspacos() -> String {
        return "O nome só pode conter letras e espaços!"
    }
    
    func erroNomeCompletoNaoPodeTerMaisDe130Caracteres() -> String {
        return "O nome pode conter no máximo 130 caracteres!"
    }
    
}

extension Erros: ErrosValidacoesEmail {
    func erroEmailVazio() -> String {
        return "O campo e-mail não pode ser vazio!"
    }
    
    func erroEmailInvalido() -> String {
        return "O e-mail informado é inválido!"
    }
    
    func erroEmailTemMaisDe150Caracteres() -> String {
        return "O e-mail pode conter no máximo 150 caracteres!"
    }
    
    func erroEmailJaEstaCadastrado() -> String {
        return "Este e-mail já está cadastrado! Por favor, escolha outro!"
    }
}

extension Erros: ErrosValidacoesSenha {
    func erroSenhaVazia() -> String {
        return "O campo senha não pode ser vazio!"
    }
    
    func erroSenhaTemMenosDe8Caracteres() -> String {
        return "A senha precisa ter no mínimo 8 caracteres!"
    }
    
    func erroSenhaTemMaisDe32Caracteres() -> String {
        return "A senha pode conter no máximo 32 caracteres!"
    }
}

extension Erros: ErrosValidacoesRepeticaoSenha {
    func erroRepeticaoDeSenhaVazio() -> String {
        return "O campo repetição da senha não pode ser vazio!"
    }
    
    func erroRepeticaoDeSenhaESenhaSaoDiferentes() -> String {
        return "A repetição da senha e a senha devem ser iguais!"
    }
}

extension Erros: ErrosLogin {
    func erroEmailNaoEncontrado() -> String {
        return "E-mail não encontrado!"
    }
    
    func erroCadastroNaoEncontrado() -> String {
        return "Usuário não encontrado! Verifique seus dados e tente novamente"
    }
}

extension Erros: ErrosCriacaoDeConta {
    func erroAoSalvarUsuario() -> String {
        return "Erro ao salvar seu usuário! Por favor, tente novamente"
    }
}

extension Erros: ErrosRedefinicaoDeSenha {
    func erroAoSalvarNovaSenha() -> String {
        return "Erro ao salvar nova senha! Por favor, tente novamente"
    }
}
