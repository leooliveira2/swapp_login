//
//  RecuperacaoDeSenhaController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class RecuperacaoDeSenhaController {
    
    private let controladorDeErros: ControladorDeErros
    private let validadorDeDados: ValidacoesDeDadosDoUsuario
    
    init(_ controladorDeErros: ControladorDeErros, _ validadorDeDados: ValidacoesDeDadosDoUsuario) {
        self.controladorDeErros = controladorDeErros
        self.validadorDeDados = validadorDeDados
    }
    
    // MARK: - Buscar usuario
    public func buscaUsuarioParaRedefinicaoDeSenha(
        email: String?,
        verificadorDeDadosCadastrados: VerificadorDeDadosCadastradosRepository
    ) -> Bool {
        guard let email = email else {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroAlgumDadoDoUsuarioEstaNulo()
            )
            
            return false
        }
        
        let emailEValido = self.verificaSeEmailDoUsuarioEValido(email, verificadorDeDadosCadastrados)
        
        return emailEValido
    }
    
    private func verificaSeEmailDoUsuarioEValido(
        _ email: String,
        _ verificadorDeDadosCadastrados: VerificadorDeDadosCadastradosRepository
    ) -> Bool {
        
        let emailEstaVazio = self.validadorDeDados.emailDoUsuarioEstaVazio(email)
        
        if emailEstaVazio {
            return false
        }
        
        let emailExiste = verificadorDeDadosCadastrados.verificaSeEmailJaEstaCadastrado(email)
        
        if !emailExiste {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroEmailNaoEncontrado()
            )
            return false
        }
        
        return true
    }
    
    // MARK: - Redefinir senha
    public func alterarSenha(
        email: String?,
        senha: String?,
        repeticaoSenha: String?,
        redefinicaoDeSenha: RedefinicaoDeSenhaRepository
    ) -> Bool
    {
        guard let senha = senha,
              let repeticaoSenha = repeticaoSenha,
              let email = email
        else
        {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroAlgumDadoDoUsuarioEstaNulo()
            )
            
            return false
        }
        
        let senhaPodeSerAlterada = self.verificaSeSenhaPodeSerAlterada(senha, repeticaoSenha)
        
        if !senhaPodeSerAlterada {
            return false
        }
        
        if !redefinicaoDeSenha.redefinirSenha(email: email, senha: senha) {
            self.controladorDeErros.adicionarErro(
                erro: Erros().erroAoSalvarNovaSenha()
            )
            
            return false
        }
        
        return true
    }
    
    private func verificaSeSenhaPodeSerAlterada(
        _ senha: String,
        _ repeticaoDeSenha: String
    ) -> Bool
    {
        
        let verificaSeSenhaEInvalida = (
            self.validadorDeDados.senhaDoUsuarioEstaVazia(senha) ||
            self.validadorDeDados.senhaDoUsuarioTemMenosQue8Caracteres(senha) ||
            self.validadorDeDados.senhaDoUsuarioTemMaisQue32Caracteres(senha)
        )
        
        let verificaSeRepeticaoDeSenhaEInvalida = (
            self.validadorDeDados.repeticaoDaSenhaDoUsuarioEstaVazia(repeticaoDeSenha) ||
            self.validadorDeDados.repeticaoDaSenhaDoUsuarioEDiferenteDaSenha(senha, repeticaoDeSenha)
        )
        
        if (
            verificaSeSenhaEInvalida ||
            verificaSeRepeticaoDeSenhaEInvalida
        ) {
            return false
        }
        
        return true
        
    }
}
