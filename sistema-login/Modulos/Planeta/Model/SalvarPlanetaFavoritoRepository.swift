//
//  SalvarPlanetaFavoritoRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 28/12/22.
//


import UIKit

protocol SalvarPlanetaFavoritoRepository {

    func salvarComoFavorito(_ planeta: Planeta, idUsuario: Int) -> Bool
}

import SQLite3

class SalvarPlanetaFavoritoSQLite: SalvarPlanetaFavoritoRepository {
    
    // MARK: - Atributos
    let instanciaDoBanco: OpaquePointer
    
    // MARK: - Inicializadores
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    // MARK: - Funcoes
    public func salvarComoFavorito(_ planeta: Planeta, idUsuario: Int) -> Bool {
        let insertStatementString = "INSERT INTO planetas_favoritos(nome, diametro, clima, gravidade, terreno, populacao, id_usuario) VALUES (?, ?, ?, ?, ?, ?, ?);"
        
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, insertStatementString, -1, &insertStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em SalvarPlanetaFavoritoSQLite!")
            return false
        }
        
        sqlite3_bind_text(insertStatement, 1, (planeta.getNome() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 2, (planeta.getDiametro() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 3, (planeta.getClima() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 4, (planeta.getGravidade() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 5, (planeta.getTerreno() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 6, (planeta.getPopulacao() as NSString).utf8String, -1, nil)
        sqlite3_bind_int(insertStatement, 7, Int32(idUsuario))
        
        if sqlite3_step(insertStatement) != SQLITE_DONE {
            print("Erro ao fazer insercao em SalvarPlanetaFavoritoSQLite!")
            sqlite3_finalize(insertStatement)
            return false
        }
        
        sqlite3_finalize(insertStatement)
        return true
    }
    
}

