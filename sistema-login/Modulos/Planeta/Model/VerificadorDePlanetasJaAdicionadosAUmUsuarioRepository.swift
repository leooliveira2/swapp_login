//
//  VerificadorDePlanetasJaAdicionadosAUmUsuarioRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 28/12/22.
//

import UIKit

protocol VerificadorDePlanetasJaAdicionadosAUmUsuarioRepository {

    func verificaSePlanetaJaEstaFavoritadoPeloUsuario(
        planeta: Planeta,
        idDoUsuario: Int
    ) -> Bool
    
}

import SQLite3

class VerificadorDePlanetasJaAdicionadosAUmUsuarioSQLite: VerificadorDePlanetasJaAdicionadosAUmUsuarioRepository {
    
    private let instanciaDoBanco: OpaquePointer
    
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    public func verificaSePlanetaJaEstaFavoritadoPeloUsuario(
        planeta: Planeta,
        idDoUsuario: Int
    ) -> Bool
    {
        let selectStatementString = "SELECT nome FROM planetas_favoritos WHERE id_usuario = ? AND nome = ?;"
        var selectStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, selectStatementString, -1, &selectStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em VerificadorDePlanetasJaAdicionadosAUmUsuarioSQLite!")
            return false
        }
        
        sqlite3_bind_int(selectStatement, 1, Int32(idDoUsuario))
        sqlite3_bind_text(selectStatement, 2, (planeta.getNome() as NSString).utf8String, -1, nil)
    
        if sqlite3_step(selectStatement) != SQLITE_ROW {
            sqlite3_finalize(selectStatement)
            return false
        }
        
        let nomePlanetaVindoDoBanco = String(describing: String(cString: sqlite3_column_text(selectStatement, 0)))
        
        sqlite3_finalize(selectStatement)
        
        if nomePlanetaVindoDoBanco != planeta.getNome() {
            return false
        }
        
        return true
    }
}
