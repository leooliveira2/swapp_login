//
//  Animacao.swift
//  sistema-login
//
//  Created by Leonardo Leite on 20/12/22.
//

import UIKit

class Animacao {
    // MARK: - Atributos
    private let view: UIView
    
    private lazy var progressView: UIActivityIndicatorView = {
        let p = UIActivityIndicatorView(style: .large)
        p.translatesAutoresizingMaskIntoConstraints = false
        p.backgroundColor = .white
        p.color = .black
        p.layer.borderColor = UIColor.lightGray.cgColor
        p.layer.cornerRadius = 10
        return p
    }()
    
    // MARK: - Inicializador
    init(view: UIView) {
        self.view = view
        self.view.addSubview(self.progressView)
        self.configConstraints()
    }
    
    // MARK: - Funcoes
    public func iniciarAnimacao() -> Void {
        self.view.isUserInteractionEnabled = false
        self.view.window?.isUserInteractionEnabled = false
        self.view.addSubview(self.progressView)
        self.progressView.startAnimating()
    }
    
    public func pararAnimacao() -> Void {
        self.view.isUserInteractionEnabled = true
        self.view.window?.isUserInteractionEnabled = true
        
        self.progressView.stopAnimating()
    }
    
    // MARK: - Config constraints
    private func configConstraints() -> Void {
        NSLayoutConstraint.activate([
            self.progressView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.progressView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50),
            self.progressView.heightAnchor.constraint(equalToConstant: 60),
            self.progressView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
