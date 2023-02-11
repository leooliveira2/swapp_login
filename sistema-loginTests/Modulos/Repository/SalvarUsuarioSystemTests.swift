//
//  SalvarUsuarioStaticClassTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 15/12/22.
//

import XCTest
@testable import sistema_login

final class SalvarUsuarioSystemTests: XCTestCase {
    
    func testUsuarioESalvo() {
        let usuariosArmazenamento = UsuariosDadosStatic()
        
        let salvarUsuario = SalvarUsuarioSystem(usuariosArmazenamento: usuariosArmazenamento)
        
        let usuario = Usuario(
            nickName: "Usuario",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let usuarioFoiSalvo = salvarUsuario.salvar(usuario)
        
        XCTAssertTrue(usuarioFoiSalvo)
        
        let verificadorDeDadosSalvos = VerificadorDeDadosCadastradosSystem(
            usuariosArmazenamento: usuariosArmazenamento
        )
        
        XCTAssertTrue(verificadorDeDadosSalvos.verificaSeNickNameJaEstaCadastrado("Usuario"))
    }

}
