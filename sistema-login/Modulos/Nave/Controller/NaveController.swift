//
//  NaveController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 05/12/22.
//

import UIKit

class NaveController {
    
    public func gerarNave(
        requisicoesSWAPI: RequisicoesStarWarsAPIProtocol,
        sucesso: @escaping(_ nave: Nave) -> Void,
        fracasso: @escaping() -> Void
    ) -> Void
    {
        requisicoesSWAPI.fazRequisicaoNave(id: gerarIdAleatorio()) { nave in
            guard let naveVindaDaRequisicao = nave else { fracasso(); return }
            
            sucesso(naveVindaDaRequisicao)
            return
        }
    }
    
    private func gerarIdAleatorio() -> Int {
        let numero = Int(arc4random_uniform(41))
        return numero
    }
    
    public func adicionarNaveAosFavoritos(
        _ nave: Nave,
        adicionaAosFavoritos: SalvarNaveFavoritaRepository,
        buscaDadosDoUsuario: RecuperaDadosDoUsuarioRepository,
        nickNameDoUsuario: String
    ) -> Bool
    {
        guard let idUsuario = buscaDadosDoUsuario.getIdDoUsuario(nickName: nickNameDoUsuario) else { return false }
        
        let naveFoiSalva = adicionaAosFavoritos.salvarComoFavorito(nave, idUsuario: idUsuario)
        
        return naveFoiSalva
    }
    
    public func verificaSeNaveJaEstaFavoritada(
        nave: Nave,
        nickName: String,
        verificadorDeNavesSalvasPorUsuario: VerificadorDeNavesJaAdicionadasAUmUsuarioRepository,
        buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository
    ) -> Bool {
        
        guard let idDoUsuario = buscadorDeDadosDoUsuario.getIdDoUsuario(nickName: nickName) else { return false }
        
        let naveJaEstaFavoritada = verificadorDeNavesSalvasPorUsuario.verificaSeNaveJaEstaFavoritadaPeloUsuario(
            nave: nave,
            idDoUsuario: idDoUsuario
        )
        
        return naveJaEstaFavoritada
    }
    
    public func removerNaveDosFavoritos(
        nave: Nave,
        nickNameDoUsuario: String,
        buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository,
        removeNaveDosFavoritos: RemoveNaveDosFavoritosRepository
    ) -> Bool {
        guard let idDoUsuario = buscadorDeDadosDoUsuario.getIdDoUsuario(nickName: nickNameDoUsuario) else { return false }
        
        let naveFoiRemovida = removeNaveDosFavoritos.remover(
            nave: nave,
            idDoUsuario: idDoUsuario
        )
            
        return naveFoiRemovida
    }
}
