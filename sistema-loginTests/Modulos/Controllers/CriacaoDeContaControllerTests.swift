//
//  doisTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 19/12/22.
//

import XCTest
@testable import sistema_login

final class CriacaoDeContaControllerTests: XCTestCase {
    
    // MARK: - Atributos
    private var controladorDeErros: ControladorDeErros!
    private var validadorDeDadosDoUsuario: ValidacoesDeDadosDoUsuario!
    private var salvaUsuario: SalvarUsuarioSystemMock!
    private var verificadorDeDadosCadastrados: VerificadorDeDadosCadastradosSystemMock!
    
    private var controladorCriacaoDeConta: CriacaoDeContaController!
    
    // MARK: - Pre-sets
    override func setUpWithError() throws {
        self.controladorDeErros = ControladorDeErros()
        self.validadorDeDadosDoUsuario = ValidacoesDeDadosDoUsuario(self.controladorDeErros)
        self.salvaUsuario = SalvarUsuarioSystemMock()
        self.verificadorDeDadosCadastrados = VerificadorDeDadosCadastradosSystemMock()
        
        self.controladorCriacaoDeConta = CriacaoDeContaController(
            controladorDeErros,
            validadorDeDadosDoUsuario,
            salvaUsuario,
            verificadorDeDadosCadastrados
        )
    }

    // MARK: - Testes
    func testTodosOsDadosDoUsuarioEstaoNulos() {
        let contaPodeSerCriada = self.controladorCriacaoDeConta.criarConta(
            nickName: nil,
            nomeCompleto: nil,
            email: nil,
            senha: nil,
            repeticaoDeSenha: nil
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriada)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(Erros().erroAlgumDadoDoUsuarioEstaNulo(), erros[0])
    }
    
    func testAlgumDadoDoUsuarioEstaNulo() {
        let nickNameEstaNulo = self.controladorCriacaoDeConta.criarConta(
            nickName: nil,
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let nomeCompletoEstaNulo = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: nil,
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let emailEstaNulo = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: nil,
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let senhaEstaNula = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: nil,
            repeticaoDeSenha: "123123123"
        )
        
        let repeticaoDeSenhaEstaNula = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: nil
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(nickNameEstaNulo)
        XCTAssertFalse(nomeCompletoEstaNulo)
        XCTAssertFalse(emailEstaNulo)
        XCTAssertFalse(senhaEstaNula)
        XCTAssertFalse(repeticaoDeSenhaEstaNula)
        
        XCTAssertEqual(5, erros.count)
        XCTAssertEqual(Erros().erroAlgumDadoDoUsuarioEstaNulo(), erros[0])
        XCTAssertEqual(Erros().erroAlgumDadoDoUsuarioEstaNulo(), erros[1])
        XCTAssertEqual(Erros().erroAlgumDadoDoUsuarioEstaNulo(), erros[2])
        XCTAssertEqual(Erros().erroAlgumDadoDoUsuarioEstaNulo(), erros[3])
        XCTAssertEqual(Erros().erroAlgumDadoDoUsuarioEstaNulo(), erros[4])
    }
    
