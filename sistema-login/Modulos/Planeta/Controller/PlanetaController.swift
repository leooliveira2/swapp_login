//
//  PlanetaController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 02/12/22.
//

import UIKit

class PlanetaController {
    
    public func gerarPlaneta(
        requisicoesSWAPI: RequisicoesStarWarsAPIProtocol,
        sucesso: @escaping(_ planeta: Planeta) -> Void,
        fracasso: @escaping() -> Void
    ) -> Void
    {
        requisicoesSWAPI.fazRequisicaoPlaneta(id: gerarIdAleatorio()) { planeta in
            guard let planetaVindoDaRequisicao = planeta else { fracasso(); return }
            
            sucesso(planetaVindoDaRequisicao)
            return
        }
    }
    
    private func gerarIdAleatorio() -> Int {
        let numero = Int(arc4random_uniform(60))
        return numero
    }
    
    public func adicionarPlanetaAosFavoritos(
        _ planeta: Planeta,
        adicionaAosFavoritos: SalvarPlanetaFavoritoRepository,
        buscaDadosDoUsuario: RecuperaDadosDoUsuarioRepository,
        nickNameDoUsuario: String
    ) -> Bool
    {
        guard let idUsuario = buscaDadosDoUsuario.getIdDoUsuario(nickName: nickNameDoUsuario) else { return false }
        
        let planetaFoiSalvo = adicionaAosFavoritos.salvarComoFavorito(planeta, idUsuario: idUsuario)
        
        return planetaFoiSalvo
    }
    
    public func verificaSePlanetaJaEstaFavoritado(
        planeta: Planeta,
        nickName: String,
        verificadorDePlanetasSalvosPorUsuario: VerificadorDePlanetasJaAdicionadosAUmUsuarioRepository,
        buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository
    ) -> Bool {
        
        guard let idDoUsuario = buscadorDeDadosDoUsuario.getIdDoUsuario(nickName: nickName) else { return false }
        
        let planetaJaEstaFavoritado = verificadorDePlanetasSalvosPorUsuario.verificaSePlanetaJaEstaFavoritadoPeloUsuario(
            planeta: planeta,
            idDoUsuario: idDoUsuario
        )
        
        return planetaJaEstaFavoritado
    }
    
    public func removerPlanetaDosFavoritos(
        planeta: Planeta,
        nickNameDoUsuario: String,
        buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository,
        removePlanetaDosFavoritos: RemovePlanetaDosFavoritosRepository
    ) -> Bool {
        guard let idDoUsuario = buscadorDeDadosDoUsuario.getIdDoUsuario(nickName: nickNameDoUsuario) else { return false }
        
        let planetaFoiRemovido = removePlanetaDosFavoritos.remover(
            planeta: planeta,
            idDoUsuario: idDoUsuario
        )
            
        return planetaFoiRemovido
    }
}
