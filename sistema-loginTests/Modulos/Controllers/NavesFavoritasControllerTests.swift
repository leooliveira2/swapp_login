//
//  NavesFavoritasControllerTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 05/01/23.
//

import XCTest
@testable import sistema_login

final class NavesFavoritasControllerTests: XCTestCase {

    // MARK: - Atributos
    private var instanciaDoBanco: OpaquePointer!
    private var navesFController: NavesFavoritasController!
    private var nickName: String!
    private var buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioMock!
    private var buscadorDeNavesFavoritas: BuscadorDeNavesFavoritasMock!
    private var removeNaveDosFavoritos: RemoveNaveDosFavoritosMock!
    
    // MARK: - Pre-sets
    override func setUpWithError() throws {
        self.instanciaDoBanco = DBManager().openDatabase(DBPath: "t.sqlite")!
        self.navesFController = NavesFavoritasController(
            instanciaDoBanco: instanciaDoBanco
        )
        self.nickName = "Teste"
        self.buscadorDeNavesFavoritas = BuscadorDeNavesFavoritasMock()
        self.buscadorDeDadosDoUsuario = RecuperaDadosDoUsuarioMock()
        
        self.removeNaveDosFavoritos = RemoveNaveDosFavoritosMock()
    }
    
    // MARK: - Testes busca personagem
    func testNavesDeveriamSerBuscadasMasIDDoUsuarioNaoFoiEncontrado() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = nil
        
        let naves = self.navesFController.buscaTodasAsNavesFavoritasDoUsuario(
            nickNameUsuario: self.nickName,
            buscadorDeNavesFavoritas: self.buscadorDeNavesFavoritas,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario
        )
        
        XCTAssertNil(naves)
    }
    
    func testIDFoiEncontradoPoremNavesFavoritasRetornouNil() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.buscadorDeNavesFavoritas.retornoDaFuncaoBuscar = nil
        
        let naves = self.navesFController.buscaTodasAsNavesFavoritasDoUsuario(
            nickNameUsuario: self.nickName,
            buscadorDeNavesFavoritas: self.buscadorDeNavesFavoritas,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario
        )
        
        XCTAssertNil(naves)
    }
    
    func testIDFoiEncontradoEUmaListaDeNavesERetornada() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.buscadorDeNavesFavoritas.retornoDaFuncaoBuscar = [Nave(), Nave()]
        
        let naves = self.navesFController.buscaTodasAsNavesFavoritasDoUsuario(
            nickNameUsuario: self.nickName,
            buscadorDeNavesFavoritas: self.buscadorDeNavesFavoritas,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario
        )
        
        XCTAssertNotNil(naves)
        XCTAssertEqual(2, naves!.count)
    }
    
    // MARK: - Testes remove personagem
    func testNaveDeveriaSerRemovidaMasIDNaoFoiEncontrado() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = nil
        
        let naveFoiRemovida = self.navesFController.removeNaveDosFavoritosDoUsuario(
            nave: Nave(),
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario,
            removeNaveFavorita: self.removeNaveDosFavoritos
        )
        
        XCTAssertFalse(naveFoiRemovida)
    }
    
    func testIDFoiEncontradoMasNaveNaoFoiRemovida() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.removeNaveDosFavoritos.retornoDaFuncaoRemover = false
        
        let naveFoiRemovida = self.navesFController.removeNaveDosFavoritosDoUsuario(
            nave: Nave(),
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario,
            removeNaveFavorita: self.removeNaveDosFavoritos
        )
        
        XCTAssertFalse(naveFoiRemovida)
    }
    
    func testIDFoiEncontradoENaveFoiRemovida() {
        self.buscadorDeDadosDoUsuario.retornoDaFuncaoGetIdDoUsuario = 1
        self.removeNaveDosFavoritos.retornoDaFuncaoRemover = true
        
        let naveFoiRemovida = self.navesFController.removeNaveDosFavoritosDoUsuario(
            nave: Nave(),
            nickNameDoUsuario: self.nickName,
            buscadorDeDadosDoUsuario: self.buscadorDeDadosDoUsuario,
            removeNaveFavorita: self.removeNaveDosFavoritos
        )
        
        XCTAssertTrue(naveFoiRemovida)
    }
    
}