    func testCenariosEmQueONickNameEInvalido() {
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = false
        
        let contaPodeSerCriadaComNickNameDoUsuarioVazio = self.controladorCriacaoDeConta.criarConta(
            nickName: "",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let contaPodeSerCriadaComNickNameDoUsuarioTendoMenosDe5Caracteres = self.controladorCriacaoDeConta.criarConta(
            nickName: "cont",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let contaPodeSerCriadaComNickNameDoUsuarioTendoMaisDe32Caracteres = self.controladorCriacaoDeConta.criarConta(
            nickName: "abcdefghijklmnopqrstuvwxyzabcdefg",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let contaPodeSerCriadaComNickNameDoUsuarioNaoSendoUmAlfaNumerico = self.controladorCriacaoDeConta.criarConta(
            nickName: "@_ #$%",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeNickNameJaEstaCadastrado = true
        
        let contaPodeSerCriadaComNickNameDoUsuarioJaCadastrado = self.controladorCriacaoDeConta.criarConta(
            nickName: "Teste",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriadaComNickNameDoUsuarioVazio)
        XCTAssertFalse(contaPodeSerCriadaComNickNameDoUsuarioTendoMenosDe5Caracteres)
        XCTAssertFalse(contaPodeSerCriadaComNickNameDoUsuarioTendoMaisDe32Caracteres)
        XCTAssertFalse(contaPodeSerCriadaComNickNameDoUsuarioNaoSendoUmAlfaNumerico)
        XCTAssertFalse(contaPodeSerCriadaComNickNameDoUsuarioJaCadastrado)
        
        XCTAssertEqual(5, erros.count)
        
        XCTAssertEqual(Erros().erroNickDeUsuarioVazio(), erros[0])
        XCTAssertEqual(Erros().erroNickDeUsuarioTemMenosDe5Caracteres(), erros[1])
        XCTAssertEqual(Erros().erroNickDeUsuarioNaoPodeTerMaisDe32Caracteres(), erros[2])
        XCTAssertEqual(Erros().erroNickDeUsuarioNaoEUmAlfanumerico(), erros[3])
        XCTAssertEqual(Erros().erroNickDeUsuarioJaEstaCadastrado(), erros[4])
    }
    
    func testCenariosEmQueONomeCompletoEInvalido() {
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeNickNameJaEstaCadastrado = false
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = false
        
        let contaPodeSerCriadaComNomeCompletoDoUsuarioVazio = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let contaPodeSerCriadaComNomeCompletoDoUsuarioContendoCaracteresInvalidos = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "122$#%_",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let nomeCompleto = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefgabcdefghijklmnopqrstuvwxyz" + "abcdefgabcdefghijklmnopqrstuvwxyzabcdefgabcdef"
        
        let contaPodeSerCriadaComNomeCompletoDoUsuarioContendoMaisDe130Caracteres = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: nomeCompleto,
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriadaComNomeCompletoDoUsuarioVazio)
        XCTAssertFalse(contaPodeSerCriadaComNomeCompletoDoUsuarioContendoCaracteresInvalidos)
        XCTAssertFalse(contaPodeSerCriadaComNomeCompletoDoUsuarioContendoMaisDe130Caracteres)
        
        XCTAssertEqual(3, erros.count)
        
        XCTAssertEqual(Erros().erroNomeCompletoVazio(), erros[0])
        XCTAssertEqual(Erros().erroNomeCompletoSoPodeConterLetrasEEspacos(), erros[1])
        XCTAssertEqual(Erros().erroNomeCompletoNaoPodeTerMaisDe130Caracteres(), erros[2])
    }
    
    func testCenariosEmQueOEmailEInvalido() {
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeNickNameJaEstaCadastrado = false
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = false
        
        let contaPodeSerCriadaComEmailDoUsuarioVazio = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: "",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let contaPodeSerCriadaComEmailDoUsuarioComFormatoInvalido = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: "ola12,.",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let email = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefgabcdefghijklmnopqrstuvwxyz" + "abcdefgabcdefghijklmnopqrstuvwxyzabcdefgabcdefghijklmnop@email.com"
        
        
        let contaPodeSerCriadaComEmailDoUsuarioTendoMaisDe150Caracteres = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: email,
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = true
        
        let contaPodeSerCriadaComEmailDoUsuarioJaCadastrado = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriadaComEmailDoUsuarioVazio)
        XCTAssertFalse(contaPodeSerCriadaComEmailDoUsuarioComFormatoInvalido)
        XCTAssertFalse(contaPodeSerCriadaComEmailDoUsuarioTendoMaisDe150Caracteres)
        XCTAssertFalse(contaPodeSerCriadaComEmailDoUsuarioJaCadastrado)
        
        XCTAssertEqual(4, erros.count)
        
        XCTAssertEqual(Erros().erroEmailVazio(), erros[0])
        XCTAssertEqual(Erros().erroEmailInvalido(), erros[1])
        XCTAssertEqual(Erros().erroEmailTemMaisDe150Caracteres(), erros[2])
        XCTAssertEqual(Erros().erroEmailJaEstaCadastrado(), erros[3])
    }
    
    func testCenariosEmQueASenhaEInvalida() {
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeNickNameJaEstaCadastrado = false
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = false
        
        let contaPodeSerCriadaComSenhaDoUsuarioVazia = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "",
            repeticaoDeSenha: ""
        )
        
        let contaPodeSerCriadaComSenhaDoUsuarioContendoMenosDe8Caracteres = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "1234567",
            repeticaoDeSenha: "1234567"
        )
        
        let contaPodeSerCriadaComSenhaDoUsuarioContendoMaisDe32Caracteres = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123456781234567812345678123456781",
            repeticaoDeSenha: "123456781234567812345678123456781"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriadaComSenhaDoUsuarioVazia)
        XCTAssertFalse(contaPodeSerCriadaComSenhaDoUsuarioContendoMenosDe8Caracteres)
        XCTAssertFalse(contaPodeSerCriadaComSenhaDoUsuarioContendoMaisDe32Caracteres)
        
