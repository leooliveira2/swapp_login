//
//  DBManager.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/12/22.
//

import UIKit
import SQLite3

class DBManager {
    
    public func openDatabase(DBPath: String) -> OpaquePointer? {

        let filePath = try! FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).appendingPathComponent(DBPath)
        
        var db: OpaquePointer?
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("Não foi possível abrir o banco de dados")
            return nil
        }
        
        print("Banco de dados foi acessado com sucesso!")
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, "PRAGMA foreign_keys = ON;", -1, &statement, nil) != SQLITE_OK {
            print("erro ao preparar chave estrangeira para uso!")
        }
        
        sqlite3_finalize(statement)
        
        return db
    }
    
    public func createTable(criarTabelaString: String, instanciaDoBanco: OpaquePointer) -> Bool {
        var createTableStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(instanciaDoBanco, criarTabelaString, -1, &createTableStatement, nil) != SQLITE_OK {
            print("ERRO NA PREPARACAO DO BANCO")
            return false
        }
        
        if sqlite3_step(createTableStatement) != SQLITE_DONE {
            print("Erro na criacao da tabela")
            sqlite3_finalize(createTableStatement)
            return false
        }
        
        print("Sucesso na criacao da tabela!")
        sqlite3_finalize(createTableStatement)
        return true
    }
    
}

