//
//  SalvaPlanetaFavoritoMock.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 05/01/23.
//

import UIKit
@testable import sistema_login

class SalvarPlanetaFavoritoMock: SalvarPlanetaFavoritoRepository {
    
    var retornoDaFuncaoSalvarComoFavorito: Bool!
    
    func salvarComoFavorito(_ planeta: Planeta, idUsuario: Int) -> Bool {
        return retornoDaFuncaoSalvarComoFavorito
    }
    
}
