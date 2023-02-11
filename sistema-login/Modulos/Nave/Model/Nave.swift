//
//  Nave.swift
//  sistema-login
//
//  Created by Leonardo Leite on 05/12/22.
//

import UIKit

class Nave: Codable {
    
    // MARK: - Atributos
    private var name = ""
    private var model = ""
    private var manufacturer = ""
    private var cost_in_credits = ""
    private var length = ""
    private var passengers = ""
    
    // MARK: - Getters
    public func getNome() -> String {
        return self.name
    }
    
    public func getModelo() -> String {
        return self.model
    }
    
    public func getFabricante() -> String {
        return self.manufacturer
    }
    
    public func getCustoEmCreditos() -> String {
        return self.cost_in_credits
    }
    
    public func getComprimento() -> String {
        return self.length
    }
    
    public func getPassageiros() -> String {
        return self.passengers
    }
    
    public func getListaComDadosDaNave() -> [String] {
        let caracteristicasDaNave: [String] = [
            "Nome: \(self.name)",
            "Modelo: \(self.model)",
            "Fabricante: \(self.manufacturer)",
            "Custo em créditos: \(self.cost_in_credits)",
            "Comprimento: \(self.length)",
            "Passageiros: \(self.passengers)"
        ]
        
        return caracteristicasDaNave
    }
    
    // MARK: - Setters
    public func setNome(_ nome: String) -> Void {
        self.name = nome
    }
    
    public func setModelo(_ modelo: String) -> Void {
        self.model = modelo
    }
    
    public func setFabricante(_ fabricante: String) -> Void {
        self.manufacturer = fabricante
    }
    
    public func setCustoEmCreditos(_ custoEmCreditos: String) -> Void {
        self.cost_in_credits = custoEmCreditos
    }
    
    public func setComprimento(_ comprimento: String) -> Void {
        self.length = comprimento
    }
    
    public func setPassageiros(_ passageiros: String) -> Void {
        self.passengers = passageiros
    }

}
