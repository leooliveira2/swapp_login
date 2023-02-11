//
//  PlanetaViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class PlanetaViewController: UIViewController {
    
    // MARK: - View
    private lazy var planetaView: PlanetaView = {
        let view = PlanetaView()
        return view
    }()
    
    // MARK: - Atributos
    private var animacao: Animacao?
    private var planeta: Planeta?
    
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
        self.view = self.planetaView
        
        self.planetaView.getBotaoGerarPlaneta().addTarget(
            self,
            action: #selector(acaoBotaoGerarPlaneta(_:)),
            for: .touchUpInside
        )
        
        self.planetaView.getAdicionarAosFavoritosButton().addTarget(
            self,
            action: #selector(acaoBotaoAdicionarAosFavoritos(_:)),
            for: .touchUpInside
        )
        
        self.planetaView.getDadosPlanetaTableView().delegate = self
        self.planetaView.getDadosPlanetaTableView().dataSource = self
        
        self.animacao = Animacao(view: self.planetaView)

    }
    
    // MARK: - Actions
    @objc private func acaoBotaoGerarPlaneta(_ sender: UIButton) -> Void {
        guard let animacao = self.animacao else { return }
        
        let alertas = Alerta(viewController: self)
        
        self.planetaView.execucaoQuandoOBotaoAdicionarAosFavoritosForDesmarcado()
        
        self.planetaView.exibeComponentesCaracteristicasDoPlaneta()
        
        animacao.iniciarAnimacao()
        
        let planetaController = PlanetaController()
        
        let requisicoesSWAPI = RequisicoesStarWarsAPI()
        
        planetaController.gerarPlaneta(requisicoesSWAPI: requisicoesSWAPI) { planeta in
            self.planeta = planeta
            let dadosPlaneta = planeta.getListaComDadosDoPlaneta()
            self.adicionaOsDadosDoPlanetaAsLinhasDaTableView(dadosPlaneta)
            animacao.pararAnimacao()
            
            guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else {
                alertas.criaAlerta(titulo: "Desculpe", mensagem: "No momento não é possível utilizar a funcionalidade favoritos")
                return
            }
            
            let jaEstaFavoritado = self.verificaSePlanetaJaEstaFavoritado(
                planeta: planeta,
                nickName: nickNameDoUsuario
            )
            
            if jaEstaFavoritado {
                self.planetaView.execucaoQuandoUmPlanetaForAdicionadoAosFavoritos()
            }
            
        } fracasso: {
            self.retornaViewPraEstadoInicialEmCasoDeErroAoBuscarPlaneta(alertas)
            animacao.pararAnimacao()
        }
    }
    
    @objc private func acaoBotaoAdicionarAosFavoritos(_ sender: UIButton) -> Void {
        let alerta = Alerta(viewController: self)
        
        guard let planeta = self.planeta else {
            alerta.criaAlerta(mensagem: "Erro interno! Favor tentar novamente!")
            return
        }
        
        guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else {
            alerta.criaAlerta(mensagem: "Erro interno! Favor tentar novamente!")
            return
        }
        
        guard let instanciaDoBanco = DBManager().openDatabase(DBPath: "dados-usuarios.sqlite") else {
            alerta.criaAlerta(mensagem: "Erro interno! Favor tentar novamente!")
            return
        }
        
        let buscadorDeDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let planetaJaEstaFavoritado = self.verificaSePlanetaJaEstaFavoritado(
            planeta: planeta,
            nickName: nickNameDoUsuario
        )
        
        let planetaController = PlanetaController()
        
        if planetaJaEstaFavoritado {
            let removePlanetaDosFavoritos = RemovePlanetaDosFavoritosSQLite(
                instanciaDoBanco: instanciaDoBanco
            )
            
            let planetaFoiRemovido = planetaController.removerPlanetaDosFavoritos(
                planeta: planeta,
                nickNameDoUsuario: nickNameDoUsuario,
                buscadorDeDadosDoUsuario: buscadorDeDadosDoUsuario,
                removePlanetaDosFavoritos: removePlanetaDosFavoritos
            )
            
            if !planetaFoiRemovido {
                alerta.criaAlerta(mensagem: "Erro ao remover planeta!")
                return
            }
            
            alerta.criaAlerta(
                titulo: "Sucesso",
                mensagem: "\(planeta.getNome()) foi removido com sucesso de seus favoritos"
            )
            
            self.planetaView.execucaoQuandoOBotaoAdicionarAosFavoritosForDesmarcado()
            return
        
        }
        
        let adicionaAosFavoritos = SalvarPlanetaFavoritoSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let planetaFoiSalvo = planetaController.adicionarPlanetaAosFavoritos(
            planeta,
            adicionaAosFavoritos: adicionaAosFavoritos,
            buscaDadosDoUsuario: buscadorDeDadosDoUsuario,
            nickNameDoUsuario: nickNameDoUsuario
        )
        
        if !planetaFoiSalvo {
            alerta.criaAlerta(mensagem: "Erro ao favoritar planeta!")
            return
        }
        
        alerta.criaAlerta(titulo: "Sucesso", mensagem: "Planeta adicionado aos favoritos")
        
        print("----------------------------")
        Crud().exibirTodosOsDadosDosPlanetas(db: self.instanciaDoBanco)
        Crud().exibeTodosOsUsuariosSalvos(instanciaDoBanco: self.instanciaDoBanco)
        print("----------------------------")
        
        self.planetaView.execucaoQuandoUmPlanetaForAdicionadoAosFavoritos()
    }
    
    private func verificaSePlanetaJaEstaFavoritado(
        planeta: Planeta,
        nickName: String
    ) -> Bool
    {
        let planetaController = PlanetaController()
        
        let buscadorDeDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let verificadorDePlanetasSalvosPorUsuario = VerificadorDePlanetasJaAdicionadosAUmUsuarioSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let planetaJaEstaFavoritado = planetaController.verificaSePlanetaJaEstaFavoritado(
            planeta: planeta,
            nickName: nickName,
            verificadorDePlanetasSalvosPorUsuario: verificadorDePlanetasSalvosPorUsuario,
            buscadorDeDadosDoUsuario: buscadorDeDadosDoUsuario
        )
        
        return planetaJaEstaFavoritado
    }
    
    // MARK: - Funcoes
    private func adicionaOsDadosDoPlanetaAsLinhasDaTableView(_ caracteristicasDoPlaneta: [String]) -> Void {
        for indice in 0...5 {
            self.planetaView.getDadosPlanetaTableView().cellForRow(at: IndexPath(item: indice, section: 0))?.textLabel?.text = caracteristicasDoPlaneta[indice]
        }
    }
    
    private func retornaViewPraEstadoInicialEmCasoDeErroAoBuscarPlaneta(_ controladorAlertas: Alerta) -> Void {
        controladorAlertas.criaAlerta(mensagem: "Erro ao gerar planeta! Tenta novamente")
        
        self.planetaView.retornaComponentesDaViewPraEstadoInicial()
    }
}

// MARK: - Extensoes
extension PlanetaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.backgroundColor = .lightGray
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.numberOfLines = 4
        return cell
    }

    private func tableView(tableView: UITableView!, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return UITableView.automaticDimension
    }

}

