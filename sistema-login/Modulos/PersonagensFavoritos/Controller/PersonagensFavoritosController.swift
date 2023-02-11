//
//  PersonagensFavoritosController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 29/12/22.
//

import UIKit

class PersonagensFavoritosController {
    
    let instanciaDoBanco: OpaquePointer
    
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    public func buscaTodosOsPersonagensFavoritosDoUsuario(
        nickNameUsuario: String,
        buscadorDePersonagensFavoritos: BuscadorDePersonagensFavoritosRepository,
        buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository
    ) -> [Personagem]?
    {
        guard let idUsuario = buscadorDeDadosDoUsuario.getIdDoUsuario(
            nickName: nickNameUsuario
        ) else {
            return nil
        }
        
        guard let listaDePersonagensFavoritos = buscadorDePersonagensFavoritos.buscarTodosOsPersonagens(idUsuario: idUsuario) else { return nil }
        
        return listaDePersonagensFavoritos
    }
    
    public func removePersonagemDosFavoritosDoUsuario(
        personagem: Personagem,
        nickNameDoUsuario: String,
        buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository,
        removePersonagemFavorito: RemovePersonagemDosFavoritosRepository
    ) -> Bool {
        guard let idDoUsuario = buscadorDeDadosDoUsuario.getIdDoUsuario(nickName: nickNameDoUsuario) else { return false }
        
        let personagemFoiRemovido = removePersonagemFavorito.remover(personagem: personagem, idDoUsuario: idDoUsuario)
        
        return personagemFoiRemovido
        
    }
}
