//
//  BuscadorDePersonagensFavoritosMock.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 05/01/23.
//

import UIKit
@testable import sistema_login

class BuscadorDePersonagensFavoritosMock: BuscadorDePersonagensFavoritosRepository {
    
    var retornoDaFuncaoBuscar: [Personagem]?
    
    func buscarTodosOsPersonagens(idUsuario: Int) -> [sistema_login.Personagem]? {
        return retornoDaFuncaoBuscar
    }
    
}
