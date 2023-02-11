//
//  PersonagemControllerTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 04/01/23.
//

import XCTest
@testable import sistema_login

final class PersonagemControllerTests: XCTestCase {
    
    // MARK: - Atributos
    private var personagemTeste: Personagem!
    
    private var personagemController: PersonagemController!
    private var requisicoesSWAPI: RequisicoesStarWarsAPIMock!
    
    private var adicionaAosFavoritos: SalvarPersonagemFavoritoMock!
    private var buscaDadosDoUsuario: RecuperaDadosDoUsuarioMock!
    private var nickName: String!
    
    private var verificadorDePersonagensSalvos: VerificadorDePersonagensJaAdicionadosAUmUsuarioMock!

    private var removePersonagemDosFavoritos: RemovePersonagemDosFavoritosMock!
    
    // MARK: - Pre-sets
    override func setUpWithError() throws {
        self.personagemTeste = Personagem()
        self.personagemTeste.setNome("Testando")
        
        self.personagemController = PersonagemController()
        self.requisicoesSWAPI = RequisicoesStarWarsAPIMock()
        
        self.adicionaAosFavoritos = SalvarPersonagemFavoritoMock()
        self.buscaDadosDoUsuario = RecuperaDadosDoUsuarioMock()
        self.nickName = "Testando"
        
        self.verificadorDePersonagensSalvos = VerificadorDePersonagensJaAdicionadosAUmUsuarioMock()
        
        self.removePersonagemDosFavoritos = RemovePersonagemDosFavoritosMock()
    }
    
    // MARK: - Testes gerar personagem
    func testPersonagemERetornadoPelaRequisicao() {
        self.requisicoesSWAPI.personagemDaRequisicao = personagemTeste
        
        self.personagemController.gerarPersonagem(
            requisicoesSWAPI: requisicoesSWAPI) { personagem in
                XCTAssertEqual(
                    personagem.getNomePersonagem(),
                    self.personagemTeste.getNomePersonagem()
                )
            } fracasso: {
        }
    }
    
    func testPersonagemRetornaComoNilDaRequisicao() {
        self.requisicoesSWAPI.semErrosNaRequisicao = false
        
        self.personagemController.gerarPersonagem(
            requisicoesSWAPI: requisicoesSWAPI) { personagem in
                XCTAssertNil(personagem)
            } fracasso: {
        }
    }
    
    // MARK: - Testes adicionar personagem aos favoritos
    func testPersonagemTemQueSerSalvoComoFavoritoMasIDDoUsuarioNaoEEncontrado() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = nil
        
        let personagemFoiFavoritado = self.personagemController.adicionarPersonagemAosFavoritos(
            self.personagemTeste,
            adicionaAosFavoritos: self.adicionaAosFavoritos,
            buscaDadosDoUsuario: self.buscaDadosDoUsuario,
            nickNameDoUsuario: self.nickName
        )
        
        XCTAssertFalse(personagemFoiFavoritado)
    }
    
    func testIDDoUsuarioFoiEncontradoMasPersonagemNaoFoiSalvo() {
        self.adicionaAosFavoritos.retornoDaFuncaoSalvarComoFavorito = false
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        
        let personagemFoiFavoritado = self.personagemController.adicionarPersonagemAosFavoritos(
            self.personagemTeste,
            adicionaAosFavoritos: self.adicionaAosFavoritos,
            buscaDadosDoUsuario: self.buscaDadosDoUsuario,
            nickNameDoUsuario: self.nickName
        )
        
        XCTAssertFalse(personagemFoiFavoritado)
    }
    
    func testIDDoUsuarioFoiEncontradoEPersonagemFoiSalvo() {
        self.adicionaAosFavoritos.retornoDaFuncaoSalvarComoFavorito = true
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        
        let personagemFoiFavoritado = self.personagemController.adicionarPersonagemAosFavoritos(
            self.personagemTeste,
            adicionaAosFavoritos: self.adicionaAosFavoritos,
            buscaDadosDoUsuario: self.buscaDadosDoUsuario,
            nickNameDoUsuario: self.nickName
        )
        
        XCTAssertTrue(personagemFoiFavoritado)
    }
    
    // MARK: - Testes verifica se personagem ja esta favoritado
    func testVerificacaoEraPraSerRealizadaMasIdDoUsuarioNaoFoiEncontrado() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = nil
        
        let personagemJaEstaFavoritado = self.personagemController.verificaSePersonagemJaEstaFavoritado(
            personagem: self.personagemTeste,
            nickName: self.nickName,
            verificadorDePersonagensSalvosPorUsuario: self.verificadorDePersonagensSalvos,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario)
        
        XCTAssertFalse(personagemJaEstaFavoritado)
    }
    
    func testIDDoUsuarioEEncontradoMasPersonagemNaoEstaFavoritado() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.verificadorDePersonagensSalvos.retornoDaFuncaoVerifica = false
        
        let personagemJaEstaFavoritado = self.personagemController.verificaSePersonagemJaEstaFavoritado(
            personagem: self.personagemTeste,
            nickName: self.nickName,
            verificadorDePersonagensSalvosPorUsuario: self.verificadorDePersonagensSalvos,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario)
        
        XCTAssertFalse(personagemJaEstaFavoritado)
    }
    
    func testIDDoUsuarioEEncontradoEPersonagemEstaFavoritado() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.verificadorDePersonagensSalvos.retornoDaFuncaoVerifica = true
        
        let personagemJaEstaFavoritado = self.personagemController.verificaSePersonagemJaEstaFavoritado(
            personagem: self.personagemTeste,
            nickName: self.nickName,
            verificadorDePersonagensSalvosPorUsuario: self.verificadorDePersonagensSalvos,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario)
        
        XCTAssertTrue(personagemJaEstaFavoritado)
    }
    
    // MARK: - Testes remover personagemDosFavoritos
    func testPersonagemDeveriaSerRemovidoMasIDDoUsuarioNaoFoiEncontrado() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = nil
        
        let personagemFoiRemovido = self.personagemController.removerPersonagemDosFavoritos(
            personagem: self.personagemTeste,
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario,
            removePersonagemDosFavoritos: self.removePersonagemDosFavoritos
        )
        
        XCTAssertFalse(personagemFoiRemovido)
    }
    
    func testIDDoUsuarioEEncontradoPoremPersonagemNaoERemovido() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.removePersonagemDosFavoritos.retornoDaFuncaoRemover = false
        
        let personagemFoiRemovido = self.personagemController.removerPersonagemDosFavoritos(
            personagem: self.personagemTeste,
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario,
            removePersonagemDosFavoritos: self.removePersonagemDosFavoritos
        )
        
        XCTAssertFalse(personagemFoiRemovido)
    }
    
    func testIDDoUsuarioEEncontradoEPersonagemFoiRemovido() {
        self.buscaDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.removePersonagemDosFavoritos.retornoDaFuncaoRemover = true
        
        let personagemFoiRemovido = self.personagemController.removerPersonagemDosFavoritos(
            personagem: self.personagemTeste,
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscaDadosDoUsuario,
            removePersonagemDosFavoritos: self.removePersonagemDosFavoritos
        )
        
        XCTAssertTrue(personagemFoiRemovido)
    }
}
