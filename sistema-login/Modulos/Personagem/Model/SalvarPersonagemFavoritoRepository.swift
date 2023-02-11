//
//  SalvarPersonagemFavoritoRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 26/12/22.
//

import UIKit

protocol SalvarPersonagemFavoritoRepository {

    func salvarComoFavorito(_ personagem: Personagem, idUsuario: Int) -> Bool
}

import SQLite3

class SalvarPersonagemFavoritoSQLite: SalvarPersonagemFavoritoRepository {
    
    // MARK: - Atributos
    let instanciaDoBanco: OpaquePointer
    
    // MARK: - Inicializadores
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    // MARK: - Funcoes
    public func salvarComoFavorito(_ personagem: Personagem, idUsuario: Int) -> Bool {
        let insertStatementString = "INSERT INTO personagens_favoritos(nome, altura, peso, corDosOlhos, anoNascimento, genero, id_usuario) VALUES (?, ?, ?, ?, ?, ?, ?);"
        
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, insertStatementString, -1, &insertStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em SalvarPersonagemFavoritoSQLite!")
            return false
        }
        
        sqlite3_bind_text(insertStatement, 1, (personagem.getNomePersonagem() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 2, (personagem.getAlturaPersonagem() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 3, (personagem.getPesoPersonagem() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 4, (personagem.getCorDosOlhosPersonagem() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 5, (personagem.getAnoNascimentoPersonagem() as NSString).utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 6, (personagem.getGeneroPersonagem() as NSString).utf8String, -1, nil)
        sqlite3_bind_int(insertStatement, 7, Int32(idUsuario))
        
        if sqlite3_step(insertStatement) != SQLITE_DONE {
            print("Erro ao fazer insercao em SalvarPersonagemFavoritoSQLite!")
            sqlite3_finalize(insertStatement)
            return false
        }
        
        sqlite3_finalize(insertStatement)
        return true
    }
    
}

