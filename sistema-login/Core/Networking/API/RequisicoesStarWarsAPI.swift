//
//  RequisicoesStarWarsAPI.swift
//  sistema-login
//
//  Created by Leonardo Leite on 24/11/22.
//

import UIKit
import Alamofire

protocol RequisicoesStarWarsAPIProtocol {
    func fazRequisicaoPersonagem(
        id: Int,
        resultado: @escaping(_ personagem: Personagem?) -> Void
    )
    
    func fazRequisicaoPlaneta(
        id: Int,
        resultado: @escaping(_ planeta: Planeta?) -> Void
    )
    
    func fazRequisicaoNave(
        id: Int,
        resultado: @escaping(_ nave: Nave?) -> Void
    )
    
}

class RequisicoesStarWarsAPI: RequisicoesStarWarsAPIProtocol {
    
    func fazRequisicaoPersonagem(
        id: Int,
        resultado: @escaping(_ personagem: Personagem?) -> Void)
    {
        let requisicao = AF.request("https://swapi.dev/api/people/\(id)/")

        requisicao.responseDecodable(of: Personagem.self) { response in

            if response.response?.statusCode == 404 {
                resultado(nil)
                return
            }

            guard let data = response.data else {
                resultado(nil)
                return
            }

            let decoder = JSONDecoder()
            do {
                let personagem = try decoder.decode(Personagem.self, from: data)
                resultado(personagem)
                return
            } catch {
                return
            }
        }
    }
    
    func fazRequisicaoPlaneta(
        id: Int,
        resultado: @escaping(_ planeta: Planeta?) -> Void)
    {
        let requisicao = AF.request("https://swapi.dev/api/planets/\(id)/")

        requisicao.responseDecodable(of: Planeta.self) { response in

            if response.response?.statusCode == 404 {
                resultado(nil)
                return
            }

            guard let data = response.data else {
                resultado(nil)
                return
            }

            let decoder = JSONDecoder()
            do {
                let planeta = try decoder.decode(Planeta.self, from: data)
                resultado(planeta)
                return
            } catch {
                return
            }
        }
    }
    
    func fazRequisicaoNave(
        id: Int,
        resultado: @escaping(_ nave: Nave?) -> Void)
    {
        let requisicao = AF.request("https://swapi.dev/api/starships/\(id)/")

        requisicao.responseDecodable(of: Nave.self) { response in

            if response.response?.statusCode == 404 {
                resultado(nil)
                return
            }

            guard let data = response.data else {
                resultado(nil)
                return
            }

            let decoder = JSONDecoder()
            do {
                let nave = try decoder.decode(Nave.self, from: data)
                resultado(nave)
                return
            } catch {
                return
            }
        }
    }
}
