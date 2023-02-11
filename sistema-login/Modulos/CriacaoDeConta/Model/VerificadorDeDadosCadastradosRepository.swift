//
//  VerificadorDeDadosJaCadastradosRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 06/12/22.
//

import UIKit

protocol VerificadorDeDadosCadastradosRepository {
    
    func verificaSeNickNameJaEstaCadastrado(_ nickName: String) -> Bool
    
    func verificaSeEmailJaEstaCadastrado(_ email: String) -> Bool
}

class VerificadorDeDadosCadastradosSystem: VerificadorDeDadosCadastradosRepository {
    
    private let usuariosArmazenamento: UsuariosDadosStatic
    
    init(usuariosArmazenamento: UsuariosDadosStatic? = nil) {
        self.usuariosArmazenamento = usuariosArmazenamento ?? UsuariosDadosStatic().getInstance()
    }
    
    public func verificaSeNickNameJaEstaCadastrado(_ nickName: String) -> Bool {
        let usuariosSalvos = usuariosArmazenamento.getUsuariosSalvos()
        
        for usuario in usuariosSalvos {
            if usuario.getNickNameDeUsuario() == nickName {
                return true
            }
        }
        
        return false
    }
    
    public func verificaSeEmailJaEstaCadastrado(_ email: String) -> Bool {
        let usuariosSalvos = usuariosArmazenamento.getUsuariosSalvos()
        
        for usuario in usuariosSalvos {
            if usuario.getEmailDoUsuario() == email {
                return true
            }
        }
        
        return false
    }
    
}

import SQLite3

class VerificadorDeDadosCadastradosSQLite: VerificadorDeDadosCadastradosRepository {
    
    // MARK: - Atributos
    let instanciaDoBanco: OpaquePointer
    
    // MARK: - Inicializador
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    // MARK: - Funcoes
    func verificaSeNickNameJaEstaCadastrado(_ nickName: String) -> Bool {
        let selectStatementString = "SELECT nickName FROM usuarios WHERE nickName = ?;"
        var selectStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, selectStatementString, -1, &selectStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em VerificadorDeDadosCadastradosSQLite!")
            return false
        }
        
        sqlite3_bind_text(selectStatement, 1, (nickName as NSString).utf8String, -1, nil)
    
        if sqlite3_step(selectStatement) != SQLITE_ROW {
            sqlite3_finalize(selectStatement)
            return false
        }
        
        let nickNameVindoDoBanco = String(describing: String(cString: sqlite3_column_text(selectStatement, 0)))
        
        sqlite3_finalize(selectStatement)
        
        if nickNameVindoDoBanco != nickName {
            return false
        }
        
        return true
    }
    
    func verificaSeEmailJaEstaCadastrado(_ email: String) -> Bool {
        let selectStatementString = "SELECT email FROM usuarios WHERE email = ?;"
        var selectStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, selectStatementString, -1, &selectStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em VerificadorDeDadosCadastradosSQLite!")
            return false
        }
        
        sqlite3_bind_text(selectStatement, 1, (email as NSString).utf8String, -1, nil)
    
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
