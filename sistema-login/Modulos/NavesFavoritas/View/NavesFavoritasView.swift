//
//  NavesFavoritasView.swift
//  sistema-login
//
//  Created by Leonardo Leite on 29/12/22.
//

import UIKit

class NavesFavoritasView: UIView {

    // MARK: - Componentes
    private lazy var semNaveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sua lista de naves esta vazia!"
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
    
    private lazy var navesFavoritasLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Naves favoritas"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    private lazy var listaDeNavesTableView: UITableView = {
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
        self.safeAreaLayoutGuide.owningView?.backgroundColor = .systemRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcoes
    public func getListaDeNavesTableView() -> UITableView {
        return self.listaDeNavesTableView
    }
    
    // MARK: - Config componentes
    public func configComponentesQuandoNaoHouverNaves() -> Void {
        self.navesFavoritasLabel.removeFromSuperview()
        self.listaDeNavesTableView.removeFromSuperview()
        self.addSubview(self.semNaveLabel)
        
        NSLayoutConstraint.activate([
            self.semNaveLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.semNaveLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.semNaveLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.semNaveLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    public func configComponentesComListaDeNaves() -> Void {
        self.addSubview(self.navesFavoritasLabel)
        self.addSubview(self.listaDeNavesTableView)
        
        NSLayoutConstraint.activate([
            self.navesFavoritasLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.navesFavoritasLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navesFavoritasLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.listaDeNavesTableView.topAnchor.constraint(equalTo: self.navesFavoritasLabel.bottomAnchor),
            self.listaDeNavesTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.listaDeNavesTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.listaDeNavesTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
