//
//  PersonagemViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class PersonagemViewController: UIViewController {
    
    // MARK: - View
    private lazy var personagemView: PersonagemView = {
        let view = PersonagemView()
        return view
    }()
    
    // MARK: - Atributos
    private var animacao: Animacao?
    private var personagem: Personagem?
    
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
        self.view = self.personagemView
        
        self.personagemView.getBotaoGerarPersonagem().addTarget(
            self,
            action: #selector(acaoBotaoGerarPersonagem(_:)),
            for: .touchUpInside
        )
        
        self.personagemView.getAdicionarAosFavoritosButton().addTarget(
            self,
            action: #selector(acaoBotaoAdicionarAosFavoritos(_:)),
            for: .touchUpInside
        )
        
        self.personagemView.getDadosPersonagemTableView().delegate = self
        self.personagemView.getDadosPersonagemTableView().dataSource = self
        
        self.animacao = Animacao(view: self.personagemView)
    }
    
    // MARK: - Actions
    @objc private func acaoBotaoGerarPersonagem(_ sender: UIButton) -> Void {
        guard let animacao = self.animacao else { return }
        
        let alertas = Alerta(viewController: self)
        
        self.personagemView.execucaoQuandoOBotaoAdicionarAosFavoritosForDesmarcado()
        
        self.personagemView.exibeComponentesCaracteristicasDoPersonagem()
        
        animacao.iniciarAnimacao()
        
        let personagemController = PersonagemController()
        
        let requisicoesSWAPI = RequisicoesStarWarsAPI()
        
        personagemController.gerarPersonagem(requisicoesSWAPI: requisicoesSWAPI) { personagem in
            self.personagem = personagem
            let dadosPersonagem = personagem.getListaComDadosDoPersonagem()
            self.adicionaOsDadosDoPersonagemAsLinhasDaTableView(dadosPersonagem)
            animacao.pararAnimacao()
            
            guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else {
                alertas.criaAlerta(titulo: "Desculpe", mensagem: "No momento não é possível utilizar a funcionalidade favoritos")
                return
            }
            
            let jaEstaFavoritado = self.verificaSePersonagemJaEstaFavoritado(
                personagem: personagem,
                nickName: nickNameDoUsuario
            )
            
            if jaEstaFavoritado {
                self.personagemView.execucaoQuandoUmPersonagemForAdicionadoAosFavoritos()
            }
            
        } fracasso: {
            let alerta = Alerta(viewController: self)
            self.retornaViewPraEstadoInicialEmCasoDeErroAoBuscarPersonagem(alerta)
            animacao.pararAnimacao()
        }
    }
    
    @objc private func acaoBotaoAdicionarAosFavoritos(_ sender: UIButton) -> Void {
        let alerta = Alerta(viewController: self)
        
        guard let personagem = self.personagem else {
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
        
        let personagemJaEstaFavoritado = self.verificaSePersonagemJaEstaFavoritado(
            personagem: personagem,
            nickName: nickNameDoUsuario
        )
        
        let personagemController = PersonagemController()
        
        if personagemJaEstaFavoritado {
            let removePersonagemDosFavoritos = RemovePersonagemDosFavoritosSQLite(
                instanciaDoBanco: self.instanciaDoBanco
            )
            
            let personagemFoiRemovido = personagemController.removerPersonagemDosFavoritos(
                personagem: personagem,
                nickNameDoUsuario: nickNameDoUsuario,
                buscadorDeDadosDoUsuario: buscadorDeDadosDoUsuario,
                removePersonagemDosFavoritos: removePersonagemDosFavoritos
            )
            
            if !personagemFoiRemovido {
                alerta.criaAlerta(mensagem: "Erro ao remover personagem!")
                return
            }
            
            alerta.criaAlerta(
                titulo: "Sucesso",
                mensagem: "\(personagem.getNomePersonagem()) foi removido com sucesso de seus favoritos"
            )
            
            self.personagemView.execucaoQuandoOBotaoAdicionarAosFavoritosForDesmarcado()
            return
        
        }
        
        let adicionaAosFavoritos = SalvarPersonagemFavoritoSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let personagemFoiSalvo = personagemController.adicionarPersonagemAosFavoritos(
            personagem,
            adicionaAosFavoritos: adicionaAosFavoritos,
            buscaDadosDoUsuario: buscadorDeDadosDoUsuario,
            nickNameDoUsuario: nickNameDoUsuario
        )
        
        if !personagemFoiSalvo {
            alerta.criaAlerta(mensagem: "Erro ao favoritar personagem!")
            return
        }
        
        alerta.criaAlerta(titulo: "Sucesso", mensagem: "Personagem adicionado aos favoritos")
        
        print("----------------------------")
        Crud().exibirTodosOsDadosDosPersonagens(db: self.instanciaDoBanco)
        Crud().exibeTodosOsUsuariosSalvos(instanciaDoBanco: self.instanciaDoBanco)
        print("----------------------------")
        
        self.personagemView.execucaoQuandoUmPersonagemForAdicionadoAosFavoritos()
    }
    
    private func verificaSePersonagemJaEstaFavoritado(
        personagem: Personagem,
        nickName: String
    ) -> Bool
    {
        let personagemController = PersonagemController()
        
        let buscadorDeDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let verificadorDePersonagensSalvosPorUsuario = VerificadorDePersonagensJaAdicionadosAUmUsuarioSQLite(
            instanciaDoBanco: self.instanciaDoBanco
        )
        
        let personagemJaEstaFavoritado = personagemController.verificaSePersonagemJaEstaFavoritado(
            personagem: personagem,
            nickName: nickName,
            verificadorDePersonagensSalvosPorUsuario: verificadorDePersonagensSalvosPorUsuario,
            buscadorDeDadosDoUsuario: buscadorDeDadosDoUsuario
        )
        
        return personagemJaEstaFavoritado
    }
    
    // MARK: - Funcoes
    private func adicionaOsDadosDoPersonagemAsLinhasDaTableView(_ caracteristicasDoPersonagem: [String]) -> Void {
        for indice in 0...5 {
            self.personagemView.getDadosPersonagemTableView().cellForRow(at: IndexPath(item: indice, section: 0))?.textLabel?.text = caracteristicasDoPersonagem[indice]
        }
    }
    
    private func retornaViewPraEstadoInicialEmCasoDeErroAoBuscarPersonagem(_ controladorAlertas: Alerta) -> Void {
        controladorAlertas.criaAlerta(mensagem: "Erro ao gerar personagem! Tenta novamente")
        
        self.personagemView.retornaComponentesDaViewPraEstadoInicial()
    }
}

// MARK: - Extensoes
extension PersonagemViewController: UITableViewDelegate, UITableViewDataSource {
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
