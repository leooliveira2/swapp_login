//
//  SairViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 02/12/22.
//

import UIKit

class PerfilViewController: UIViewController {
    
    // MARK: - View
    private lazy var perfilView: PerfilView = {
        let view = PerfilView()
        return view
    }()
    
    // MARK: - Atributos
    private let conteudoCelulasOpcoesTableView: [String] = [
        "Personagens favoritos",
        "Planetas favoritos",
        "Naves favoritas"
    ]
    
    private let instanciaDoBanco: OpaquePointer
    
    // MARK: - Inicializadores
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.perfilView
        
        self.perfilView.getOpcoesTableView().delegate = self
        self.perfilView.getOpcoesTableView().dataSource = self
        
        self.perfilView.getBotaoAdicionarImagemAoPerfil().addTarget(
            self,
            action: #selector(selecionarImagemDePerfil(_:)),
            for: .touchUpInside
        )
        
        self.perfilView.getNickUsuarioLabel().text = self.getNickNameDoUsuario()
        
        self.perfilView.getBotaoSairButton().addTarget(
            self,
            action: #selector(botaoSairFoiClicado(_: )),
            for: .touchUpInside
        )
        
        self.perfilView.getApagarContaButton().addTarget(
            self,
            action: #selector(acoesQuandoOBotaoApagarContaForClicado(_:)),
            for: .touchUpInside
        )
        
        guard let fotoDePerfil = self.recuperarFotoDePerfil() else { return }
        
        self.perfilView.getFotoDePerfilImageView().image = fotoDePerfil
        
        guard let navigationController = self.navigationController else { return }
        
        if navigationController.viewControllers.count > 1 {
            navigationController.viewControllers.removeFirst()
        }
    }
        
    // MARK: - Actions
    @objc private func botaoSairFoiClicado(_ sender: UIButton) -> Void {
        
        let perfilController = PerfilController()
        
        perfilController.removeOsDadosDeLoginDoUsuario()
        
        guard let navigationController = self.navigationController else { return }
        
        navigationController.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc private func acoesQuandoOBotaoApagarContaForClicado(_ sender: UIButton) -> Void {
        let alertas = Alerta(viewController: self)
        
        let perfilController = PerfilController()
        
        alertas.criaAlertaPersonalizadoParaExclusao(
            titulo: "Excluir conta",
            mensagem: "Deseja mesmo excluir sua conta?",
            "Cancelar",
            "Excluir"
        ) { _ in
            self.apagarConta(perfilController: perfilController, alertas: alertas)
        }
    }
    
    // MARK: - Funcoes
    private func redirecionaParaViewEscolhidaNasOpcoesTableView(indiceClicado: Int) -> Void {
        if indiceClicado == 0 {
            self.navigationController?.pushViewController(
                PersonagensFavoritosViewController(instanciaDoBanco: self.instanciaDoBanco),
                animated: true
            )
            return
        }
        
        if indiceClicado == 1 {
            self.navigationController?.pushViewController(
                PlanetasFavoritosViewController(instanciaDoBanco: self.instanciaDoBanco),
                animated: true
            )
            return
        }
        
        if indiceClicado == 2 {
            self.navigationController?.pushViewController(
                NavesFavoritasViewController(instanciaDoBanco: self.instanciaDoBanco),
                animated: true
            )
            return
        }
    }
    
    private func getNickNameDoUsuario() -> String? {
        guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else { return nil }
        
        return nickNameDoUsuario
    }
    
    @objc func selecionarImagemDePerfil(_ sender: UIButton) -> Void {
        let perfilController = PerfilController()
        
        let selecionadorDeImagem = EscolherImagem(viewController: self)
        perfilController.selecaoDeImagemDePerfilDoUsuario(
            selecionadorDeImagem
        ) { (imagem, pathImagem) in
            
            guard let fotoDePerfil = imagem else { print("ERRRRRRRO"); return }
            guard let pathFotoDePerfil = pathImagem else { print("ERRRRRRO"); return }
            
            let pathString = pathFotoDePerfil.absoluteString

            self.perfilView.getFotoDePerfilImageView().image = fotoDePerfil
            self.salvarPathDaImagem(pathImagem: pathString)
        }
    }
    
    private func salvarPathDaImagem(pathImagem: String) -> Void {
        guard let nickNameUsuario = self.getNickNameDoUsuario() else { return }
        
        UserDefaults.standard.set(pathImagem, forKey: "path_imagem_perfil_\(nickNameUsuario)")
    }
    
    private func recuperarFotoDePerfil() -> UIImage? {
        guard let nickNameUsuario = self.getNickNameDoUsuario() else { return nil }
        
        guard let pathImagem =  UserDefaults.standard.string(forKey: "path_imagem_perfil_\(nickNameUsuario)") else { return nil }
        
        guard let pathURL = URL(string: pathImagem) else { return nil }
        
        do {
            let data = try Data(contentsOf: pathURL)
            let imagem = UIImage(data: data)
            print("Foto de perfil atualizada com sucesso!")
            return imagem
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    private func apagarConta(perfilController: PerfilController, alertas: Alerta) -> Void {
        guard let nickNameUsuario = self.getNickNameDoUsuario() else { return }
        let removeUsuarioDoSistema = RemoveUsuarioSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        let buscaDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let contaFoiRemovida = perfilController.apagarConta(
            nickNameUsuario: nickNameUsuario,
            removeUsuarioDoSistema: removeUsuarioDoSistema,
            buscaDadosDoUsuario: buscaDadosDoUsuario
        )
        
        if !contaFoiRemovida {
            alertas.criaAlerta(mensagem: "Erro ao apagar sua conta!")
            return
        }
        
        perfilController.removeOsDadosDeLoginDoUsuario()
        
        guard let navigationController = self.navigationController else {
            alertas.criaAlerta(
                titulo: "Sucesso",
                mensagem: "Conta excluída com sucesso"
            )
            
            return
        }
        
        navigationController.pushViewController(LoginViewController(), animated: true)
    }
    
}

// MARK: - Extensoes
extension PerfilViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.backgroundColor = .black
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.numberOfLines = 2
        
        cell.textLabel?.text = self.conteudoCelulasOpcoesTableView[indexPath.row]
        cell.textLabel?.textColor = .white
        
//        var config = UIListContentConfiguration.cell()
//        config.text = ""
//        config.secondaryText = ""
//        config.image = UIImage
//        cell.contentConfiguration = config
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.redirecionaParaViewEscolhidaNasOpcoesTableView(indiceClicado: indexPath.row)
    }
    
}
