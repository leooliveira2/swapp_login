//
//  RedefinicaoDeSenhaStaticClassMock.swift
//  sistema-login
//
//  Created by Leonardo Leite on 14/12/22.
//

import UIKit

class RedefinicaoDeSenhaSystemMock: RedefinicaoDeSenhaRepository {
    
    var retornoDaFuncaoRedefinirSenha: Bool!
    
    func redefinirSenha(email: String, senha: String) -> Bool {
        return self.retornoDaFuncaoRedefinirSenha
    }
    
}
