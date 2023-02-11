//
//  SalvarNaveFavoritaRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 28/12/22.
//

import UIKit

protocol SalvarNaveFavoritaRepository {

    func salvarComoFavorito(_ nave: Nave, idUsuario: Int) -> Bool
}

import SQLite3

class SalvarNaveFavoritaSQLite: SalvarNaveFavoritaRepository {
    
    // MARK: - Atributos
    let instanciaDoBanco: OpaquePointer
    
    // MARK: - Inicializadores
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    // MARK: - Funcoes
    public func salvarComoFavorito(_ nave: Nave, idUsuario: Int) -> Bool {
        let insertStatementString = "INSERT INTO naves_favoritas(nome, modelo, fabricante, custoEmCreditos, comprimento, passageiros, id_usuario) VALUES (?, ?, ?, ?, ?, ?, ?);"
        
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, insertStatementString, -1, &insertStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em SalvarNaveFavoritaSQLite!")
            return false
        }
        
        sqlite3_bind_text(insertStatement, 1, (nave.getNome() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 2, (nave.getModelo() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 3, (nave.getFabricante() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 4, (nave.getCustoEmCreditos() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 5, (nave.getComprimento() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 6, (nave.getPassageiros() as NSString).utf8String, -1, nil)
        sqlite3_bind_int(insertStatement, 7, Int32(idUsuario))
        
        if sqlite3_step(insertStatement) != SQLITE_DONE {
            print("Erro ao fazer insercao em SalvarNaveFavoritaSQLite!")
            sqlite3_finalize(insertStatement)
            return false
        }
        
        sqlite3_finalize(insertStatement)
        return true
    }
    
}

