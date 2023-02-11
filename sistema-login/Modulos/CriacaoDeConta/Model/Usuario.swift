//
//  Usuario.swift
//  sistema-login
//
//  Created by Leonardo Leite on 08/11/22.
//

import UIKit

class Usuario {
    
    // MARK: - Atributos
    private let nickName: String
    private let nomeCompleto: String
    private let email: String
    private var senha: String
    private let repeticaoDeSenha: String
    
    init(nickName: String, nomeCompleto: String, email: String, senha: String, repeticaoDeSenha: String) {
        self.nickName = nickName
        self.nomeCompleto = nomeCompleto
        self.email = email
        self.senha = senha
        self.repeticaoDeSenha = repeticaoDeSenha
    }
    
    public func getNickNameDeUsuario() -> String {
        return self.nickName
    }
    
    public func getNomeCompletoDoUsuario() -> String {
        return self.nomeCompleto
    }
    
    public func getEmailDoUsuario() -> String {
        return self.email
    }
    
    public func getSenhaDoUsuario() -> String {
        return self.senha
    }
    
    public func getRepeteSenhaDoUsuario() -> String {
        return self.repeticaoDeSenha
    }
    
    public func alterarSenha(_ senha: String) -> Void {
        self.senha = senha
    }
    
}
