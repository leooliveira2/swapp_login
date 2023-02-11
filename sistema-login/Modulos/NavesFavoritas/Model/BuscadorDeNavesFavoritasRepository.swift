//
//  BuscadorDeNavesFavoritasRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 29/12/22.
//

import UIKit

protocol BuscadorDeNavesFavoritasRepository {
    func buscarTodasAsNaves(idUsuario: Int) -> [Nave]?
}

import SQLite3

class BuscadorDeNavesFavoritasSQLite: BuscadorDeNavesFavoritasRepository {
    
    // MARK: - Atributos
    let instanciaDoBanco: OpaquePointer
    
    // MARK: - Inicializadores
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    // MARK: - Funcoes
    public func buscarTodasAsNaves(idUsuario: Int) -> [Nave]? {
        let queryStatementString = "SELECT nome, modelo, fabricante, custoEmCreditos, comprimento, passageiros FROM naves_favoritas WHERE id_usuario = ?;"
        var queryStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(
            self.instanciaDoBanco,
            queryStatementString, -1,
            &queryStatement,
            nil
        ) != SQLITE_OK {
            print("Erro ao ler dados do banco em BuscadorDeNavesFavoritasSQLite!")
            return nil
        }
        
        sqlite3_bind_int(queryStatement, 1, Int32(idUsuario))
        
        var naves: [Nave] = []
        
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            let nome = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
            let modelo = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
            let fabricante = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
            let custoEmCreditos = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
            let comprimento = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
            let passageiros = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
            
            let nave = Nave()
            nave.setNome(nome)
            nave.setModelo(modelo)
            nave.setFabricante(fabricante)
            nave.setCustoEmCreditos(custoEmCreditos)
            nave.setComprimento(comprimento)
            nave.setPassageiros(passageiros)
            
            naves.append(nave)
        }
        
        sqlite3_finalize(queryStatement)
        return naves
    }
    
}
