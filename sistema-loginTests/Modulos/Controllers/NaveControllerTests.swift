//
//  NaveControllerTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 05/01/23.
//

import XCTest
@testable import sistema_login

final class NaveControllerTests: XCTestCase {

    // MARK: - Atributos
    private var naveTeste: Nave!
    
    private var naveController: NaveController!
    private var requisicoesSWAPI: RequisicoesStarWarsAPIMock!
    
    private var adicionaAosFavoritos: SalvarNaveFavoritaMock!
    private var buscaDadosDoUsuario: RecuperaDadosDoUsuarioMock!
    private var nickName: String!
    
    private var verificadorDeNavesSalvas: VerificadorDeNavesJaAdicionadasAUmUsuarioMock!

    private var removeNaveDosFavoritos: RemoveNaveDosFavoritosMock!
    
    // MARK: - Pre-sets
    override func setUpWithError() throws {
        self.naveTeste = Nave()
        self.naveTeste.setNome("Testando")
        
        self.naveController = NaveController()
        self.requisicoesSWAPI = RequisicoesStarWarsAPIMock()
        
        self.adicionaAosFavoritos = SalvarNaveFavoritaMock()
        self.buscaDadosDoUsuario = RecuperaDadosDoUsuarioMock()
        self.nickName = "Testando"
        
        self.verificadorDeNavesSalvas = VerificadorDeNavesJaAdicionadasAUmUsuarioMock()
        
        self.removeNaveDosFavoritos = RemoveNaveDosFavoritosMock()
    }
    
    // MARK: - Testes gerar personagem
    func testNaveERetornadaPelaRequisicao() {
        self.requisicoesSWAPI.naveDaRequisicao = naveTeste
        
        self.naveController.gerarNave(
            requisicoesSWAPI: requisicoesSWAPI) { nave in
                XCTAssertEqual(
                    nave.getNome(),
                    self.naveTeste.getNome()
                )
            } fracasso: {
        }
    }
    
    func testNaveRetornaComoNilDaRequisicao() {
        self.requisicoesSWAPI.semErrosNaRequisicao = false
        
        self.naveController.gerarNave(
            requisicoesSWAPI: requisicoesSWAPI) { nave in
                XCTAssertNil(nave)
            } fracasso: {
        }
    }
    
    // MARK: - Testes adicionar personagem aos favoritos
    func testNaveTemQueSerSalvaComoFavoritaMasIDDoUsuarioNaoEEncontrado() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = nil
        
        let naveFoiFavoritada = self.naveController.adicionarNaveAosFavoritos(
            self.naveTeste,
            adicionaAosFavoritos: self.adicionaAosFavoritos,
            buscaDadosDoUsuario: self.buscaDadosDoUsuario,
            nickNameDoUsuario: self.nickName
        )
        
        XCTAssertFalse(naveFoiFavoritada)
    }
    
    func testIDDoUsuarioFoiEncontradoMasNaveNaoFoiSalva() {
        self.adicionaAosFavoritos.retornoDaFuncaoSalvarComoFavorito = false
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        
        let naveFoiFavoritada = self.naveController.adicionarNaveAosFavoritos(
            self.naveTeste,
            adicionaAosFavoritos: self.adicionaAosFavoritos,
            buscaDadosDoUsuario: self.buscaDadosDoUsuario,
            nickNameDoUsuario: self.nickName
        )
        
        XCTAssertFalse(naveFoiFavoritada)
    }
    
    func testIDDoUsuarioFoiEncontradoENaveFoiSalva() {
        self.adicionaAosFavoritos.retornoDaFuncaoSalvarComoFavorito = true
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        
        let naveFoiFavoritada = self.naveController.adicionarNaveAosFavoritos(
            self.naveTeste,
            adicionaAosFavoritos: self.adicionaAosFavoritos,
            buscaDadosDoUsuario: self.buscaDadosDoUsuario,
            nickNameDoUsuario: self.nickName
        )
        
        XCTAssertTrue(naveFoiFavoritada)
    }
    
    // MARK: - Testes verifica se personagem ja esta favoritado
    func testVerificacaoEraPraSerRealizadaMasIdDoUsuarioNaoFoiEncontrado() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = nil
        
        let naveJaEstaFavoritada = self.naveController.verificaSeNaveJaEstaFavoritada(
            nave: self.naveTeste,
            nickName: self.nickName,
            verificadorDeNavesSalvasPorUsuario: self.verificadorDeNavesSalvas,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario
        )
        
        XCTAssertFalse(naveJaEstaFavoritada)
    }
    
    func testIDDoUsuarioEEncontradoMasNaveNaoEstaFavoritada() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.verificadorDeNavesSalvas.retornoDaFuncaoVerifica = false
        
        let naveJaEstaFavoritada = self.naveController.verificaSeNaveJaEstaFavoritada(
            nave: self.naveTeste,
            nickName: self.nickName,
            verificadorDeNavesSalvasPorUsuario: self.verificadorDeNavesSalvas,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario)
        
        XCTAssertFalse(naveJaEstaFavoritada)
    }
    
    func testIDDoUsuarioEEncontradoENaveEstaFavoritada() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.verificadorDeNavesSalvas.retornoDaFuncaoVerifica = true
        
        let naveJaEstaFavoritada = self.naveController.verificaSeNaveJaEstaFavoritada(
            nave: self.naveTeste,
            nickName: self.nickName,
            verificadorDeNavesSalvasPorUsuario: self.verificadorDeNavesSalvas,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario)
        
        XCTAssertTrue(naveJaEstaFavoritada)
    }
    
    // MARK: - Testes remover personagemDosFavoritos
    func testPlanetaDeveriaSerRemovidoMasIDDoUsuarioNaoFoiEncontrado() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = nil
        
        let naveFoiRemovida = self.naveController.removerNaveDosFavoritos(
            nave: self.naveTeste,
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario,
            removeNaveDosFavoritos: self.removeNaveDosFavoritos
        )
        
        XCTAssertFalse(naveFoiRemovida)
    }
    
    func testIDDoUsuarioEEncontradoPoremNaveNaoERemovida() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.removeNaveDosFavoritos.retornoDaFuncaoRemover = false
        
        let naveFoiRemovida = self.naveController.removerNaveDosFavoritos(
            nave: self.naveTeste,
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario,
            removeNaveDosFavoritos: self.removeNaveDosFavoritos
        )
        
        XCTAssertFalse(naveFoiRemovida)
    }
    
    func testIDDoUsuarioEEncontradoENaveFoiRemovida() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.removeNaveDosFavoritos.retornoDaFuncaoRemover = true
        
        let naveFoiRemovida = self.naveController.removerNaveDosFavoritos(
            nave: self.naveTeste,
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario,
            removeNaveDosFavoritos: self.removeNaveDosFavoritos
        )
        
        XCTAssertTrue(naveFoiRemovida)
    }

}
