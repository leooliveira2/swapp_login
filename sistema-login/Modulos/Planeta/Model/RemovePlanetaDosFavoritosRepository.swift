//
//  RemovePlanetaDosFavoritosRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 28/12/22.
//


import UIKit

protocol RemovePlanetaDosFavoritosRepository {

    func remover(planeta: Planeta, idDoUsuario: Int) -> Bool
}

import SQLite3

class RemovePlanetaDosFavoritosSQLite: RemovePlanetaDosFavoritosRepository {
    
    private let instanciaDoBanco: OpaquePointer
    
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }

    func remover(planeta: Planeta, idDoUsuario: Int) -> Bool {
        let deleteStatementString = "DELETE FROM planetas_favoritos WHERE id_usuario = ? AND nome = ?;"
        var deleteStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, deleteStatementString, -1, &deleteStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em RemovePlanetaDosFavoritosSQLite!")
            return false
        }
        
        sqlite3_bind_int(deleteStatement, 1, Int32(idDoUsuario))
        sqlite3_bind_text(deleteStatement, 2, (planeta.getNome() as NSString).utf8String, -1, nil)
    
        if sqlite3_step(deleteStatement) != SQLITE_DONE {
            print("Erro ao deletar personagem em RemovePlanetaDosFavoritosSQLite!")
            sqlite3_finalize(deleteStatement)
            return false
        }
        
        print("Planeta \(planeta.getNome()) removido dos favoritos")
        sqlite3_finalize(deleteStatement)
        return true
        
    }
    
}
