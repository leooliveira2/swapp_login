//
//  RemovePersonagemDosFavoritosMock.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 04/01/23.
//

import UIKit
@testable import sistema_login

class RemovePersonagemDosFavoritosMock: RemovePersonagemDosFavoritosRepository {

    var retornoDaFuncaoRemover: Bool!
    
    func remover(personagem: sistema_login.Personagem, idDoUsuario: Int) -> Bool {
        return retornoDaFuncaoRemover
    }
}
