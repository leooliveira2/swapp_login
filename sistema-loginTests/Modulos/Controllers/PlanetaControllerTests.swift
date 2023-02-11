//
//  PlanetaControllerTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 05/01/23.
//

import XCTest
@testable import sistema_login

final class PlanetaControllerTests: XCTestCase {

    // MARK: - Atributos
    private var planetaTeste: Planeta!
    
    private var planetaController: PlanetaController!
    private var requisicoesSWAPI: RequisicoesStarWarsAPIMock!
    
    private var adicionaAosFavoritos: SalvarPlanetaFavoritoMock!
    private var buscaDadosDoUsuario: RecuperaDadosDoUsuarioMock!
    private var nickName: String!
    
    private var verificadorDePlanetasSalvos: VerificadorDePlanetasJaAdicionadosAUmUsuarioMock!

    private var removePlanetaDosFavoritos: RemovePlanetaDosFavoritosMock!
    
    // MARK: - Pre-sets
    override func setUpWithError() throws {
        self.planetaTeste = Planeta()
        self.planetaTeste.setNome("Testando")
        
        self.planetaController = PlanetaController()
        self.requisicoesSWAPI = RequisicoesStarWarsAPIMock()
        
        self.adicionaAosFavoritos = SalvarPlanetaFavoritoMock()
        self.buscaDadosDoUsuario = RecuperaDadosDoUsuarioMock()
        self.nickName = "Testando"
        
        self.verificadorDePlanetasSalvos = VerificadorDePlanetasJaAdicionadosAUmUsuarioMock()
        
        self.removePlanetaDosFavoritos = RemovePlanetaDosFavoritosMock()
    }
    
    // MARK: - Testes gerar personagem
    func testPlanetaERetornadoPelaRequisicao() {
        self.requisicoesSWAPI.planetaDaRequisicao = planetaTeste
        
        self.planetaController.gerarPlaneta(
            requisicoesSWAPI: requisicoesSWAPI) { planeta in
                XCTAssertEqual(
                    planeta.getNome(),
                    self.planetaTeste.getNome()
                )
            } fracasso: {
        }
    }
    
    func testPlanetaRetornaComoNilDaRequisicao() {
        self.requisicoesSWAPI.semErrosNaRequisicao = false
        
        self.planetaController.gerarPlaneta(
            requisicoesSWAPI: requisicoesSWAPI) { planeta in
                XCTAssertNil(planeta)
            } fracasso: {
        }
    }
    
    // MARK: - Testes adicionar personagem aos favoritos
    func testPlanetaTemQueSerSalvoComoFavoritoMasIDDoUsuarioNaoEEncontrado() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = nil
        
        let planetaFoiFavoritado = self.planetaController.adicionarPlanetaAosFavoritos(
            self.planetaTeste,
            adicionaAosFavoritos: self.adicionaAosFavoritos,
            buscaDadosDoUsuario: self.buscaDadosDoUsuario,
            nickNameDoUsuario: self.nickName
        )
        
        XCTAssertFalse(planetaFoiFavoritado)
    }
    
    func testIDDoUsuarioFoiEncontradoMasPlanetaNaoFoiSalvo() {
        self.adicionaAosFavoritos.retornoDaFuncaoSalvarComoFavorito = false
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        
        let planetaFoiFavoritado = self.planetaController.adicionarPlanetaAosFavoritos(
            self.planetaTeste,
            adicionaAosFavoritos: self.adicionaAosFavoritos,
            buscaDadosDoUsuario: self.buscaDadosDoUsuario,
            nickNameDoUsuario: self.nickName
        )
        
        XCTAssertFalse(planetaFoiFavoritado)
    }
    
    func testIDDoUsuarioFoiEncontradoEPlanetaFoiSalvo() {
        self.adicionaAosFavoritos.retornoDaFuncaoSalvarComoFavorito = true
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        
        let planetaFoiFavoritado = self.planetaController.adicionarPlanetaAosFavoritos(
            self.planetaTeste,
            adicionaAosFavoritos: self.adicionaAosFavoritos,
            buscaDadosDoUsuario: self.buscaDadosDoUsuario,
            nickNameDoUsuario: self.nickName
        )
        
        XCTAssertTrue(planetaFoiFavoritado)
    }
    
    // MARK: - Testes verifica se personagem ja esta favoritado
    func testVerificacaoEraPraSerRealizadaMasIdDoUsuarioNaoFoiEncontrado() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = nil
        
        let planetaJaEstaFavoritado = self.planetaController.verificaSePlanetaJaEstaFavoritado(
            planeta: self.planetaTeste,
            nickName: self.nickName,
            verificadorDePlanetasSalvosPorUsuario: self.verificadorDePlanetasSalvos,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario
        )
        
        XCTAssertFalse(planetaJaEstaFavoritado)
    }
    
    func testIDDoUsuarioEEncontradoMasPlanetaNaoEstaFavoritado() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.verificadorDePlanetasSalvos.retornoDaFuncaoVerifica = false
        
        let planetaJaEstaFavoritado = self.planetaController.verificaSePlanetaJaEstaFavoritado(
            planeta: self.planetaTeste,
            nickName: self.nickName,
            verificadorDePlanetasSalvosPorUsuario: self.verificadorDePlanetasSalvos,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario)
        
        XCTAssertFalse(planetaJaEstaFavoritado)
    }
    
    func testIDDoUsuarioEEncontradoEPlanetaEstaFavoritado() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.verificadorDePlanetasSalvos.retornoDaFuncaoVerifica = true
        
        let planetaJaEstaFavoritado = self.planetaController.verificaSePlanetaJaEstaFavoritado(
            planeta: self.planetaTeste,
            nickName: self.nickName,
            verificadorDePlanetasSalvosPorUsuario: self.verificadorDePlanetasSalvos,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario)
        
        XCTAssertTrue(planetaJaEstaFavoritado)
    }
    
    // MARK: - Testes remover personagemDosFavoritos
    func testPlanetaDeveriaSerRemovidoMasIDDoUsuarioNaoFoiEncontrado() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = nil
        
        let planetaFoiRemovido = self.planetaController.removerPlanetaDosFavoritos(
            planeta: self.planetaTeste,
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario,
            removePlanetaDosFavoritos: self.removePlanetaDosFavoritos
        )
        
        XCTAssertFalse(planetaFoiRemovido)
    }
    
    func testIDDoUsuarioEEncontradoPoremPlanetaNaoERemovido() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.removePlanetaDosFavoritos.retornoDaFuncaoRemover = false
        
        let planetaFoiRemovido = self.planetaController.removerPlanetaDosFavoritos(
            planeta: self.planetaTeste,
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario,
            removePlanetaDosFavoritos: self.removePlanetaDosFavoritos
        )
        
        XCTAssertFalse(planetaFoiRemovido)
    }
    
    func testIDDoUsuarioEEncontradoEPlanetaFoiRemovido() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.removePlanetaDosFavoritos.retornoDaFuncaoRemover = true
        
        let planetaFoiRemovido = self.planetaController.removerPlanetaDosFavoritos(
            planeta: self.planetaTeste,
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario,
            removePlanetaDosFavoritos: self.removePlanetaDosFavoritos
        )
        
        XCTAssertTrue(planetaFoiRemovido)
    }
}
