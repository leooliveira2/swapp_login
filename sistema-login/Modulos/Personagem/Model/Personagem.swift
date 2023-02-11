//
//  Personagem.swift
//  sistema-login
//
//  Created by Leonardo Leite on 24/11/22.
//

import UIKit

class Personagem: Codable {
    
    // MARK: - Atributos
    private var name: String = ""
    private var height: String = ""
    private var mass: String = ""
    private var eye_color: String = ""
    private var birth_year: String = ""
    private var gender: String = ""
    
    // MARK: - Getters
    public func getNomePersonagem() -> String {
        return self.name
    }
    
    public func getAlturaPersonagem() -> String {
        return self.height
    }
    
    public func getPesoPersonagem() -> String {
        return self.mass
    }
    
    public func getCorDosOlhosPersonagem() -> String {
        return self.eye_color
    }
    
    public func getAnoNascimentoPersonagem() -> String {
        return self.birth_year
    }
    
    public func getGeneroPersonagem() -> String {
        return self.gender
    }
    
    // MARK: - Setters
    public func setNome(_ nome: String) -> Void {
        self.name = nome
    }
    
    public func setAltura(_ altura: String) -> Void {
        self.height = altura
    }
    
    public func setPeso(_ peso: String) -> Void {
        self.mass = peso
    }
    
    public func setCorDosOlhos(_ corDosOlhos: String) -> Void {
        self.eye_color = corDosOlhos
    }
    
    public func setAnoNascimento(_ anoNascimento: String) -> Void {
        self.birth_year = anoNascimento
    }
    
    public func setGenero(_ genero: String) -> Void {
        self.gender = genero
    }
    
    // MARK: - Funcoes
    public func getListaComDadosDoPersonagem() -> [String] {
        let caracteristicasDoPersonagem: [String] = [
            "Nome: \(self.name)",
            "Altura: \(self.height)",
            "Peso: \(self.mass)",
            "Cor dos olhos: \(self.eye_color)",
            "Ano de nascimento: \(self.birth_year)",
            "Gênero: \(self.gender)"
        ]
        
        return caracteristicasDoPersonagem
    }
    
}
