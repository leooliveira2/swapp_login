//
//  RemoveNaveDosFavoritosRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 28/12/22.
//

import UIKit

protocol RemoveNaveDosFavoritosRepository {

    func remover(nave: Nave, idDoUsuario: Int) -> Bool
}

import SQLite3

class RemoveNaveDosFavoritosSQLite: RemoveNaveDosFavoritosRepository {

    private let instanciaDoBanco: OpaquePointer
    
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }

    func remover(nave: Nave, idDoUsuario: Int) -> Bool {
        let deleteStatementString = "DELETE FROM naves_favoritas WHERE id_usuario = ? AND nome = ?;"
        var deleteStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, deleteStatementString, -1, &deleteStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em RemoveNaveDosFavoritosSQLite!")
            return false
        }
        
        sqlite3_bind_int(deleteStatement, 1, Int32(idDoUsuario))
        sqlite3_bind_text(deleteStatement, 2, (nave.getNome() as NSString).utf8String, -1, nil)
    
        if sqlite3_step(deleteStatement) != SQLITE_DONE {
            print("Erro ao deletar personagem em RemoveNaveDosFavoritosSQLite!")
            sqlite3_finalize(deleteStatement)
            return false
        }
        
        print("Nave \(nave.getNome()) removido dos favoritos")
        sqlite3_finalize(deleteStatement)
        return true
        
    }
    
}
