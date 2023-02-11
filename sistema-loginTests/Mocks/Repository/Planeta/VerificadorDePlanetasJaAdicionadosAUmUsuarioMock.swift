//
//  VerificadorDePlanetasJaAdicionadosAUmUsuarioMock.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 05/01/23.
//

import UIKit
@testable import sistema_login

class VerificadorDePlanetasJaAdicionadosAUmUsuarioMock: VerificadorDePlanetasJaAdicionadosAUmUsuarioRepository {

    var retornoDaFuncaoVerifica: Bool!

    func verificaSePlanetaJaEstaFavoritadoPeloUsuario(planeta: Planeta, idDoUsuario: Int) -> Bool {
        return retornoDaFuncaoVerifica

    }
    
}
