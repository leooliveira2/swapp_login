//
//  NavesFavoritasViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 28/12/22.
//

import UIKit

class NavesFavoritasViewController: UIViewController {
    
    // MARK: - Atributos
    private var listaDeNavesFavoritas: [Nave] = []
    
    private let instanciaDoBanco: OpaquePointer
    
    // MARK: - Inicializadores
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View
    private lazy var navesFavoritasView: NavesFavoritasView = {
        let view = NavesFavoritasView()
        return view
    }()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.navesFavoritasView
        
        self.navesFavoritasView.getListaDeNavesTableView().delegate = self
        self.navesFavoritasView.getListaDeNavesTableView().dataSource = self
        
        self.buscaNavesFavoritasDoUsuario()
        
        self.verificaQuantasNavesExistemParaConfigurarAVisualizacao()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Funcoes
    private func buscaNavesFavoritasDoUsuario() -> Void {
        let alertas = Alerta(viewController: self)
        
        guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else {
            alertas.criaAlerta(mensagem: "Erro interno! Favor tentar novamente!")
            return
        }
        
        let navesFavoritasController = NavesFavoritasController(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let buscadorDeNavesFavoritas = BuscadorDeNavesFavoritasSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let buscaDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        guard let listaDeNaves = navesFavoritasController.buscaTodasAsNavesFavoritasDoUsuario(
            nickNameUsuario: nickNameDoUsuario,
            buscadorDeNavesFavoritas: buscadorDeNavesFavoritas,
            buscadorDeDadosDoUsuario: buscaDadosDoUsuario
        ) else {
            alertas.criaAlerta(mensagem: "Erro ao buscar naves")
            self.listaDeNavesFavoritas = []
            return
        }
        
        self.listaDeNavesFavoritas = listaDeNaves
    }
    
    private func verificaQuantasNavesExistemParaConfigurarAVisualizacao() -> Void {
        if self.listaDeNavesFavoritas.count == 0 {
            self.navesFavoritasView.configComponentesQuandoNaoHouverNaves()
            return
        }
        
        self.navesFavoritasView.configComponentesComListaDeNaves()
    }
    
    private func acoesQuandoOBotaoRemoverNaveForClicado(
        nave: Nave,
        indice: IndexPath
    ) -> Void
    {
        let alertas = Alerta(viewController: self)
        
        guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else {
            alertas.criaAlerta(mensagem: "Erro ao remover nave")
            return
        }
        
        let buscadorDeDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let removeNaveFavorita = RemoveNaveDosFavoritosSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let navesFavoritasController = NavesFavoritasController(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let naveFoiRemovida = navesFavoritasController.removeNaveDosFavoritosDoUsuario(
            nave: nave,
            nickNameDoUsuario: nickNameDoUsuario,
            buscadorDeDadosDoUsuario: buscadorDeDadosDoUsuario,
            removeNaveFavorita: removeNaveFavorita
        )
        
        if !naveFoiRemovida {
            alertas.criaAlerta(mensagem: "Erro ao remover nave")
            return
        }
        
        self.listaDeNavesFavoritas.remove(at: indice.row)
        self.navesFavoritasView.getListaDeNavesTableView().reloadData()
        
        if self.listaDeNavesFavoritas.count == 0 {
            self.navesFavoritasView.configComponentesQuandoNaoHouverNaves()
        }

    }

}

// MARK: - Extensoes
extension NavesFavoritasViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaDeNavesFavoritas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.listaDeNavesFavoritas[indexPath.row].getNome()
        cell.tintColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertas = Alerta(viewController: self)
        
        let nave = self.listaDeNavesFavoritas[indexPath.row]
        
        let mensagem = "\nModelo: \(nave.getModelo())" +
                        "\n\nFabricante: \(nave.getFabricante())" +
                        "\n\nCusto em créditos: \(nave.getCustoEmCreditos())" +
                        "\n\nComprimento: \(nave.getComprimento())" +
                        "\n\nPassageiros: \(nave.getPassageiros())"

        alertas.criaAlertaPersonalizadoParaExclusao(
            titulo: nave.getNome(),
            mensagem: mensagem,
            handler: { _ in
                self.acoesQuandoOBotaoRemoverNaveForClicado(
                    nave: nave,
                    indice: indexPath
                )
            }
        )
    }
    
}
