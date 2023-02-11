//
//  VerificadorDeDadosCadastradosStaticClassTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 15/12/22.
//

import XCTest
@testable import sistema_login

final class VerificadorDeDadosCadastradosSystemTests: XCTestCase {
    
    // MARK: - Atributos
    private var usuariosArmazenamento: UsuariosDadosStatic!
    private var verificadorDeDadosCadastrados: VerificadorDeDadosCadastradosSystem!
    
    // MARK: - Pre-sets
    override func setUpWithError() throws {
        self.usuariosArmazenamento = UsuariosDadosStatic()
        self.verificadorDeDadosCadastrados = VerificadorDeDadosCadastradosSystem(
            usuariosArmazenamento: self.usuariosArmazenamento
        )
    }
    
    // MARK: - Testes
    func testNickNameJaEstaCadastrado() {
        self.salvarUsuario(self.usuariosArmazenamento)
        
        let nickNameDeUsuarioEstaCadastrado = self.verificadorDeDadosCadastrados.verificaSeNickNameJaEstaCadastrado("usuario")
        
        XCTAssertTrue(nickNameDeUsuarioEstaCadastrado)
    }
    
    func testNickNameNaoEstaCadastrado() {
        let nickNameDeUsuarioEstaCadastrado = self.verificadorDeDadosCadastrados.verificaSeNickNameJaEstaCadastrado("usuario2")
        
        XCTAssertFalse(nickNameDeUsuarioEstaCadastrado)
    }
    
    func testEmailJaEstaCadastrado() {
        self.salvarUsuario(self.usuariosArmazenamento)
        
        let emailDeUsuarioEstaCadastrado = self.verificadorDeDadosCadastrados.verificaSeEmailJaEstaCadastrado("email@email.com")
        
        XCTAssertTrue(emailDeUsuarioEstaCadastrado)
    }
    
    func testEmailNaoEstaCadastrado() {
        let emailDeUsuarioEstaCadastrado = self.verificadorDeDadosCadastrados.verificaSeNickNameJaEstaCadastrado("email2@email.com")
        
        XCTAssertFalse(emailDeUsuarioEstaCadastrado)
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
