//
//  PlanetasFavoritosControllerTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 05/01/23.
//

import XCTest
@testable import sistema_login

final class PlanetasFavoritosControllerTests: XCTestCase {

    // MARK: - Atributos
    private var instanciaDoBanco: OpaquePointer!
    private var planetasFController: PlanetasFavoritosController!
    private var nickName: String!
    private var buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioMock!
    private var buscadorDePlanetasFavoritos: BuscadorDePlanetasFavoritosMock!
    private var removePlanetaDosFavoritos: RemovePlanetaDosFavoritosMock!
    
    // MARK: - Pre-sets
    override func setUpWithError() throws {
        self.instanciaDoBanco = DBManager().openDatabase(DBPath: "t.sqlite")!
        self.planetasFController = PlanetasFavoritosController(
            instanciaDoBanco: instanciaDoBanco
        )
        self.nickName = "Teste"
        self.buscadorDePlanetasFavoritos = BuscadorDePlanetasFavoritosMock()
        self.buscadorDeDadosDoUsuario = RecuperaDadosDoUsuarioMock()
        
        self.removePlanetaDosFavoritos = RemovePlanetaDosFavoritosMock()
    }
    
    // MARK: - Testes busca personagem
    func testPlanetasDeveriamSerBuscadosMasIDDoUsuarioNaoFoiEncontrado() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = nil
        
        let planetas = self.planetasFController.buscaTodosOsPlanetasFavoritosDoUsuario(
            nickNameUsuario: self.nickName,
            buscadorDePlanetasFavoritos: self.buscadorDePlanetasFavoritos,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario
        )
        
        XCTAssertNil(planetas)
    }
    
    func testIDFoiEncontradoPoremPlanetasFavoritosRetornouNil() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.buscadorDePlanetasFavoritos.retornoDaFuncaoBuscar = nil
        
        let planetas = self.planetasFController.buscaTodosOsPlanetasFavoritosDoUsuario(
            nickNameUsuario: self.nickName,
            buscadorDePlanetasFavoritos: self.buscadorDePlanetasFavoritos,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario
        )
        
        XCTAssertNil(planetas)
    }
    
    func testIDFoiEncontradoEUmaListaDePlanetasERetornada() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.buscadorDePlanetasFavoritos.retornoDaFuncaoBuscar = [Planeta(), Planeta()]
        
        let planetas = self.planetasFController.buscaTodosOsPlanetasFavoritosDoUsuario(
            nickNameUsuario: self.nickName,
            buscadorDePlanetasFavoritos: self.buscadorDePlanetasFavoritos,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario
        )
        
        XCTAssertNotNil(planetas)
        XCTAssertEqual(2, planetas!.count)
    }
    
    // MARK: - Testes remove personagem
    func testPlanetaDeveriaSerRemovidoMasIDNaoFoiEncontrado() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = nil
        
        let planetaFoiRemovido = self.planetasFController.removePlanetaDosFavoritosDoUsuario(
            planeta: Planeta(),
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario,
            removePlanetaFavorito: self.removePlanetaDosFavoritos
        )
        
        XCTAssertFalse(planetaFoiRemovido)
    }
    
    func testIDFoiEncontradoMasPlanetaNaoFoiRemovido() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.removePlanetaDosFavoritos.retornoDaFuncaoRemover = false
        
        let planetaFoiRemovido = self.planetasFController.removePlanetaDosFavoritosDoUsuario(
            planeta: Planeta(),
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario,
            removePlanetaFavorito: self.removePlanetaDosFavoritos
        )
        
        XCTAssertFalse(planetaFoiRemovido)
    }
    
    func testIDFoiEncontradoEPlanetaFoiRemovido() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.removePlanetaDosFavoritos.retornoDaFuncaoRemover = true
        
        let planetaFoiRemovido = self.planetasFController.removePlanetaDosFavoritosDoUsuario(
            planeta: Planeta(),
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario,
            removePlanetaFavorito: self.removePlanetaDosFavoritos
        )
        
        XCTAssertTrue(planetaFoiRemovido)
    }
    
}
