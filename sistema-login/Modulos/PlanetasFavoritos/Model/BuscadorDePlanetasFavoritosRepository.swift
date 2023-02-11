//
//  BuscadorDePlanetasFavoritosRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 29/12/22.
//

import UIKit

protocol BuscadorDePlanetasFavoritosRepository {
    func buscarTodosOsPlanetas(idUsuario: Int) -> [Planeta]?
}

import SQLite3

class BuscadorDePlanetasFavoritosSQLite: BuscadorDePlanetasFavoritosRepository {
    
    // MARK: - Atributos
    let instanciaDoBanco: OpaquePointer
    
    // MARK: - Inicializadores
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    // MARK: - Funcoes
    public func buscarTodosOsPlanetas(idUsuario: Int) -> [Planeta]? {
        let queryStatementString = "SELECT nome, diametro, clima, gravidade, terreno, populacao FROM planetas_favoritos WHERE id_usuario = ?;"
        var queryStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(
            self.instanciaDoBanco,
            queryStatementString, -1,
            &queryStatement,
            nil
        ) != SQLITE_OK {
            print("Erro ao ler dados do banco em BuscadorDePlanetasFavoritosSQLite!")
            return nil
        }
        
        sqlite3_bind_int(queryStatement, 1, Int32(idUsuario))
        
        var planetas: [Planeta] = []
        
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            let nome = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
            let diametro = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
            let clima = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
            let gravidade = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
            let terreno = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
            let populacao = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
            
            let planeta = Planeta()
            planeta.setNome(nome)
            planeta.setDiametro(diametro)
            planeta.setClima(clima)
            planeta.setGravidade(gravidade)
            planeta.setTerreno(terreno)
            planeta.setPopulacao(populacao)
            
            planetas.append(planeta)
        }
        
        sqlite3_finalize(queryStatement)
        return planetas
    }
    
}
