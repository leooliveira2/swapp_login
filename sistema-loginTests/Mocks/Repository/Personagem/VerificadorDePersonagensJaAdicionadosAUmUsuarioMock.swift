//
//  VerificadorDePersonagensJaAdicionadosAUmUsuarioMock.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 04/01/23.
//

import UIKit
@testable import sistema_login

class VerificadorDePersonagensJaAdicionadosAUmUsuarioMock: VerificadorDePersonagensJaAdicionadosAUmUsuarioRepository
{
    
    var retornoDaFuncaoVerifica: Bool!
    
    func verificaSePersonagemJaEstaFavoritadoPeloUsuario(personagem: Personagem, idDoUsuario: Int) -> Bool {
        return retornoDaFuncaoVerifica
    }
    
}
