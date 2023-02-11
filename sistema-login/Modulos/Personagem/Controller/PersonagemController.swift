//
//  PersonagemController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 25/11/22.
//

import UIKit

class PersonagemController {
    
    public func gerarPersonagem(
        requisicoesSWAPI: RequisicoesStarWarsAPIProtocol,
        sucesso: @escaping(_ personagem: Personagem) -> Void,
        fracasso: @escaping() -> Void
    ) -> Void
    {
        requisicoesSWAPI.fazRequisicaoPersonagem(id: gerarIdAleatorio()) { personagem in
            guard let personagemVindoDaRequisicao = personagem else { fracasso(); return }
            
            sucesso(personagemVindoDaRequisicao)
            return
        }
    }
    
    private func gerarIdAleatorio() -> Int {
        let numero = Int(arc4random_uniform(83))
        return numero
    }
    
    public func adicionarPersonagemAosFavoritos(
        _ personagem: Personagem,
        adicionaAosFavoritos: SalvarPersonagemFavoritoRepository,
        buscaDadosDoUsuario: RecuperaDadosDoUsuarioRepository,
        nickNameDoUsuario: String
    ) -> Bool
    {
        guard let idUsuario = buscaDadosDoUsuario.getIdDoUsuario(nickName: nickNameDoUsuario) else { return false }
        
        let personagemFoiSalvo = adicionaAosFavoritos.salvarComoFavorito(personagem, idUsuario: idUsuario)
        
        return personagemFoiSalvo
    }
    
    public func verificaSePersonagemJaEstaFavoritado(
        personagem: Personagem,
        nickName: String,
        verificadorDePersonagensSalvosPorUsuario: VerificadorDePersonagensJaAdicionadosAUmUsuarioRepository,
        buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository
    ) -> Bool {
        guard let idDoUsuario = buscadorDeDadosDoUsuario.getIdDoUsuario(nickName: nickName) else { return false }
        
        let personagemJaEstaFavoritado = verificadorDePersonagensSalvosPorUsuario.verificaSePersonagemJaEstaFavoritadoPeloUsuario(
            personagem: personagem,
            idDoUsuario: idDoUsuario
        )
        
        return personagemJaEstaFavoritado
    }
    
    public func removerPersonagemDosFavoritos(
        personagem: Personagem,
        nickNameDoUsuario: String,
        buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository,
        removePersonagemDosFavoritos: RemovePersonagemDosFavoritosRepository
    ) -> Bool {
        guard let idDoUsuario = buscadorDeDadosDoUsuario.getIdDoUsuario(nickName: nickNameDoUsuario) else { return false }
        
        let personagemFoiRemovido = removePersonagemDosFavoritos.remover(
            personagem: personagem,
            idDoUsuario: idDoUsuario
        )
            
        return personagemFoiRemovido
    }
}
