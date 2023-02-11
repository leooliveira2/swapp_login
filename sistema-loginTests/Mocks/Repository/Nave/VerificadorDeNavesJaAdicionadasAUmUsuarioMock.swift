//
//  VerificadorDeNavesJaAdicionadasAUmUsuarioMock.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 05/01/23.
//

import UIKit
@testable import sistema_login

class VerificadorDeNavesJaAdicionadasAUmUsuarioMock: VerificadorDeNavesJaAdicionadasAUmUsuarioRepository
{
    var retornoDaFuncaoVerifica: Bool!
    
    func verificaSeNaveJaEstaFavoritadaPeloUsuario(nave: sistema_login.Nave, idDoUsuario: Int) -> Bool {
        
        return retornoDaFuncaoVerifica
    }
    
}
