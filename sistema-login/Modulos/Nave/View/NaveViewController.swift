//
//  NaveViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class NaveViewController: UIViewController {
    
    // MARK: - View
    private lazy var naveView: NaveView = {
        let view = NaveView()
        return view
    }()

    // MARK: - Atributos
    private var animacao: Animacao?
    private var nave: Nave?
    
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
        self.view = self.naveView
        
        self.naveView.getBotaoGerarNave().addTarget(
            self,
            action: #selector(acaoBotaoGerarNave(_:)),
            for: .touchUpInside
        )
        
        self.naveView.getAdicionarAosFavoritosButton().addTarget(
            self,
            action: #selector(acaoBotaoAdicionarAosFavoritos(_:)),
            for: .touchUpInside
        )
        
        self.naveView.getDadosNaveTableView().delegate = self
        self.naveView.getDadosNaveTableView().dataSource = self
        
        self.animacao = Animacao(view: self.naveView)
    }
    
    // MARK: - Actions
    @objc private func acaoBotaoGerarNave(_ sender: UIButton) -> Void {
        guard let animacao = self.animacao else { return }
        
        let alertas = Alerta(viewController: self)
        
        self.naveView.execucaoQuandoOBotaoAdicionarAosFavoritosForDesmarcado()
        
        self.naveView.exibeComponentesCaracteristicasDaNave()
        
        animacao.iniciarAnimacao()
        
        let naveController = NaveController()
        
        let requisicoesSWAPI = RequisicoesStarWarsAPI()
        
        naveController.gerarNave(requisicoesSWAPI: requisicoesSWAPI) { nave in
            self.nave = nave
            let dadosNave = nave.getListaComDadosDaNave()
            self.adicionaOsDadosDaNaveAsLinhasDaTableView(dadosNave)
            animacao.pararAnimacao()
            
            guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else {
                alertas.criaAlerta(titulo: "Desculpe", mensagem: "No momento não é possível utilizar a funcionalidade favoritos")
                return
            }
            
            let jaEstaFavoritado = self.verificaSeNaveJaEstaFavoritada(
                nave: nave,
                nickName: nickNameDoUsuario
            )
            
            if jaEstaFavoritado {
                self.naveView.execucaoQuandoUmaNaveForAdicionadaAosFavoritos()
            }
            
        } fracasso: {
            let alerta = Alerta(viewController: self)
            self.retornaViewPraEstadoInicialEmCasoDeErroAoBuscarNave(alerta)
            animacao.pararAnimacao()
        }
    }
    
    @objc private func acaoBotaoAdicionarAosFavoritos(_ sender: UIButton) -> Void {
        let alerta = Alerta(viewController: self)
        
        guard let nave = self.nave else {
            alerta.criaAlerta(mensagem: "Erro interno! Favor tentar novamente!")
            return
        }
        
        guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else {
            alerta.criaAlerta(mensagem: "Erro interno! Favor tentar novamente!")
            return
        }
        
        let buscadorDeDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let naveJaEstaFavoritada = self.verificaSeNaveJaEstaFavoritada(
            nave: nave,
            nickName: nickNameDoUsuario
        )
        
        let naveController = NaveController()
        
        if naveJaEstaFavoritada {
            let removeNaveDosFavoritos = RemoveNaveDosFavoritosSQLite(
                instanciaDoBanco: self.instanciaDoBanco
            )
            
            let naveFoiRemovida = naveController.removerNaveDosFavoritos(
                nave: nave,
                nickNameDoUsuario: nickNameDoUsuario,
                buscadorDeDadosDoUsuario: buscadorDeDadosDoUsuario,
                removeNaveDosFavoritos: removeNaveDosFavoritos
            )
            
            if !naveFoiRemovida {
                alerta.criaAlerta(mensagem: "Erro ao remover nave!")
                return
            }
            
            alerta.criaAlerta(
                titulo: "Sucesso",
                mensagem: "\(nave.getNome()) foi removido com sucesso de seus favoritos"
            )
            
            self.naveView.execucaoQuandoOBotaoAdicionarAosFavoritosForDesmarcado()
            return
        
        }
        
        let adicionaAosFavoritos = SalvarNaveFavoritaSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let naveFoiSalva = naveController.adicionarNaveAosFavoritos(
            nave,
            adicionaAosFavoritos: adicionaAosFavoritos,
            buscaDadosDoUsuario: buscadorDeDadosDoUsuario,
            nickNameDoUsuario: nickNameDoUsuario
        )
        
        if !naveFoiSalva {
            alerta.criaAlerta(mensagem: "Erro ao favoritar nave!")
            return
        }
        
        alerta.criaAlerta(titulo: "Sucesso", mensagem: "Nave adicionada aos favoritos")
        
        print("----------------------------")
        Crud().exibirTodosOsDadosDasNaves(db: self.instanciaDoBanco)
        Crud().exibeTodosOsUsuariosSalvos(instanciaDoBanco: self.instanciaDoBanco)
        print("----------------------------")
        
        self.naveView.execucaoQuandoUmaNaveForAdicionadaAosFavoritos()
    }
    
    private func verificaSeNaveJaEstaFavoritada(
        nave: Nave,
        nickName: String
    ) -> Bool
    {
        let naveController = NaveController()
        
        let buscadorDeDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let verificadorDeNavesSalvasPorUsuario = VerificadorDeNavesJaAdicionadasAUmUsuarioSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let naveJaEstaFavoritada = naveController.verificaSeNaveJaEstaFavoritada(
            nave: nave,
            nickName: nickName,
            verificadorDeNavesSalvasPorUsuario: verificadorDeNavesSalvasPorUsuario,
            buscadorDeDadosDoUsuario: buscadorDeDadosDoUsuario
        )
        
        return naveJaEstaFavoritada
    }
    
    // MARK: - Funcoes
    private func adicionaOsDadosDaNaveAsLinhasDaTableView(_ caracteristicasDaNave: [String]) -> Void {
        for indice in 0...5 {
            self.naveView.getDadosNaveTableView().cellForRow(at: IndexPath(item: indice, section: 0))?.textLabel?.text = caracteristicasDaNave[indice]
        }
    }
    
    private func retornaViewPraEstadoInicialEmCasoDeErroAoBuscarNave(_ controladorAlertas: Alerta) -> Void {
        controladorAlertas.criaAlerta(mensagem: "Erro ao gerar nave! Tenta novamente")
        
        self.naveView.retornaComponentesDaViewPraEstadoInicial()
    }

}

// MARK: - Extensoes
extension NaveViewController: UITableViewDelegate, UITableViewDataSource {
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

}
