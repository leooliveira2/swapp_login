//
//  RemoveNaveDosFavoritosMock.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 05/01/23.
//

import UIKit
@testable import sistema_login

class RemoveNaveDosFavoritosMock: RemoveNaveDosFavoritosRepository {
    
    var retornoDaFuncaoRemover: Bool!
    
    func remover(nave: sistema_login.Nave, idDoUsuario: Int) -> Bool {
        return retornoDaFuncaoRemover
    }
    
}
