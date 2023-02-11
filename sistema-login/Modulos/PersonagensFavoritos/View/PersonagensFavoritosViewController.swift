//
//  PersonagensFavoritosViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 28/12/22.
//

import UIKit

class PersonagensFavoritosViewController: UIViewController {
    
    // MARK: - Atributos
    private var listaDePersonagensFavoritos: [Personagem] = []
    
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
    private lazy var personagensFavoritosView: PersonagensFavoritosView = {
        let view = PersonagensFavoritosView()
        return view
    }()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.personagensFavoritosView
        
        self.personagensFavoritosView.getListaDePersonagensTableView().delegate = self
        self.personagensFavoritosView.getListaDePersonagensTableView().dataSource = self
        
        self.buscaPersonagensFavoritosDoUsuario()
        
        self.verificaQuantosPersonagensExistemParaConfigurarAVisualizacao()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Funcoes
    private func buscaPersonagensFavoritosDoUsuario() -> Void {
        let alertas = Alerta(viewController: self)
        
        guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else {
            alertas.criaAlerta(mensagem: "Erro interno! Favor tentar novamente!")
            return
        }
        
        let personagensFavoritosController = PersonagensFavoritosController(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let buscadorDePersonagensFavoritos = BuscadorDePersonagensFavoritosSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let buscaDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        guard let listaDePersonagens = personagensFavoritosController.buscaTodosOsPersonagensFavoritosDoUsuario(
            nickNameUsuario: nickNameDoUsuario,
            buscadorDePersonagensFavoritos: buscadorDePersonagensFavoritos,
            buscadorDeDadosDoUsuario: buscaDadosDoUsuario
        ) else {
            alertas.criaAlerta(mensagem: "Erro ao buscar personagens")
            self.listaDePersonagensFavoritos = []
            return
        }
        
        self.listaDePersonagensFavoritos = listaDePersonagens
    }
    
    private func verificaQuantosPersonagensExistemParaConfigurarAVisualizacao() -> Void {
        if self.listaDePersonagensFavoritos.count == 0 {
            self.personagensFavoritosView.configComponentesQuandoNaoHouverPersonagens()
            return
        }
        
        self.personagensFavoritosView.configComponentesComListaDePersonagens()
    }
    
    private func acoesQuandoOBotaoRemoverPersonagemForClicado(
        personagem: Personagem,
        indice: IndexPath
    ) -> Void
    {
        let alertas = Alerta(viewController: self)
    
        guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else {
            alertas.criaAlerta(mensagem: "Erro ao remover personagem")
            return
        }
        
        let buscadorDeDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let removePersonagemFavorito = RemovePersonagemDosFavoritosSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let personagensFavoritosController = PersonagensFavoritosController(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let personagemFoiRemovido = personagensFavoritosController.removePersonagemDosFavoritosDoUsuario(
            personagem: personagem,
            nickNameDoUsuario: nickNameDoUsuario,
            buscadorDeDadosDoUsuario: buscadorDeDadosDoUsuario,
            removePersonagemFavorito: removePersonagemFavorito
        )
        
        if !personagemFoiRemovido {
            alertas.criaAlerta(mensagem: "Erro ao remover personagem")
            return
        }
        
        self.listaDePersonagensFavoritos.remove(at: indice.row)
        self.personagensFavoritosView.getListaDePersonagensTableView().reloadData()
        
        if self.listaDePersonagensFavoritos.count == 0 {
            self.personagensFavoritosView.configComponentesQuandoNaoHouverPersonagens()
        }

    }

}

// MARK: - Extensoes
extension PersonagensFavoritosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaDePersonagensFavoritos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.listaDePersonagensFavoritos[indexPath.row].getNomePersonagem()
        cell.tintColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertas = Alerta(viewController: self)
        
        let personagem = self.listaDePersonagensFavoritos[indexPath.row]
        
        let mensagem = "\nAltura: \(personagem.getAlturaPersonagem())" +
                        "\n\nPeso: \(personagem.getPesoPersonagem())" +
                        "\n\nCor dos olhos: \(personagem.getCorDosOlhosPersonagem())" +
                        "\n\nAno de nascimento: \(personagem.getAnoNascimentoPersonagem())" +
                        "\n\nGênero: \(personagem.getGeneroPersonagem())"

        alertas.criaAlertaPersonalizadoParaExclusao(
            titulo: personagem.getNomePersonagem(),
            mensagem: mensagem,
            handler: { _ in
                self.acoesQuandoOBotaoRemoverPersonagemForClicado(
                    personagem: personagem,
                    indice: indexPath
                )
            }
        )
    }
}
