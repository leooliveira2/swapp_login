//
//  LoginViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 07/11/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Atributos
    private lazy var loginView: LoginView = {
        let view = LoginView()
        return view
    }()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let usuarioEstaLogado = self.verificaSeUsuarioEstaLogado()
        if usuarioEstaLogado {
            return
        }
        
        self.view = self.loginView
        
        self.loginView.getBotaoDeEntrar().addTarget(
            self, action: #selector(realizarLogin(_:)),
            for: .touchUpInside
        )
        
        self.loginView.getBotaoDeCadastro().addTarget(
            self, action: #selector(redirecionarParaTelaDeCriacaoDeContato(_:)),
            for: .touchUpInside
        )
        
        self.loginView.getBotaoRecuperarSenha().addTarget(self, action: #selector(redirecionarParaTelaDeRecuperacaoDeSenha(_:)), for: .touchUpInside)
        
        guard let navigationController = self.navigationController else { return }
        
        if navigationController.viewControllers.count > 1 {
            navigationController.viewControllers.removeFirst()
        }
        
        // Só pra exibir os users no terminal qnd o app iniciar a tela de login
        guard let db = DBManager().openDatabase(DBPath: "dados-usuarios.sqlite") else { return }
        Crud().exibeTodosOsUsuariosSalvos(instanciaDoBanco: db)
        
        let tabelasForamCriadasCorretamente = self.criaTabelasNoBanco(db: db)
        
        if !tabelasForamCriadasCorretamente {
            let alertas = Alerta(viewController: self)
            alertas.criaAlerta(mensagem: "Ocorreu um erro! Por favor reinicie a aplicação!")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Acoes
    @objc private func redirecionarParaTelaDeCriacaoDeContato(_ sender: UIButton) -> Void {
        guard let navigationController = self.navigationController else { return }
        
        let criacaoDeContaViewController = CriacaoDeContaViewController()
        
        navigationController.pushViewController(criacaoDeContaViewController, animated: true)
    }
    
    @objc private func redirecionarParaTelaDeRecuperacaoDeSenha(_ sender: UIButton) -> Void {
        guard let navigationController = self.navigationController else { return }
        
        let recuperacaoDeSenhaViewController = RecuperacaoDeSenhaViewController()
        
        navigationController.pushViewController(recuperacaoDeSenhaViewController, animated: true)
    }
    
    @objc private func realizarLogin(_ sender: UIButton) -> Void {
        let alertas = Alerta(viewController: self)
        
        guard let instanciaDoBanco = DBManager().openDatabase(DBPath: "dados-usuarios.sqlite") else {
            alertas.criaAlerta(mensagem: "Erro interno! Favor tentar novamente")
            return
        }
        
        let controladorDeErros = ControladorDeErros()
        let validadorDeLogin = ValidadorDeLoginSQLite(instanciaDoBanco: instanciaDoBanco)
        let validadorDeUsuario = ValidacoesDeDadosDoUsuario(controladorDeErros)
        let recuperaDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(instanciaDoBanco: instanciaDoBanco)
        
        let controlador = LoginController(
            controladorDeErros,
            validadorDeLogin,
            validadorDeUsuario,
            recuperaDadosDoUsuario
        )
        
        let loginPodeSerRealizado = controlador.fazerLogin(
            email: self.loginView.getEmailDoUsuarioTextField().text,
            senha: self.loginView.getSenhaDoUsuarioTextField().text
        )
        
        if !loginPodeSerRealizado {
            let listaDeErros = controladorDeErros.getErros()
            if listaDeErros.count > 0 {
                alertas.criaAlerta(mensagem: listaDeErros[0])
                return
            }
        }
        
        guard let navigationController = self.navigationController else {
            alertas.criaAlerta(mensagem: "Tente novamente!")
            return
        }
        
        let homeTabBarController = HomeTabBarController()
        navigationController.pushViewController(homeTabBarController, animated: true)
    }
    
    // MARK: - Funcoes
    private func verificaSeUsuarioEstaLogado() -> Bool {
        let usuarioEstaLogado = UserDefaults.standard.bool(forKey: "esta_logado")
        
        if usuarioEstaLogado {
            guard let navigationController = self.navigationController else { return false }
            navigationController.pushViewController(HomeTabBarController(), animated: true)
            return true
        }
        
        return false
    }
    
    private func criaTabelasNoBanco(db: OpaquePointer) -> Bool {
        
        let tabelaUsuariosFoiCriada = DBManager().createTable(criarTabelaString: "CREATE TABLE IF NOT EXISTS usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nickName TEXT UNIQUE NOT NULL, nomeCompleto TEXT NOT NULL, email TEXT UNIQUE NOT NULL, senha TEXT NOT NULL);"
                                , instanciaDoBanco: db)
        
        let tabelaPersonagensFavoritosFoiCriada = DBManager().createTable(criarTabelaString: "CREATE TABLE IF NOT EXISTS personagens_favoritos (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, altura TEXT NOT NULL, peso TEXT NOT NULL, corDosOlhos TEXT NOT NULL, anoNascimento TEXT NOT NULL, genero TEXT NOT NULL, id_usuario INTEGER NOT NULL, CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE);", instanciaDoBanco: db)
        
        let tabelaPlanetasFavoritosFoiCriada = DBManager().createTable(criarTabelaString: "CREATE TABLE IF NOT EXISTS planetas_favoritos (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, diametro TEXT NOT NULL, clima TEXT NOT NULL, gravidade TEXT NOT NULL, terreno TEXT NOT NULL, populacao TEXT NOT NULL, id_usuario INTEGER NOT NULL, CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE);", instanciaDoBanco: db)
        
        let tabelaNavesFavoritasFoiCriada = DBManager().createTable(criarTabelaString: "CREATE TABLE IF NOT EXISTS naves_favoritas (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, modelo TEXT NOT NULL, fabricante TEXT NOT NULL, custoEmCreditos TEXT NOT NULL, comprimento TEXT NOT NULL, passageiros TEXT NOT NULL, id_usuario INTEGER NOT NULL, CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE);", instanciaDoBanco: db)
        
        if !tabelaUsuariosFoiCriada ||
            !tabelaPersonagensFavoritosFoiCriada ||
            !tabelaPlanetasFavoritosFoiCriada ||
            !tabelaNavesFavoritasFoiCriada
        {
            return false
        }
        
        return true
        
    }

}

extension LoginViewController {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.loginView.endEditing(true)
    }
}
