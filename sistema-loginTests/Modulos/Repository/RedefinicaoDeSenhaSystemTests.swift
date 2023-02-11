//
//  RedefinicaoDeSenhaStaticClassTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 15/12/22.
//

import XCTest
@testable import sistema_login

final class RedefinicaoDeSenhaSystemTests: XCTestCase {
    
    // MARK: - Atributos
    private var usuariosArmazenamento: UsuariosDadosStatic!
    
    // MARK: Pre-sets
    override func setUpWithError() throws {
        self.usuariosArmazenamento = UsuariosDadosStatic()
    }
    
    // MARK: - Testes
    func testEmailEEncontradoESenhaEAlterada() {
        
        self.salvarUsuario(self.usuariosArmazenamento)
        
        let redefinicaoDeSenha = RedefinicaoDeSenhaSystem(
            usuariosArmazenamento: self.usuariosArmazenamento
        )
        
        XCTAssertEqual("senha", self.usuariosArmazenamento.getUsuariosSalvos()[0].getSenhaDoUsuario())
        
        let senhaFoiRedefinida = redefinicaoDeSenha.redefinirSenha(email: "Email", senha: "novasenha")
        
        XCTAssertTrue(senhaFoiRedefinida)
        
        XCTAssertEqual("novasenha", self.usuariosArmazenamento.getUsuariosSalvos()[0].getSenhaDoUsuario())
    }
    
    func testEmailNaoEEncontradoESenhaNaoEAlterada() {
        let redefinicaoDeSenha = RedefinicaoDeSenhaSystem(
            usuariosArmazenamento: self.usuariosArmazenamento
        )
        
        let senhaFoiRedefinida = redefinicaoDeSenha.redefinirSenha(email: "Email", senha: "senha")
        
        XCTAssertFalse(senhaFoiRedefinida)
        
    }
    
    // MARK: - Funcoes
    private func salvarUsuario(_ usuariosArmazenamento: UsuariosDadosStatic) -> Void {
        let usuario = Usuario(
            nickName: "Apelido",
            nomeCompleto: "Nome completo",
            email: "Email",
            senha: "senha",
            repeticaoDeSenha: "repeticao de senha"
        )
        
        usuariosArmazenamento.salvarUsuario(usuario)
    }

}
