//
//  SalvarUsuario.swift
//  sistema-login
//
//  Created by Leonardo Leite on 01/12/22.
//

import UIKit

protocol SalvarUsuarioRepository {

    func salvar(_ usuario: Usuario) -> Bool
    
}

class SalvarUsuarioSystem: SalvarUsuarioRepository {
    
    private let usuariosArmazenamento: UsuariosDadosStatic
    
    init(usuariosArmazenamento: UsuariosDadosStatic? = nil) {
        self.usuariosArmazenamento = usuariosArmazenamento ?? UsuariosDadosStatic().getInstance()
    }
    
    public func salvar(_ usuario: Usuario) -> Bool {
        usuariosArmazenamento.salvarUsuario(usuario)
        
        return true
    }
    
}

import SQLite3

class SalvarUsuarioSQLite: SalvarUsuarioRepository {
    
    // MARK: - Atributos
    let instanciaDoBanco: OpaquePointer
    
    // MARK: - Inicializador
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    // MARK: - Funcoes
    func salvar(_ usuario: Usuario) -> Bool {
        let insertStatementString = "INSERT INTO usuarios(nickName, nomeCompleto, email, senha) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, insertStatementString, -1, &insertStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em SalvarUsuarioSQLite!")
            return false
        }
        
        sqlite3_bind_text(insertStatement, 1, (usuario.getNickNameDeUsuario() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 2, (usuario.getNomeCompletoDoUsuario() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 3, (usuario.getEmailDoUsuario() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 4, (usuario.getSenhaDoUsuario() as NSString).utf8String, -1, nil)
        
        if sqlite3_step(insertStatement) != SQLITE_DONE {
            print("Erro ao fazer insercao em SalvarUsuarioSQLite!")
            sqlite3_finalize(insertStatement)
            return false
        }
        
        sqlite3_finalize(insertStatement)
        return true
    }
    
}
