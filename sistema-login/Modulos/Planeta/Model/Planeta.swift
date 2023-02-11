//
//  Planeta.swift
//  sistema-login
//
//  Created by Leonardo Leite on 02/12/22.
//

import UIKit

class Planeta: Codable {
    
    // MARK: - Atributos
    private var name: String = ""
    private var diameter: String = ""
    private var climate: String = ""
    private var gravity: String = ""
    private var terrain: String = ""
    private var population: String = ""
    
    // MARK - Getters
    public func getNome() -> String {
        return self.name
    }
    
    public func getDiametro() -> String {
        return self.diameter
    }
    
    public func getClima() -> String {
        return self.climate
    }
    
    public func getGravidade() -> String {
        return self.gravity
    }
    
    public func getTerreno() -> String {
        return self.terrain
    }
    
    public func getPopulacao() -> String {
        return self.population
    }
    
    public func getListaComDadosDoPlaneta() -> [String] {
        let caracteristicasDoPlaneta: [String] = [
            "Nome: \(self.name)",
            "Diâmetro: \(self.diameter)",
            "Clima: \(self.climate)",
            "Gravidade: \(self.gravity)",
            "Terreno: \(self.terrain)",
            "População: \(self.population)"
        ]
        
        return caracteristicasDoPlaneta
    }
    
    // MARK: - Setters
    public func setNome(_ nome: String) -> Void {
        self.name = nome
    }
    
    public func setDiametro(_ diametro: String) -> Void {
        self.diameter = diametro
    }
    
    public func setClima(_ clima: String) -> Void {
        self.climate = clima
    }
    
    public func setGravidade(_ gravidade: String) -> Void {
        self.gravity = gravidade
    }
    
    public func setTerreno(_ terreno: String) -> Void {
        self.terrain = terreno
    }
    
    public func setPopulacao(_ populacao: String) -> Void {
        self.population = populacao
    }

}
