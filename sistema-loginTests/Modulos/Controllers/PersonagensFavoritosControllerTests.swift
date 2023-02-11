//
//  PersonagensFavoritosControllerTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 05/01/23.
//

import XCTest
@testable import sistema_login

final class PersonagensFavoritosControllerTests: XCTestCase {

    // MARK: - Atributos
    private var instanciaDoBanco: OpaquePointer!
    private var personagensFController: PersonagensFavoritosController!
    private var nickName: String!
    private var buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioMock!
    private var buscadorDePersonagensFavoritos: BuscadorDePersonagensFavoritosMock!
    private var removePersonagemDosFavoritos: RemovePersonagemDosFavoritosMock!
    
    // MARK: - Pre-sets
    override func setUpWithError() throws {
        self.instanciaDoBanco = DBManager().openDatabase(DBPath: "t.sqlite")!
        self.personagensFController = PersonagensFavoritosController(
            instanciaDoBanco: instanciaDoBanco
        )
        self.nickName = "Teste"
        self.buscadorDePersonagensFavoritos = BuscadorDePersonagensFavoritosMock()
        self.buscadorDeDadosDoUsuario = RecuperaDadosDoUsuarioMock()
        
        self.removePersonagemDosFavoritos = RemovePersonagemDosFavoritosMock()
    }
    
    // MARK: - Testes busca personagem
    func testPersonagensDeveriamSerBuscadosMasIDDoUsuarioNaoFoiEncontrado() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = nil
        
        let personagens = self.personagensFController.buscaTodosOsPersonagensFavoritosDoUsuario(
            nickNameUsuario: self.nickName,
            buscadorDePersonagensFavoritos: self.buscadorDePersonagensFavoritos,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario
        )
        
        XCTAssertNil(personagens)
    }
    
    func testIDFoiEncontradoPoremPersonagensFavoritosRetornouNil() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.buscadorDePersonagensFavoritos.retornoDaFuncaoBuscar = nil
        
        let personagens = self.personagensFController.buscaTodosOsPersonagensFavoritosDoUsuario(
            nickNameUsuario: self.nickName,
            buscadorDePersonagensFavoritos: self.buscadorDePersonagensFavoritos,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario
        )
        
        XCTAssertNil(personagens)
    }
    
    func testIDFoiEncontradoEUmaListaDePersonagensERetornada() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.buscadorDePersonagensFavoritos.retornoDaFuncaoBuscar = [Personagem(), Personagem()]
        
        let personagens = self.personagensFController.buscaTodosOsPersonagensFavoritosDoUsuario(
            nickNameUsuario: self.nickName,
            buscadorDePersonagensFavoritos: self.buscadorDePersonagensFavoritos,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario
        )
        
        XCTAssertNotNil(personagens)
        XCTAssertEqual(2, personagens!.count)
    }
    
    // MARK: - Testes remove personagem
    func testPersonagemDeveriaSerRemovidoMasIDNaoFoiEncontrado() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = nil
        
        let personagemFoiRemovido = self.personagensFController.removePersonagemDosFavoritosDoUsuario(
            personagem: Personagem(),
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario,
            removePersonagemFavorito: self.removePersonagemDosFavoritos
        )
        
        XCTAssertFalse(personagemFoiRemovido)
    }
    
    func testIDFoiEncontradoMasPersonagemNaoFoiRemovido() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.removePersonagemDosFavoritos.retornoDaFuncaoRemover = false
        
        let personagemFoiRemovido = self.personagensFController.removePersonagemDosFavoritosDoUsuario(
            personagem: Personagem(),
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario,
            removePersonagemFavorito: self.removePersonagemDosFavoritos
        )
        
        XCTAssertFalse(personagemFoiRemovido)
    }
    
    func testIDFoiEncontradoEPersonagemFoiRemovido() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.removePersonagemDosFavoritos.retornoDaFuncaoRemover = true
        
        let personagemFoiRemovido = self.personagensFController.removePersonagemDosFavoritosDoUsuario(
            personagem: Personagem(),
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario,
            removePersonagemFavorito: self.removePersonagemDosFavoritos
        )
        
        XCTAssertTrue(personagemFoiRemovido)
    }
    
}
