//
//  ControladorDeErros.swift
//  sistema-login
//
//  Created by Leonardo Leite on 08/11/22.
//

import UIKit

class ControladorDeErros {
    
    private var erros: Array<String> = []
    
    public func adicionarErro(erro: String) -> Void {
        self.erros.append(erro)
    }
    
    public func getErros() -> Array<String> {
        return self.erros
    }
}
