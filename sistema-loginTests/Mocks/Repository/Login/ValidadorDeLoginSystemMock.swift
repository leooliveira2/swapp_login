//
//  ValidadorDeLoginStaticClassMock.swift
//  sistema-login
//
//  Created by Leonardo Leite on 16/12/22.
//

import UIKit

class ValidadorDeLoginSystemMock: ValidadorDeLoginRepository {
    
    var retornoDaFuncaoValidarLogin: Bool!
    
    func validarLogin(email: String, senha: String) -> Bool {
        return retornoDaFuncaoValidarLogin
    }
    
}
