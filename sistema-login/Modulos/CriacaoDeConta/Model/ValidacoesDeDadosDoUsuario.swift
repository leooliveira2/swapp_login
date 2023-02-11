//
//  ValidacaoDeUsuarioParaCadastro.swift
//  sistema-login
//
//  Created by Leonardo Leite on 08/11/22.
//

import UIKit

class ValidacoesDeDadosDoUsuario {
    
    // MARK: - Atributos
    private let controladorDeErros: ControladorDeErros
    
    // MARK: - Inicializador
    init(_ controladorDeErros: ControladorDeErros) {
        self.controladorDeErros = controladorDeErros
    }
    
    // MARK: - Validacoes de NickName
    public func nickNameDoUsuarioEstaVazio(_ nickName: String) -> Bool {
        let nickNameDoUsuarioEstaVazio = strlen(nickName) == 0
        if nickNameDoUsuarioEstaVazio {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroNickDeUsuarioVazio()
            )
            
            return true
        }
        
        return false
    }
    
    public func nickNameDoUsuarioTemMenosDe5Caracteres(_ nickName: String) -> Bool {
        let nickNameDoUsuarioTemMenosDe5Caracteres = strlen(nickName) < 5
        if nickNameDoUsuarioTemMenosDe5Caracteres {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroNickDeUsuarioTemMenosDe5Caracteres()
            )
            
            return true
        }
        
        return false
    }
    
    public func nickNameDoUsuarioTemMaisDe32Caracteres(_ nickName: String) -> Bool {
        let nickNameDoUsuarioTemMaisDe32Caracteres = strlen(nickName) > 32
        if nickNameDoUsuarioTemMaisDe32Caracteres {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroNickDeUsuarioNaoPodeTerMaisDe32Caracteres()
            )
            
            return true
        }
        
        return false
    }
    
    public func nickNameDoUsuarioNaoEUmAlfaNumerico(_ nickName: String) -> Bool {
        let nickNameDoUsuarioNaoEUmAlfaNumerico = !nickName.isAlphanumeric
        if nickNameDoUsuarioNaoEUmAlfaNumerico {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroNickDeUsuarioNaoEUmAlfanumerico()
            )
            
           return true
        }
        
        return false
    }
    
    public func nickNameDoUsuarioJaEstaCadastrado(
        _ nickName: String,
        _ verificadorDeDadosCadastrados: VerificadorDeDadosCadastradosRepository
    ) -> Bool {
        let nickNameDeUsuarioJaEstaCadastrado = verificadorDeDadosCadastrados.verificaSeNickNameJaEstaCadastrado(nickName)
        
        if nickNameDeUsuarioJaEstaCadastrado {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroNickDeUsuarioJaEstaCadastrado()
            )
            
            return true
        }
        
        return false
    }
    
    // MARK: - Validacoes de nome
    public func nomeCompletoDoUsuarioEstaVazio(_ nomeCompleto: String) -> Bool {
        let nomeCompletoDoUsuarioEstaVazio = strlen(nomeCompleto) == 0
        if nomeCompletoDoUsuarioEstaVazio {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroNomeCompletoVazio()
            )
            
            return true
        }
        
        return false
    }
    
    public func nomeCompletoDoUsuarioContemCaracteresInvalidos(_ nomeCompleto: String) -> Bool {
        let nomeCompletoDoUsuarioContemCaracteresInvalidos = !nomeCompleto.isAlphabetic
        if nomeCompletoDoUsuarioContemCaracteresInvalidos {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroNomeCompletoSoPodeConterLetrasEEspacos()
            )
            
            return true
        }
        
        return false
    }
    
    public func nomeCompletoDoUsuarioTemMaisDe130Caracteres(_ nomeCompleto: String) -> Bool {
        let nomeCompletoDoUsuarioTemMaisDe130Caracteres = strlen(nomeCompleto) > 130
        if nomeCompletoDoUsuarioTemMaisDe130Caracteres {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroNomeCompletoNaoPodeTerMaisDe130Caracteres()
            )
            
            return true
        }
        
        return false
    }
    
    // MARK: - Validacoes de email
    public func emailDoUsuarioEstaVazio(_ email: String) -> Bool {
        let emailDoUsuarioEstaVazio = strlen(email) == 0
        if emailDoUsuarioEstaVazio {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroEmailVazio()
            )
            
            return true
        }
        
        return false
    }
    
    public func emailDoUsuarioEInvalido(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let emailDoUsuarioNaoEValido = !emailPred.evaluate(with: email)
        
        if emailDoUsuarioNaoEValido {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroEmailInvalido()
            )
            
            return true
        }
        
        return false
    }
    
    public func emailDoUsuarioTemMaisDe150Caracteres(_ email: String) -> Bool {
        let emailDoUsuarioTemMaisDe150caracteres = strlen(email) > 150
        if emailDoUsuarioTemMaisDe150caracteres {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroEmailTemMaisDe150Caracteres()
            )
            
            return true
        }
        
        return false
    }
    
    public func emailDoUsuarioJaEstaCadastrado(
        _ email: String,
        _ verificadorDeDadosCadastrados: VerificadorDeDadosCadastradosRepository
    ) -> Bool {
        let emailDoUsuarioJaEstaCadastrado = verificadorDeDadosCadastrados.verificaSeEmailJaEstaCadastrado(email)
        
        if emailDoUsuarioJaEstaCadastrado {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroEmailJaEstaCadastrado()
            )
            
            return true
        }
        
        return false
    }
    
    // MARK: - Validacoes de senha
    public func senhaDoUsuarioEstaVazia(_ senha: String) -> Bool {
        let senhaDoUsuarioEstaVazia = strlen(senha) == 0
        if senhaDoUsuarioEstaVazia {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroSenhaVazia()
            )
            
            return true
        }
        
        return false
    }
    
    public func senhaDoUsuarioTemMenosQue8Caracteres(_ senha: String) -> Bool {
        let senhaDoUsuarioTemMenosQue8Caracteres = strlen(senha) < 8
        if senhaDoUsuarioTemMenosQue8Caracteres {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroSenhaTemMenosDe8Caracteres()
            )
            
            return true
        }
        
        return false
    }
    
    public func senhaDoUsuarioTemMaisQue32Caracteres(_ senha: String) -> Bool {
        let senhaDoUsuarioTemMaisQue32Caracteres = strlen(senha) > 32
        if senhaDoUsuarioTemMaisQue32Caracteres {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroSenhaTemMaisDe32Caracteres()
            )
            
            return true
        }
        
        return false
    }
    
    // MARK: - Validacoes da repeticao da senha
    public func repeticaoDaSenhaDoUsuarioEstaVazia(_ repeticaoDeSenha: String) -> Bool {
        let repeticaoDaSenhaDoUsuarioEstaVazia = strlen(repeticaoDeSenha) == 0
        if repeticaoDaSenhaDoUsuarioEstaVazia {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroRepeticaoDeSenhaVazio()
            )
            
            return true
        }
        
        return false
    }
    
    public func repeticaoDaSenhaDoUsuarioEDiferenteDaSenha(_ senha: String, _ repeticaoDeSenha: String) -> Bool {
        let repeticaoDaSenhaDoUsuarioEDiferenteDaSenha = senha != repeticaoDeSenha
        if repeticaoDaSenhaDoUsuarioEDiferenteDaSenha {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroRepeticaoDeSenhaESenhaSaoDiferentes()
            )
            
            return true
        }
        
        return false
    }
    
    // MARK: - Validacoes de login
    public func verificaSeLoginPodeSerRealizado(
        _ email: String,
        _ senha: String,
        _ validadorDeLogin: ValidadorDeLoginRepository
    ) -> Bool
    {
        let loginPodeSerRealizado = validadorDeLogin.validarLogin(email: email, senha: senha)
        
        if !loginPodeSerRealizado {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroCadastroNaoEncontrado()
            )
            
            return false
        }
        
        return true
        
    }
    
}

// MARK: - Extensoes
extension String {
    var isAlphanumeric: Bool {
        !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isAlphabetic: Bool {
        !isEmpty && range(of: "[^A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ' ]", options: .regularExpression) == nil
    }
}
