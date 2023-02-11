//
//  NavesFavoritasController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 29/12/22.
//

import UIKit

class NavesFavoritasController {
    
    let instanciaDoBanco: OpaquePointer
    
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    public func buscaTodasAsNavesFavoritasDoUsuario(
        nickNameUsuario: String,
        buscadorDeNavesFavoritas: BuscadorDeNavesFavoritasRepository,
        buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository
    ) -> [Nave]?
    {
        guard let idUsuario = buscadorDeDadosDoUsuario.getIdDoUsuario(
            nickName: nickNameUsuario
        ) else {
            return nil
        }
        
        guard let listaDeNavesFavoritas = buscadorDeNavesFavoritas.buscarTodasAsNaves(
            idUsuario: idUsuario) else { return nil }
        
        return listaDeNavesFavoritas
    }
    
    public func removeNaveDosFavoritosDoUsuario(
        nave: Nave,
        nickNameDoUsuario: String,
        buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository,
        removeNaveFavorita: RemoveNaveDosFavoritosRepository
    ) -> Bool {
        guard let idDoUsuario = buscadorDeDadosDoUsuario.getIdDoUsuario(nickName: nickNameDoUsuario) else { return false }
        
        let naveFoiRemovida = removeNaveFavorita.remover(nave: nave, idDoUsuario: idDoUsuario)
        
        return naveFoiRemovida
        
    }
    
}
