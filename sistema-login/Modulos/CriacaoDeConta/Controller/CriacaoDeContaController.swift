//
//  CriacaoDeContaController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 10/11/22.
//

import UIKit

class CriacaoDeContaController {
    
    private let controladorDeErros: ControladorDeErros
    private let validadorDeUsuario: ValidacoesDeDadosDoUsuario
    private let salvarUsuario: SalvarUsuarioRepository
    private let verificadorDeDadosCadastrados: VerificadorDeDadosCadastradosRepository
    
    init(
        _ controladorDeErros: ControladorDeErros,
        _ validadorDeUsuario: ValidacoesDeDadosDoUsuario,
        _ salvarUsuario: SalvarUsuarioRepository,
        _ verificadorDeDadosCadastrados: VerificadorDeDadosCadastradosRepository
    ) {
        self.controladorDeErros = controladorDeErros
        self.validadorDeUsuario = validadorDeUsuario
        self.salvarUsuario = salvarUsuario
        self.verificadorDeDadosCadastrados = verificadorDeDadosCadastrados
    }
    
    public func criarConta(
        nickName: String?,
        nomeCompleto: String?,
        email: String?,
        senha: String?,
        repeticaoDeSenha: String?
    ) -> Bool {
        guard let nickName = nickName,
              let nomeCompleto = nomeCompleto,
              let email = email,
              let senha = senha,
              let repeticaoDeSenha = repeticaoDeSenha
        else {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroAlgumDadoDoUsuarioEstaNulo()
            )
            return false
        }
        
        let usuarioPodeSerCadastrado = self.verificaSeUsuarioPodeSerCadastrado(
            nickName,
            nomeCompleto,
            email,
            senha,
            repeticaoDeSenha
        )
        
        if !usuarioPodeSerCadastrado {
            return false
        }
        
        let usuario = Usuario(
            nickName: nickName,
            nomeCompleto: nomeCompleto,
            email: email,
            senha: senha,
            repeticaoDeSenha: repeticaoDeSenha
        )
        
        if !self.salvarUsuario.salvar(usuario) {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroAoSalvarUsuario()
            )
            return false
        }
        
        return true
    }
    
    private func verificaSeUsuarioPodeSerCadastrado(
        _ nickName: String,
        _ nomeCompleto: String,
        _ email: String,
        _ senha: String,
        _ repeticaoDeSenha: String
    ) -> Bool {
        
        var usuarioPodeSerCadastrado = true
        
        let verificaSeNickNameEInvalido = (
            self.validadorDeUsuario.nickNameDoUsuarioEstaVazio(nickName) ||
            self.validadorDeUsuario.nickNameDoUsuarioTemMenosDe5Caracteres(nickName) ||
            self.validadorDeUsuario.nickNameDoUsuarioTemMaisDe32Caracteres(nickName) ||
            self.validadorDeUsuario.nickNameDoUsuarioNaoEUmAlfaNumerico(nickName) ||
            self.validadorDeUsuario.nickNameDoUsuarioJaEstaCadastrado(nickName, self.verificadorDeDadosCadastrados)
        )
        
        let verificaSeNomeCompletoEInvalido = (
            self.validadorDeUsuario.nomeCompletoDoUsuarioEstaVazio(nomeCompleto) ||
            self.validadorDeUsuario.nomeCompletoDoUsuarioContemCaracteresInvalidos(nomeCompleto) ||
            self.validadorDeUsuario.nomeCompletoDoUsuarioTemMaisDe130Caracteres(nomeCompleto)
        )
        
        let verificaSeEmailEInvalido = (
            self.validadorDeUsuario.emailDoUsuarioEstaVazio(email) ||
            self.validadorDeUsuario.emailDoUsuarioEInvalido(email) ||
            self.validadorDeUsuario.emailDoUsuarioTemMaisDe150Caracteres(email) ||
            self.validadorDeUsuario.emailDoUsuarioJaEstaCadastrado(email, self.verificadorDeDadosCadastrados)
        )
        
        let verificaSeSenhaEInvalida = (
            self.validadorDeUsuario.senhaDoUsuarioEstaVazia(senha) ||
            self.validadorDeUsuario.senhaDoUsuarioTemMenosQue8Caracteres(senha) ||
            self.validadorDeUsuario.senhaDoUsuarioTemMaisQue32Caracteres(senha)
        )
        
        let verificaSeRepeticaoDeSenhaEInvalida = (
            self.validadorDeUsuario.repeticaoDaSenhaDoUsuarioEstaVazia(repeticaoDeSenha) ||
            self.validadorDeUsuario.repeticaoDaSenhaDoUsuarioEDiferenteDaSenha(senha, repeticaoDeSenha)
        )
        
        if (
            verificaSeNickNameEInvalido ||
            verificaSeNomeCompletoEInvalido ||
            verificaSeEmailEInvalido ||
            verificaSeSenhaEInvalida ||
            verificaSeRepeticaoDeSenhaEInvalida
        )
        {
            usuarioPodeSerCadastrado = false
        }
        
        return usuarioPodeSerCadastrado
    }
}
