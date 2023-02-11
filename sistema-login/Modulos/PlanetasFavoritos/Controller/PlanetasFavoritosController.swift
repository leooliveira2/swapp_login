//
//  PlanetasFavoritosController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 29/12/22.
//

import UIKit

class PlanetasFavoritosController {

    let instanciaDoBanco: OpaquePointer
    
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    public func buscaTodosOsPlanetasFavoritosDoUsuario(
        nickNameUsuario: String,
        buscadorDePlanetasFavoritos: BuscadorDePlanetasFavoritosRepository,
        buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository
    ) -> [Planeta]?
    {
        guard let idUsuario = buscadorDeDadosDoUsuario.getIdDoUsuario(
            nickName: nickNameUsuario
        ) else {
            return nil
        }
        
        guard let listaDePlanetasFavoritos = buscadorDePlanetasFavoritos.buscarTodosOsPlanetas(
            idUsuario: idUsuario) else { return nil }
        
        return listaDePlanetasFavoritos
    }
    
    public func removePlanetaDosFavoritosDoUsuario(
        planeta: Planeta,
        nickNameDoUsuario: String,
        buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository,
        removePlanetaFavorito: RemovePlanetaDosFavoritosRepository
    ) -> Bool {
        guard let idDoUsuario = buscadorDeDadosDoUsuario.getIdDoUsuario(nickName: nickNameDoUsuario) else { return false }
        
        let planetaFoiRemovido = removePlanetaFavorito.remover(planeta: planeta, idDoUsuario: idDoUsuario)
        
        return planetaFoiRemovido
        
    }

}
