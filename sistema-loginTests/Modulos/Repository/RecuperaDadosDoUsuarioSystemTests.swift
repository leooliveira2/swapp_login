//
//  RecuperaDadosDoUsuarioSystemTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 20/12/22.
//

import XCTest
@testable import sistema_login

final class RecuperaDadosDoUsuarioSystemTests: XCTestCase {
    
    // MARK: - Atributos
    private var usuariosArmazenamento: UsuariosDadosStatic!
    
    // MARK: Pre-sets
    override func setUpWithError() throws {
        self.usuariosArmazenamento = UsuariosDadosStatic()
    }

    
    // MARK: - Testes
    func testUsuarioFoiEncontradoENickNameRetornou() {
        
        self.salvarUsuario(self.usuariosArmazenamento)
        
        let recuperaDadosDoUsuario = RecuperaDadosDoUsuarioSystem(
            usuariosArmazenamento: self.usuariosArmazenamento
        )
        
        let nickName = recuperaDadosDoUsuario.getNickNameDoUsuario(
            email: "email@email.com"
        )
        
        XCTAssertEqual("usuario", nickName)
    }
    
    func testUsuarioNaoFoiEncontradoERetornoFoiNulo() {
        
        let recuperaDadosDoUsuario = RecuperaDadosDoUsuarioSystem(
            usuariosArmazenamento: self.usuariosArmazenamento
        )
        
        let nickName = recuperaDadosDoUsuario.getNickNameDoUsuario(email: "email@email.com")
        
        XCTAssertNil(nickName)
    }
    
    // MARK: - Funcoes
    private func salvarUsuario(_ usuariosArmazenamento: UsuariosDadosStatic) -> Void {
        let salvarUsuario = SalvarUsuarioSystem(usuariosArmazenamento: usuariosArmazenamento)
        
        let usuario = Usuario(
            nickName: "usuario",
            nomeCompleto: "nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        _ = salvarUsuario.salvar(usuario)
    }
    
}
