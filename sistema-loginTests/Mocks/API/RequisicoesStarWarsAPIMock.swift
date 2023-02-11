//
//  RequisicoesStarWarsAPIMock.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 04/01/23.
//

import UIKit
@testable import sistema_login

class RequisicoesStarWarsAPIMock: RequisicoesStarWarsAPIProtocol {
    
    var semErrosNaRequisicao: Bool?
    
    var personagemDaRequisicao: Personagem?
    
    var planetaDaRequisicao: Planeta?
    
    var naveDaRequisicao: Nave?
    
    func fazRequisicaoPersonagem(id: Int, resultado: @escaping (Personagem?) -> Void) {
        if !(self.semErrosNaRequisicao ?? true) {
            resultado(nil)
        }
        
        resultado(self.personagemDaRequisicao)
    }
    
    func fazRequisicaoPlaneta(id: Int, resultado: @escaping (Planeta?) -> Void) {
        if !(self.semErrosNaRequisicao ?? true) {
            resultado(nil)
        }
        
        resultado(self.planetaDaRequisicao)
    }
    
    func fazRequisicaoNave(id: Int, resultado: @escaping (Nave?) -> Void) {
        if !(self.semErrosNaRequisicao ?? true) {
            resultado(nil)
        }
        
        resultado(self.naveDaRequisicao)
    }
    
}
