//
//  PerfilView.swift
//  sistema-login
//
//  Created by Leonardo Leite on 02/12/22.
//

import UIKit

class PerfilView: UIView {

    // MARK: - Componentes
    private lazy var perfilLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Perfil"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private lazy var fotoDePerfilImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 10
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.image = UIImage(systemName: "person.circle.fill")
        return imageView
    }()
    
    private lazy var botaoAdicionarImagemAoPerfil: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        return button
    }()
    
    private lazy var nickUsuarioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var opcoesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 15
        tableView.layer.borderColor = UIColor.white.cgColor
        tableView.backgroundColor = .black
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        tableView.separatorInset = .zero
        tableView.isUserInteractionEnabled = true
        tableView.layer.borderWidth = 3
        tableView.rowHeight = 60
        return tableView
    }()
    
    private lazy var botaoSairButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sair do app", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0), for: .normal)
        return button
    }()
    
    private lazy var apagarContaButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Apagar sua conta", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0), for: .normal)
        return button
    }()
    
    // MARK: - Inicializadores
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .darkGray
        
        self.configsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcoes
    public func getFotoDePerfilImageView() -> UIImageView {
        return self.fotoDePerfilImageView
    }
    
    public func getBotaoAdicionarImagemAoPerfil() -> UIButton {
        return self.botaoAdicionarImagemAoPerfil
    }
    
    public func getNickUsuarioLabel() -> UILabel {
        return self.nickUsuarioLabel
    }
    
    public func getOpcoesTableView() -> UITableView {
        return self.opcoesTableView
    }
    
    public func getBotaoSairButton() -> UIButton {
        return self.botaoSairButton
    }
    
    public func getApagarContaButton() -> UIButton {
        return self.apagarContaButton
    }
    
    // MARK: - Config constraints
    private func configsConstraints() -> Void {
        self.addSubview(self.perfilLabel)
        self.addSubview(self.fotoDePerfilImageView)
        self.addSubview(self.botaoAdicionarImagemAoPerfil)
        self.addSubview(self.nickUsuarioLabel)
        self.addSubview(self.opcoesTableView)
        self.addSubview(self.botaoSairButton)
        self.addSubview(self.apagarContaButton)
        
        NSLayoutConstraint.activate([
            self.perfilLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.perfilLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            self.fotoDePerfilImageView.topAnchor.constraint(equalTo: self.perfilLabel.bottomAnchor, constant: 10),
            self.fotoDePerfilImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.fotoDePerfilImageView.widthAnchor.constraint(equalToConstant: 100),
            self.fotoDePerfilImageView.heightAnchor.constraint(equalToConstant: 100),
   
            self.botaoAdicionarImagemAoPerfil.bottomAnchor.constraint(equalTo: self.fotoDePerfilImageView.bottomAnchor, constant: -10),
            self.botaoAdicionarImagemAoPerfil.leadingAnchor.constraint(equalTo: self.fotoDePerfilImageView.trailingAnchor, constant: 10),
            self.botaoAdicionarImagemAoPerfil.heightAnchor.constraint(equalToConstant: 40),
            self.botaoAdicionarImagemAoPerfil.widthAnchor.constraint(equalToConstant: 40),

            self.nickUsuarioLabel.topAnchor.constraint(equalTo: self.fotoDePerfilImageView.bottomAnchor, constant: 5),
            self.nickUsuarioLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.opcoesTableView.topAnchor.constraint(equalTo: self.nickUsuarioLabel.bottomAnchor, constant: 30),
            self.opcoesTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.opcoesTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.opcoesTableView.heightAnchor.constraint(equalToConstant: 180),
            
            self.botaoSairButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            self.botaoSairButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.apagarContaButton.topAnchor.constraint(equalTo: self.botaoSairButton.bottomAnchor, constant: 30),
            self.apagarContaButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        
        ])
    }

}
