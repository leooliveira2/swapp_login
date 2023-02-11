//
//  RemovePlanetaDosFavoritosMock.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 05/01/23.
//

import UIKit
@testable import sistema_login

class RemovePlanetaDosFavoritosMock: RemovePlanetaDosFavoritosRepository {
    
    var retornoDaFuncaoRemover: Bool!
    
    func remover(planeta: Planeta, idDoUsuario: Int) -> Bool {
        return retornoDaFuncaoRemover
    }

}
