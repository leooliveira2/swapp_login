//
//  BuscadorDePlanetasFavoritosMock.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 05/01/23.
//

import UIKit
@testable import sistema_login

class BuscadorDePlanetasFavoritosMock: BuscadorDePlanetasFavoritosRepository {
    
    var retornoDaFuncaoBuscar: [Planeta]?
    
    func buscarTodosOsPlanetas(idUsuario: Int) -> [sistema_login.Planeta]? {
        return retornoDaFuncaoBuscar
    }

}
