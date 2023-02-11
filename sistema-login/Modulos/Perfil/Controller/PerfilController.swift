//
//  PerfilController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 22/12/22.
//

import UIKit

class PerfilController {
    
    public func removeOsDadosDeLoginDoUsuario() -> Void {
        UserDefaults.standard.set(false, forKey: "esta_logado")
        UserDefaults.standard.removeObject(forKey: "user_id")
    }
    
    public func selecaoDeImagemDePerfilDoUsuario(
        _ selecionadorDeImagem: EscolherImagem,
        _ image: @escaping(_ imagem: UIImage?, _ pathImagem: URL?) -> Void
    ) -> Void {
        selecionadorDeImagem.selecionarImagem() { (imagem, pathImagem) in
            image(imagem, pathImagem)
        }
    }
    
    public func apagarConta(
        nickNameUsuario: String,
        removeUsuarioDoSistema: RemoveUsuarioRepository,
        buscaDadosDoUsuario: RecuperaDadosDoUsuarioRepository
    ) -> Bool {
        guard let idDoUsuario = buscaDadosDoUsuario.getIdDoUsuario(nickName: nickNameUsuario) else {
            return false
        }
        
        let usuarioFoiRemovido = removeUsuarioDoSistema.remover(idUsuario: idDoUsuario)
        
        return usuarioFoiRemovido
    }
}
