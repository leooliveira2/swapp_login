//
//  SalvarUsuarioStaticClassMock.swift
//  sistema-login
//
//  Created by Leonardo Leite on 14/12/22.
//

import UIKit

class SalvarUsuarioSystemMock: SalvarUsuarioRepository {
    
    var retornoDaFuncaoSalvar: Bool!
    
    func salvar(_ usuario: Usuario) -> Bool {
        return retornoDaFuncaoSalvar
    }
    
}
