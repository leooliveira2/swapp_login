//
//  VerificadorDeNavesJaAdicionadasAUmUsuarioRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 28/12/22.
//

import UIKit

protocol VerificadorDeNavesJaAdicionadasAUmUsuarioRepository {

    func verificaSeNaveJaEstaFavoritadaPeloUsuario(
        nave: Nave,
        idDoUsuario: Int
    ) -> Bool
    
}

import SQLite3

class VerificadorDeNavesJaAdicionadasAUmUsuarioSQLite: VerificadorDeNavesJaAdicionadasAUmUsuarioRepository {
    
    private let instanciaDoBanco: OpaquePointer
    
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    public func verificaSeNaveJaEstaFavoritadaPeloUsuario(
        nave: Nave,
        idDoUsuario: Int
    ) -> Bool
    {
        
        let selectStatementString = "SELECT nome FROM naves_favoritas WHERE id_usuario = ? AND nome = ?;"
        var selectStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, selectStatementString, -1, &selectStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em VerificadorDeNavesJaAdicionadasAUmUsuarioSQLite!")
            return false
        }
        
        sqlite3_bind_int(selectStatement, 1, Int32(idDoUsuario))
        sqlite3_bind_text(selectStatement, 2, (nave.getNome() as NSString).utf8String, -1, nil)
    
        if sqlite3_step(selectStatement) != SQLITE_ROW {
            sqlite3_finalize(selectStatement)
            return false
        }
        
        let nomeNaveVindoDoBanco = String(describing: String(cString: sqlite3_column_text(selectStatement, 0)))
        
        sqlite3_finalize(selectStatement)
        
        if nomeNaveVindoDoBanco != nave.getNome() {
            return false
        }
        
        return true
    }
}
