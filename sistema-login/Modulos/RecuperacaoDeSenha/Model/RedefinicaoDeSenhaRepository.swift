//
//  RedefinicaoDeSenha.swift
//  sistema-login
//
//  Created by Leonardo Leite on 01/12/22.
//

import UIKit

protocol RedefinicaoDeSenhaRepository {

    func redefinirSenha(email: String, senha: String) -> Bool
       
}

class RedefinicaoDeSenhaSystem: RedefinicaoDeSenhaRepository {
    
    private let usuariosArmazenamento: UsuariosDadosStatic
    
    init(usuariosArmazenamento: UsuariosDadosStatic? = nil) {
        self.usuariosArmazenamento = usuariosArmazenamento ?? UsuariosDadosStatic().getInstance()
    }
    
    public func redefinirSenha(email: String, senha: String) -> Bool {
        let usuariosSalvos = usuariosArmazenamento.getUsuariosSalvos()
        
        for usuario in usuariosSalvos {
            if usuario.getEmailDoUsuario() == email {
                usuario.alterarSenha(senha)

                return true
            }
        }
        
        return false
    }
}

import SQLite3

class RedefinicaoDeSenhaSQLite: RedefinicaoDeSenhaRepository {
    
    // MARK: - Atributos
    let instanciaDoBanco: OpaquePointer
    
    // MARK: - Inicializador
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    // MARK: - Funcoes
    func redefinirSenha(email: String, senha: String) -> Bool {
        let updateStatementString = "UPDATE usuarios SET senha = ? WHERE email = ?;"
        var updateStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, updateStatementString, -1, &updateStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em RedefinicaoDeSenhaSQLite!")
            return false
        }
        
        sqlite3_bind_text(updateStatement, 1, (senha as NSString).utf8String, -1, nil)
        sqlite3_bind_text(updateStatement, 2, (email as NSString).utf8String, -1, nil)
    
        if sqlite3_step(updateStatement) != SQLITE_DONE {
            print("Erro ao alterar senha")
            sqlite3_finalize(updateStatement)
            return false
        }
        
        sqlite3_finalize(updateStatement)
        return true
        
    }
    
}
