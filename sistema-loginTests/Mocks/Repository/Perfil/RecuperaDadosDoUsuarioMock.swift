//
//  RecuperaDadosDoUsuarioMock.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 04/01/23.
//

import UIKit

class RecuperaDadosDoUsuarioMock: RecuperaDadosDoUsuarioRepository {
    
    var retornoDaFuncaoGetNickNameDoUsuario: String!
    var retornoDaFuncaoGetIdDoUsuario: Int!
    
    func getNickNameDoUsuario(email: String) -> String? {
        return retornoDaFuncaoGetNickNameDoUsuario
    }
    
    func getIdDoUsuario(nickName: String) -> Int? {
        return retornoDaFuncaoGetIdDoUsuario
    }
    
}