        XCTAssertEqual(4, erros.count)
        
        XCTAssertEqual(Erros().erroSenhaVazia(), erros[0])
        XCTAssertEqual(Erros().erroRepeticaoDeSenhaVazio(), erros[1])
        XCTAssertEqual(Erros().erroSenhaTemMenosDe8Caracteres(), erros[2])
        XCTAssertEqual(Erros().erroSenhaTemMaisDe32Caracteres(), erros[3])
    }
    
    func testCenarioExtraSenhaInvalida() {
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeNickNameJaEstaCadastrado = false
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = false
        
        let contaPodeSerCriadaComSenhaDoUsuarioVazia = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "",
            repeticaoDeSenha: "123123123"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriadaComSenhaDoUsuarioVazia)
        
        XCTAssertEqual(2, erros.count)
        
        XCTAssertEqual(Erros().erroSenhaVazia(), erros[0])
        XCTAssertEqual(Erros().erroRepeticaoDeSenhaESenhaSaoDiferentes(), erros[1])
    }
    
    func testCenariosEmQueARepeticaoDeSenhaEInvalida() {
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeNickNameJaEstaCadastrado = false
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = false
        
        let contaPodeSerCriadaComRepeticaoDeSenhaDoUsuarioVazia = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: ""
        )
        
        let contaPodeSerCriadaComRepeticaoDeSenhaDoUsuarioDiferenteDaSenha = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "321321321"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriadaComRepeticaoDeSenhaDoUsuarioVazia)
        XCTAssertFalse(contaPodeSerCriadaComRepeticaoDeSenhaDoUsuarioDiferenteDaSenha)
        
        XCTAssertEqual(2, erros.count)
        
        XCTAssertEqual(Erros().erroRepeticaoDeSenhaVazio(), erros[0])
        XCTAssertEqual(Erros().erroRepeticaoDeSenhaESenhaSaoDiferentes(), erros[1])
    }
    
    func testUsuarioTemDadosValidosMasUmaFalhaOcorreAoTentarSalvar() {
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeNickNameJaEstaCadastrado = false
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = false
        self.salvaUsuario.retornoDaFuncaoSalvar = false
        
        let contaPodeSerCriada = self.controladorCriacaoDeConta.criarConta(
            nickName: "teste1",
            nomeCompleto: "Usuario",
            email: "teste1@email.com",
            senha: "12345678",
            repeticaoDeSenha: "12345678"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriada)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(Erros().erroAoSalvarUsuario(), erros[0])
    }
    
    func testUsuarioTemDadosValidosEFoiSalvoComSucesso() {
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeNickNameJaEstaCadastrado = false
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = false
        self.salvaUsuario.retornoDaFuncaoSalvar = true
        
        let contaPodeSerCriada = self.controladorCriacaoDeConta.criarConta(
            nickName: "teste2",
            nomeCompleto: "Usuario",
            email: "teste2@email.com",
            senha: "12345678",
            repeticaoDeSenha: "12345678"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(contaPodeSerCriada)
        XCTAssertEqual(0, erros.count)
    }

}
