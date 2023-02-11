//
//  PersonagensFavoritosView.swift
//  sistema-login
//
//  Created by Leonardo Leite on 28/12/22.
//

import UIKit

class PersonagensFavoritosView: UIView {

    // MARK: - Componentes
    private lazy var semPersonagemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sua lista de personagens esta vazia!"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .black
        label.layer.cornerRadius = 20
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.clipsToBounds = true
        label.textColor = .white
        return label
    }()
    
    private lazy var personagensFavoritosLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Personagens favoritos"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    private lazy var listaDePersonagensTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
        return tableView
    }()
    
    // MARK: - Inicializadores
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.safeAreaLayoutGuide.owningView?.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcoes
    public func getListaDePersonagensTableView() -> UITableView {
        return self.listaDePersonagensTableView
    }
    
    // MARK: - Config componentes
    public func configComponentesQuandoNaoHouverPersonagens() -> Void {
        self.personagensFavoritosLabel.removeFromSuperview()
        self.listaDePersonagensTableView.removeFromSuperview()
        self.addSubview(self.semPersonagemLabel)
        
        NSLayoutConstraint.activate([
            self.semPersonagemLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.semPersonagemLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.semPersonagemLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.semPersonagemLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    public func configComponentesComListaDePersonagens() -> Void {
        self.addSubview(self.personagensFavoritosLabel)
        self.addSubview(self.listaDePersonagensTableView)
        
        NSLayoutConstraint.activate([
            self.personagensFavoritosLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.personagensFavoritosLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.personagensFavoritosLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.listaDePersonagensTableView.topAnchor.constraint(equalTo: self.personagensFavoritosLabel.bottomAnchor),
            self.listaDePersonagensTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.listaDePersonagensTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.listaDePersonagensTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
