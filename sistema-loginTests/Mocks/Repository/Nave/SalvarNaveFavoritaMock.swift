//
//  SalvarNaveFavoritaMock.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 05/01/23.
//

import UIKit
@testable import sistema_login

class SalvarNaveFavoritaMock: SalvarNaveFavoritaRepository {
    
    var retornoDaFuncaoSalvarComoFavorito: Bool!
    
    func salvarComoFavorito(_ nave: Nave, idUsuario: Int) -> Bool {
        return retornoDaFuncaoSalvarComoFavorito
    }
    
}
