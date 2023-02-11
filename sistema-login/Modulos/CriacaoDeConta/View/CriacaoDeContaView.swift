//
//  CriacaoDeContaView.swift
//  sistema-login
//
//  Created by Leonardo Leite on 08/11/22.
//

import UIKit

class CriacaoDeContaView: UIView {
    
    // MARK: - Componentes
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "BGLogin")
        return imageView
    }()
    
    private lazy var tituloCriarContaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Criar conta"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nickNameDoUsuarioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Apelido de usuário"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var nickNameDoUsuarioTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.autocorrectionType = .no
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1.0)
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(
            string: "Digite seu apelido de usuário",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)
            ]
        )
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private lazy var nomeCompletoDoUsuarioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome completo"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var nomeCompletoDoUsuarioTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.autocorrectionType = .no
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1.0)
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(
            string: "Digite seu nome completo",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)
            ]
        )
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private lazy var emailDoUsuarioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "E-mail"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var emailDoUsuarioTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1.0)
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(
            string: "Digite seu e-mail",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)
            ]
        )
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private lazy var senhaDoUsuarioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Senha (mínimo 8 caracteres)"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var senhaDoUsuarioTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1.0)
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(
            string: "Digite sua senha",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)
            ]
        )
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private lazy var repeticaoDeSenhaDoUsuarioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Repetição da senha"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var repeticaoDeSenhaDoUsuarioTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1.0)
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(
            string: "Repita sua senha",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)
            ]
        )
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private lazy var criacaoDeContaButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar conta", for: .normal)
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
    public func getBotaoCriarConta() -> UIButton {
        return self.criacaoDeContaButton
    }
    
    public func getNickNameDoUsuario() -> String? {
        return self.nickNameDoUsuarioTextField.text
    }
    
    public func getNomeCompletoDoUsuario() -> String? {
        return self.nomeCompletoDoUsuarioTextField.text
    }
    
    public func getEmailDoUsuario() -> String? {
        return self.emailDoUsuarioTextField.text
    }
    
    public func getSenhaDoUsuario() -> String? {
        return self.senhaDoUsuarioTextField.text
    }
    
    public func getRepeticaoDeSenhaDoUsuario() -> String? {
        return self.repeticaoDeSenhaDoUsuarioTextField.text
    }
    
    // MARK: - Config de constraints
    private func configConstraints() -> Void {
        self.addSubview(self.backgroundImageView)
        self.addSubview(self.tituloCriarContaLabel)
        self.addSubview(self.nickNameDoUsuarioLabel)
        self.addSubview(self.nickNameDoUsuarioTextField)
        self.addSubview(self.nomeCompletoDoUsuarioLabel)
        self.addSubview(self.nomeCompletoDoUsuarioTextField)
        self.addSubview(self.emailDoUsuarioLabel)
        self.addSubview(self.emailDoUsuarioTextField)
        self.addSubview(self.senhaDoUsuarioLabel)
        self.addSubview(self.senhaDoUsuarioTextField)
        self.addSubview(self.repeticaoDeSenhaDoUsuarioLabel)
        self.addSubview(self.repeticaoDeSenhaDoUsuarioTextField)
        self.addSubview(self.criacaoDeContaButton)
        
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.tituloCriarContaLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.tituloCriarContaLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.nickNameDoUsuarioLabel.topAnchor.constraint(equalTo: self.tituloCriarContaLabel.bottomAnchor, constant: 30),
            self.nickNameDoUsuarioLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            self.nickNameDoUsuarioTextField.topAnchor.constraint(equalTo: self.nickNameDoUsuarioLabel.bottomAnchor, constant: 5),
            self.nickNameDoUsuarioTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.nickNameDoUsuarioTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.nickNameDoUsuarioTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.nomeCompletoDoUsuarioLabel.topAnchor.constraint(equalTo: self.nickNameDoUsuarioTextField.bottomAnchor, constant: 10),
            self.nomeCompletoDoUsuarioLabel.leadingAnchor.constraint(equalTo: self.nickNameDoUsuarioLabel.leadingAnchor),
            
            self.nomeCompletoDoUsuarioTextField.topAnchor.constraint(equalTo: self.nomeCompletoDoUsuarioLabel.bottomAnchor, constant: 5),
            self.nomeCompletoDoUsuarioTextField.leadingAnchor.constraint(equalTo: self.nickNameDoUsuarioTextField.leadingAnchor),
            self.nomeCompletoDoUsuarioTextField.trailingAnchor.constraint(equalTo: self.nickNameDoUsuarioTextField.trailingAnchor),
            self.nomeCompletoDoUsuarioTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.emailDoUsuarioLabel.topAnchor.constraint(equalTo: self.nomeCompletoDoUsuarioTextField.bottomAnchor, constant: 10),
            self.emailDoUsuarioLabel.leadingAnchor.constraint(equalTo: self.nickNameDoUsuarioLabel.leadingAnchor),
            
            self.emailDoUsuarioTextField.topAnchor.constraint(equalTo: self.emailDoUsuarioLabel.bottomAnchor, constant: 5),
            self.emailDoUsuarioTextField.leadingAnchor.constraint(equalTo: self.nickNameDoUsuarioTextField.leadingAnchor),
            self.emailDoUsuarioTextField.trailingAnchor.constraint(equalTo: self.nickNameDoUsuarioTextField.trailingAnchor),
            self.emailDoUsuarioTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.senhaDoUsuarioLabel.topAnchor.constraint(equalTo: self.emailDoUsuarioTextField.bottomAnchor, constant: 10),
            self.senhaDoUsuarioLabel.leadingAnchor.constraint(equalTo: self.nickNameDoUsuarioLabel.leadingAnchor),
            
            self.senhaDoUsuarioTextField.topAnchor.constraint(equalTo: self.senhaDoUsuarioLabel.bottomAnchor, constant: 5),
            self.senhaDoUsuarioTextField.leadingAnchor.constraint(equalTo: self.nickNameDoUsuarioTextField.leadingAnchor),
            self.senhaDoUsuarioTextField.trailingAnchor.constraint(equalTo: self.nickNameDoUsuarioTextField.trailingAnchor),
            self.senhaDoUsuarioTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.repeticaoDeSenhaDoUsuarioLabel.topAnchor.constraint(equalTo: self.senhaDoUsuarioTextField.bottomAnchor, constant: 10),
            self.repeticaoDeSenhaDoUsuarioLabel.leadingAnchor.constraint(equalTo: self.nickNameDoUsuarioLabel.leadingAnchor),
            
            self.repeticaoDeSenhaDoUsuarioTextField.topAnchor.constraint(equalTo: self.repeticaoDeSenhaDoUsuarioLabel.bottomAnchor, constant: 5),
            self.repeticaoDeSenhaDoUsuarioTextField.leadingAnchor.constraint(equalTo: self.nickNameDoUsuarioTextField.leadingAnchor),
            self.repeticaoDeSenhaDoUsuarioTextField.trailingAnchor.constraint(equalTo: self.nickNameDoUsuarioTextField.trailingAnchor),
            self.repeticaoDeSenhaDoUsuarioTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.criacaoDeContaButton.topAnchor.constraint(equalTo: self.repeticaoDeSenhaDoUsuarioTextField.bottomAnchor, constant: 20),
            self.criacaoDeContaButton.leadingAnchor.constraint(equalTo: self.nickNameDoUsuarioTextField.leadingAnchor),
            self.criacaoDeContaButton.trailingAnchor.constraint(equalTo: self.nickNameDoUsuarioTextField.trailingAnchor),
            self.criacaoDeContaButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
}
