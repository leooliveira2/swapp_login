//
//  BuscadorDeNavesFavoritasMock.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 05/01/23.
//

import UIKit
@testable import sistema_login

class BuscadorDeNavesFavoritasMock: BuscadorDeNavesFavoritasRepository {
    
    var retornoDaFuncaoBuscar: [Nave]?
    
    func buscarTodasAsNaves(idUsuario: Int) -> [sistema_login.Nave]? {
        return retornoDaFuncaoBuscar
    }
    
}
