//
//  RecuperaDadosDoUsuarioRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 12/12/22.
//

import UIKit

protocol RecuperaDadosDoUsuarioRepository {
    
    func getNickNameDoUsuario(email: String) -> String?
    func getIdDoUsuario(nickName: String) -> Int?
    
}

class RecuperaDadosDoUsuarioSystem: RecuperaDadosDoUsuarioRepository {
    private let usuariosArmazenamento: UsuariosDadosStatic
    
    init(usuariosArmazenamento: UsuariosDadosStatic? = nil) {
        self.usuariosArmazenamento = usuariosArmazenamento ?? UsuariosDadosStatic().getInstance()
    }
    
    public func getNickNameDoUsuario(email: String) -> String? {
        let listaDeUsuarios = usuariosArmazenamento.getUsuariosSalvos()
        
        for usuario in listaDeUsuarios {
            if usuario.getEmailDoUsuario() == email {
                return usuario.getNickNameDeUsuario()
            }
        }
        
        return nil
    }
    
    func getIdDoUsuario(nickName: String) -> Int? {
        return nil
    }
    
}

import SQLite3

class RecuperaDadosDoUsuarioSQLite: RecuperaDadosDoUsuarioRepository {
    
    // MARK: - Atributos
    let instanciaDoBanco: OpaquePointer
    
    // MARK: - Inicializador
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    // MARK: - Funcoes
    func getNickNameDoUsuario(email: String) -> String? {
        let selectStatementString = "SELECT nickName FROM usuarios WHERE email = ?;"
        var selectStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, selectStatementString, -1, &selectStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em RecuperaDadosDoUsuarioSQLite!")
            return nil
        }
        
        sqlite3_bind_text(selectStatement, 1, (email as NSString).utf8String, -1, nil)
    
        if sqlite3_step(selectStatement) != SQLITE_ROW {
            print("Erro ao ler os dados em VerificadorDeDadosCadastradosSQLite!")
            sqlite3_finalize(selectStatement)
            return nil
        }
        
        let nickNameVindoDoBanco = String(describing: String(cString: sqlite3_column_text(selectStatement, 0)))
        
        sqlite3_finalize(selectStatement)
        return nickNameVindoDoBanco
        
        
    }
    
    func getIdDoUsuario(nickName: String) -> Int? {
        let selectStatementString = "SELECT id FROM usuarios WHERE nickName = ?;"
        var selectStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, selectStatementString, -1, &selectStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em RecuperaDadosDoUsuarioSQLite!")
            return nil
        }
        
        sqlite3_bind_text(selectStatement, 1, (nickName as NSString).utf8String, -1, nil)
    
        if sqlite3_step(selectStatement) != SQLITE_ROW {
            sqlite3_finalize(selectStatement)
            return nil
        }
        
        let idVindoDoBanco = sqlite3_column_int(selectStatement, 0)
        
        sqlite3_finalize(selectStatement)
        return Int(idVindoDoBanco)
    }
    
}

