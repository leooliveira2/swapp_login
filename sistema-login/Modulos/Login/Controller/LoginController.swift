//
//  LoginController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 10/11/22.
//

import UIKit

class LoginController {
    
    private let controladorDeErros: ControladorDeErros
    private let validadorDeLogin: ValidadorDeLoginRepository
    private let validadorDeUsuario: ValidacoesDeDadosDoUsuario
    private let recuperaDadosDoUsuario: RecuperaDadosDoUsuarioRepository
    
    init(
        _ controladorDeErros: ControladorDeErros,
        _ validadorDeLogin: ValidadorDeLoginRepository,
        _ validadorDeUsuario: ValidacoesDeDadosDoUsuario,
        _ recuperaDadosDoUsuario: RecuperaDadosDoUsuarioRepository
    )
    {
        self.controladorDeErros = controladorDeErros
        self.validadorDeLogin = validadorDeLogin
        self.validadorDeUsuario = validadorDeUsuario
        self.recuperaDadosDoUsuario = recuperaDadosDoUsuario
    }
    
    public func fazerLogin(email: String?, senha: String?) -> Bool {
        guard let email,
              let senha else
        {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroAlgumDadoDoUsuarioEstaNulo()
            )
            return false
        }
        
        let loginPodeSerRealizado = self.verificaSeLoginPodeSerRealizado(email, senha)
        
        if !loginPodeSerRealizado {
            return false
        }
        
        self.configuraLoginAutomaticoNasProximasSessoes(email: email)
        
        return true
    }
    
    private func verificaSeLoginPodeSerRealizado(_ email: String, _ senha: String) -> Bool {
        let emailEstaVazio = self.validadorDeUsuario.emailDoUsuarioEstaVazio(email)
        let senhaEstaVazia = self.validadorDeUsuario.senhaDoUsuarioEstaVazia(senha)
        
        if emailEstaVazio || senhaEstaVazia {
            return false
        }
        
        let loginNaoPodeSerRealizado = !self.validadorDeUsuario.verificaSeLoginPodeSerRealizado(email, senha, self.validadorDeLogin)
        
        if loginNaoPodeSerRealizado {
            return false
        }
        
        return true
    }
    
    private func configuraLoginAutomaticoNasProximasSessoes(email: String) -> Void {
        guard let nickName = self.recuperaDadosDoUsuario.getNickNameDoUsuario(email: email) else { return }
        
        UserDefaults.standard.set(true, forKey: "esta_logado")
        UserDefaults.standard.set(nickName, forKey: "user_id")
    }

}

