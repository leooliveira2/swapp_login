//
//  SalvarPersonagemFavoritoMock.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 04/01/23.
//

import UIKit
@testable import sistema_login

class SalvarPersonagemFavoritoMock: SalvarPersonagemFavoritoRepository {
    
    var retornoDaFuncaoSalvarComoFavorito: Bool!
    
    func salvarComoFavorito(_ personagem: Personagem, idUsuario: Int) -> Bool {
        return retornoDaFuncaoSalvarComoFavorito
    }
    

}
