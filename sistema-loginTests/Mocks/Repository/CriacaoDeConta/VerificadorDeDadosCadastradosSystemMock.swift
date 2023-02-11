//
//  VerificadorDeDadosCadastradosStaticClassMock.swift
//  sistema-login
//
//  Created by Leonardo Leite on 16/12/22.
//

import UIKit

class VerificadorDeDadosCadastradosSystemMock: VerificadorDeDadosCadastradosRepository {
    
    var retornoDaFuncaoVerificaSeNickNameJaEstaCadastrado: Bool!
    var retornoDaFuncaoVerificaSeEmailJaEstaCadastrado: Bool!
    
    func verificaSeNickNameJaEstaCadastrado(_ nickName: String) -> Bool {
        return retornoDaFuncaoVerificaSeNickNameJaEstaCadastrado
    }
    
    func verificaSeEmailJaEstaCadastrado(_ email: String) -> Bool {
        return retornoDaFuncaoVerificaSeEmailJaEstaCadastrado
    }

}
