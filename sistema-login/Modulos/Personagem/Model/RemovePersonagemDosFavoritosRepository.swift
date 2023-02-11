//
//  RemovePersonagemDosFavoritosRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 27/12/22.
//

import UIKit

protocol RemovePersonagemDosFavoritosRepository {

    func remover(personagem: Personagem, idDoUsuario: Int) -> Bool
}

import SQLite3

class RemovePersonagemDosFavoritosSQLite: RemovePersonagemDosFavoritosRepository {
    
    private let instanciaDoBanco: OpaquePointer
    
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }

    func remover(personagem: Personagem, idDoUsuario: Int) -> Bool {
        let deleteStatementString = "DELETE FROM personagens_favoritos WHERE id_usuario = ? AND nome = ?;"
        var deleteStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, deleteStatementString, -1, &deleteStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em RemovePersonagemDosFavoritosSQLite!")
            return false
        }
        
        sqlite3_bind_int(deleteStatement, 1, Int32(idDoUsuario))
        sqlite3_bind_text(deleteStatement, 2, (personagem.getNomePersonagem() as NSString).utf8String, -1, nil)
    
        if sqlite3_step(deleteStatement) != SQLITE_DONE {
            print("Erro ao deletar personagem em RemovePersonagemDosFavoritosSQLite!")
            sqlite3_finalize(deleteStatement)
            return false
        }
        
        print("Personagem \(personagem.getNomePersonagem()) removido dos favoritos")
        sqlite3_finalize(deleteStatement)
        return true
        
    }
    
}
