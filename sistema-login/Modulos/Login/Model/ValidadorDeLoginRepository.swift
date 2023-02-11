//
//  ValidadorDeLoginRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 06/12/22.
//

import UIKit

protocol ValidadorDeLoginRepository {
    
    func validarLogin(email: String, senha: String) -> Bool
    
}

class ValidadorDeLoginSystem: ValidadorDeLoginRepository {
    
    private let usuariosArmazenamento: UsuariosDadosStatic
    
    init(usuariosArmazenamento: UsuariosDadosStatic? = nil) {
        self.usuariosArmazenamento = usuariosArmazenamento ?? UsuariosDadosStatic().getInstance()
    }
    
    func validarLogin(email: String, senha: String) -> Bool {
        let listaDeUsuarios = usuariosArmazenamento.getUsuariosSalvos()
        
        for usuario in listaDeUsuarios {
            if email == usuario.getEmailDoUsuario() &&
                senha == usuario.getSenhaDoUsuario() {
                return true
            }
        }
        
        return false
    }
    
}

import SQLite3

class ValidadorDeLoginSQLite: ValidadorDeLoginRepository {
    
    // MARK: - Atributos
    let instanciaDoBanco: OpaquePointer
    
    // MARK: - Inicializadores
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    // MARK: - Funcoes
    func validarLogin(email: String, senha: String) -> Bool {
        let selectStatementString = "SELECT email FROM usuarios WHERE email = ? AND senha = ?;"
        var selectStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, selectStatementString, -1, &selectStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em ValidadorDeLoginSQLite!")
            return false
        }
        
        sqlite3_bind_text(selectStatement, 1, (email as NSString).utf8String, -1, nil)
        sqlite3_bind_text(selectStatement, 2, (senha as NSString).utf8String, -1, nil)
    
        if sqlite3_step(selectStatement) != SQLITE_ROW {
            sqlite3_finalize(selectStatement)
            return false
        }
        
        let emailVindoDoBanco = String(describing: String(cString: sqlite3_column_text(selectStatement, 0)))
        
        sqlite3_finalize(selectStatement)
        
        if emailVindoDoBanco != email {
            return false
        }
        
        return true
    }
}
