//
//  LoginView.swift
//  sistema-login
//
//  Created by Leonardo Leite on 07/11/22.
//

import UIKit

class LoginView: UIView {
    
    // MARK: - Componentes
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "BGLogin")
        return imageView
    }()
    
    private lazy var tituloLoginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1.0)
        textField.clipsToBounds = true // pra q serve
        textField.attributedPlaceholder = NSAttributedString(
            string: "Digite seu email aqui",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)
            ]
        )
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private lazy var senhaTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1.0)
        textField.clipsToBounds = true // pra q serve
        textField.attributedPlaceholder = NSAttributedString(
            string: "Digite sua senha aqui",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)
            ]
        )
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private lazy var recuperarSenhaButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Esqueceu sua senha?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor(red: 95/255, green: 158/255, blue: 160/255, alpha: 1.0), for: .normal)
        return button
    }()
    
    private lazy var entrarButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0), for: .normal)
        button.backgroundColor = UIColor(red: 47/255, green: 79/255, blue: 79/255, alpha: 1.0)
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var linhaDeSeparacaoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var aindaNaoTemContaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ainda não tem uma conta?"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var cadastrarButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clique aqui para cadastrar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0), for: .normal)
        button.backgroundColor = UIColor(red: 47/255, green: 79/255, blue: 79/255, alpha: 1.0)
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Inicializadores
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcoes
    public func getBotaoRecuperarSenha() -> UIButton {
        return self.recuperarSenhaButton
    }
    
    public func getBotaoDeEntrar() -> UIButton {
        return self.entrarButton
    }
    
    public func getBotaoDeCadastro() -> UIButton {
        return self.cadastrarButton
    }
    
    public func getEmailDoUsuarioTextField() -> UITextField {
        return self.emailTextField
    }
    
    public func getSenhaDoUsuarioTextField() -> UITextField {
        return self.senhaTextField
    }
    
    // MARK: - Config de constraints
    private func configConstraints() -> Void {
        self.addSubview(self.backgroundImageView)
        self.addSubview(self.tituloLoginLabel)
        self.addSubview(self.emailTextField)
        self.addSubview(self.senhaTextField)
        self.addSubview(self.recuperarSenhaButton)
        self.addSubview(self.entrarButton)
        self.addSubview(self.linhaDeSeparacaoView)
        self.addSubview(self.aindaNaoTemContaLabel)
        self.addSubview(self.cadastrarButton)
        
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.tituloLoginLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.tituloLoginLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.emailTextField.topAnchor.constraint(equalTo: self.tituloLoginLabel.bottomAnchor, constant: 30),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.senhaTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 10),
            self.senhaTextField.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.senhaTextField.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.senhaTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.recuperarSenhaButton.topAnchor.constraint(equalTo: self.senhaTextField.bottomAnchor, constant: 10),
            self.recuperarSenhaButton.trailingAnchor.constraint(equalTo: senhaTextField.trailingAnchor),
            
            self.entrarButton.topAnchor.constraint(equalTo: self.recuperarSenhaButton.bottomAnchor, constant: 10),
            self.entrarButton.leadingAnchor.constraint(equalTo: self.senhaTextField.leadingAnchor),
            self.entrarButton.trailingAnchor.constraint(equalTo: self.senhaTextField.trailingAnchor),
            self.entrarButton.heightAnchor.constraint(equalToConstant: 55),
            
            self.linhaDeSeparacaoView.topAnchor.constraint(equalTo: self.entrarButton.bottomAnchor, constant: 40),
            self.linhaDeSeparacaoView.leadingAnchor.constraint(equalTo: self.entrarButton.leadingAnchor, constant: 30),
            self.linhaDeSeparacaoView.trailingAnchor.constraint(equalTo: self.entrarButton.trailingAnchor, constant: -30),
            self.linhaDeSeparacaoView.heightAnchor.constraint(equalToConstant: 1),
            
            self.aindaNaoTemContaLabel.topAnchor.constraint(equalTo: self.linhaDeSeparacaoView.bottomAnchor, constant: 40),
            self.aindaNaoTemContaLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.cadastrarButton.topAnchor.constraint(equalTo: self.aindaNaoTemContaLabel.bottomAnchor, constant: 10),
            self.cadastrarButton.leadingAnchor.constraint(equalTo: self.entrarButton.leadingAnchor),
            self.cadastrarButton.trailingAnchor.constraint(equalTo: self.entrarButton.trailingAnchor),
            self.cadastrarButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }

}

