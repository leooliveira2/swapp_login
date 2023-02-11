//
//  UsuarioDao.swift
//  sistema-login
//
//  Created by Leonardo Leite on 10/11/22.
//

import UIKit

// Monostate

class UsuariosDadosStatic {
    
    private static let instance = UsuariosDadosStatic()
    private var usuariosSalvos: [Usuario] = []
    
    public func getInstance() -> UsuariosDadosStatic {
        return .instance
    }

    public func salvarUsuario(_ usuario: Usuario) -> Void {
        self.usuariosSalvos.append(usuario)
    }

    public func getUsuariosSalvos() -> [Usuario] {
        self.usuariosSalvos
    }
    
}
