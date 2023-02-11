//
//  BuscadorDePersonagensFavoritosRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 29/12/22.
//

import UIKit

protocol BuscadorDePersonagensFavoritosRepository {
    func buscarTodosOsPersonagens(idUsuario: Int) -> [Personagem]?
}

import SQLite3

class BuscadorDePersonagensFavoritosSQLite: BuscadorDePersonagensFavoritosRepository {
    
    // MARK: - Atributos
    let instanciaDoBanco: OpaquePointer
    
    // MARK: - Inicializadores
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    // MARK: - Funcoes
    public func buscarTodosOsPersonagens(idUsuario: Int) -> [Personagem]? {
        let queryStatementString = "SELECT nome, altura, peso, corDosOlhos, anoNascimento, genero FROM personagens_favoritos WHERE id_usuario = ?;"
        var queryStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(
            self.instanciaDoBanco,
            queryStatementString, -1,
            &queryStatement,
            nil
        ) != SQLITE_OK {
            print("Erro ao ler dados do banco em BuscadorDePersonagensFavoritosSQLite!")
            return nil
        }
        
        sqlite3_bind_int(queryStatement, 1, Int32(idUsuario))
        
        var personagens: [Personagem] = []
        
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            let nome = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
            let altura = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
            let peso = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
            let corDosOlhos = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
            let anoNascimento = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
            let genero = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
            
            let personagem = Personagem()
            personagem.setNome(nome)
            personagem.setAltura(altura)
            personagem.setPeso(peso)
            personagem.setCorDosOlhos(corDosOlhos)
            personagem.setAnoNascimento(anoNascimento)
            personagem.setGenero(genero)
            
            personagens.append(personagem)
        }
        
        sqlite3_finalize(queryStatement)
        return personagens
    }
    
}
