//
//  RecuperacaoDeSenhaView.swift
//  sistema-login
//
//  Created by Leonardo Leite on 22/11/22.
//

import UIKit

class RecuperacaoDeSenhaView: UIView {

    // MARK: - Componentes
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "BGLogin")
        return imageView
    }()
    
    private lazy var tituloRecuperaSenhaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Recuperar senha"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "E-mail"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
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
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(
            string: "Informe seu e-mail",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)
            ]
        )
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private lazy var buscarUsuarioButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Buscar usuário", for: .normal)
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
    
    private lazy var novaSenhaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nova senha (mínimo 8 dígitos)"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var novaSenhaTextField: UITextField = {
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
            string: "Informe sua nova senha",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)
            ]
        )
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private lazy var repeticaoDaNovaSenhaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Digite a senha novamente"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var repeticaoDaNovaSenhaTextField: UITextField = {
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
            string: "Informe a senha novamente",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)
            ]
        )
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private lazy var alterarSenhaButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Alterar senha", for: .normal)
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
        self.configsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurar componentes
    public func configurarComponentesNecessariosParaRedefinicaoDaSenha() -> Void {
        self.ocultaComponenteBuscarUsuarioButton()
        self.exibeComponentesRedefineSenha()
        
        self.emailTextField.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            self.linhaDeSeparacaoView.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 30),
            self.linhaDeSeparacaoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.linhaDeSeparacaoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.linhaDeSeparacaoView.heightAnchor.constraint(equalToConstant: 1),
            
            self.novaSenhaLabel.topAnchor.constraint(equalTo: self.linhaDeSeparacaoView.bottomAnchor, constant: 30),
            self.novaSenhaLabel.leadingAnchor.constraint(equalTo: self.emailLabel.leadingAnchor),
            
            self.novaSenhaTextField.topAnchor.constraint(equalTo: self.novaSenhaLabel.bottomAnchor, constant: 5),
            self.novaSenhaTextField.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.novaSenhaTextField.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.novaSenhaTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.repeticaoDaNovaSenhaLabel.topAnchor.constraint(equalTo: self.novaSenhaTextField.bottomAnchor, constant: 10),
            self.repeticaoDaNovaSenhaLabel.leadingAnchor.constraint(equalTo: self.emailLabel.leadingAnchor),
            
            self.repeticaoDaNovaSenhaTextField.topAnchor.constraint(equalTo: self.repeticaoDaNovaSenhaLabel.bottomAnchor, constant: 5),
            self.repeticaoDaNovaSenhaTextField.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.repeticaoDaNovaSenhaTextField.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.repeticaoDaNovaSenhaTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.alterarSenhaButton.topAnchor.constraint(equalTo: self.repeticaoDaNovaSenhaTextField.bottomAnchor, constant: 20),
            self.alterarSenhaButton.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.alterarSenhaButton.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.alterarSenhaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func ocultaComponenteBuscarUsuarioButton() -> Void {
        self.buscarUsuarioButton.isHidden = true
    }
    
    private func ocultaComponentesExibicaoRedefineSenha() -> Void {
        self.linhaDeSeparacaoView.isHidden = true
        self.novaSenhaLabel.isHidden = true
        self.novaSenhaTextField.isHidden = true
        self.repeticaoDaNovaSenhaLabel.isHidden = true
        self.repeticaoDaNovaSenhaTextField.isHidden = true
        self.alterarSenhaButton.isHidden = true
    }
    
    private func exibeComponentesRedefineSenha() -> Void {
        self.linhaDeSeparacaoView.isHidden = false
        self.novaSenhaLabel.isHidden = false
        self.novaSenhaTextField.isHidden = false
        self.repeticaoDaNovaSenhaLabel.isHidden = false
        self.repeticaoDaNovaSenhaTextField.isHidden = false
        self.alterarSenhaButton.isHidden = false
    }
    
    // MARK: - Funcoes
    public func getEmailDoUsuario() -> String? {
        return self.emailTextField.text
    }
    
    public func getBuscarUsuarioButton() -> UIButton {
        return self.buscarUsuarioButton
    }
    
    public func getNovaSenha() -> String? {
        return self.novaSenhaTextField.text
    }
    
    public func getRepeticaoNovaSenha() -> String? {
        return self.repeticaoDaNovaSenhaTextField.text
    }
    
    public func getAlterarSenhaButton() -> UIButton {
        return self.alterarSenhaButton
    }
    
    // MARK: - Constraints
    private func configsConstraints() -> Void {
        self.addSubview(self.backgroundImageView)
        self.addSubview(self.tituloRecuperaSenhaLabel)
        self.addSubview(self.emailLabel)
        self.addSubview(self.emailTextField)
        
        self.addSubview(self.buscarUsuarioButton)
        
        self.addSubview(self.linhaDeSeparacaoView)
        self.addSubview(self.novaSenhaLabel)
        self.addSubview(self.novaSenhaTextField)
        self.addSubview(self.repeticaoDaNovaSenhaLabel)
        self.addSubview(self.repeticaoDaNovaSenhaTextField)
        self.addSubview(self.alterarSenhaButton)
        self.ocultaComponentesExibicaoRedefineSenha()
        
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.tituloRecuperaSenhaLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.tituloRecuperaSenhaLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.emailLabel.topAnchor.constraint(equalTo: self.tituloRecuperaSenhaLabel.bottomAnchor, constant: 30),
            self.emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            self.emailTextField.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 5),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.buscarUsuarioButton.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 20),
            self.buscarUsuarioButton.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.buscarUsuarioButton.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.buscarUsuarioButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
