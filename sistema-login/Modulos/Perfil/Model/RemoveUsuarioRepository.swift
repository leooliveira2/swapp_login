//
//  RemoveUsuarioRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 06/01/23.
//

import UIKit

protocol RemoveUsuarioRepository {
    func remover(idUsuario: Int) -> Bool
}

import SQLite3

class RemoveUsuarioSQLite: RemoveUsuarioRepository {
    
    // MARK: - Atributos
    let instanciaDoBanco: OpaquePointer
    
    // MARK: - Inicializador
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    // MARK: - Funcoes
    func remover(idUsuario: Int) -> Bool {
        let deleteStatementString = "DELETE FROM usuarios WHERE id = ?;"
        var deleteStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(instanciaDoBanco, deleteStatementString, -1, &deleteStatement, nil) != SQLITE_OK {
            print("Erro ao fazer prepare em RemoveUsuarioSQLite!")
            return false
        }
        
        sqlite3_bind_int(deleteStatement, 1, Int32(idUsuario))
        
        if sqlite3_step(deleteStatement) != SQLITE_DONE {
            print("Não foi possivel deletar a pessoa de id \(idUsuario)")
            sqlite3_finalize(deleteStatement)
            return false
        }
        
        print("Sucesso ao deletar pessoa com id \(idUsuario)")
        sqlite3_finalize(deleteStatement)
        return true
    }

}
