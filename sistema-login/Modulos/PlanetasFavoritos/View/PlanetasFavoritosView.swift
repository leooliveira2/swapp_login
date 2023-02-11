//
//  PlanetasFavoritosView.swift
//  sistema-login
//
//  Created by Leonardo Leite on 29/12/22.
//

import UIKit

class PlanetasFavoritosView: UIView {
    
    // MARK: - Componentes
    private lazy var semPlanetaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sua lista de planetas esta vazia!"
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
    
    private lazy var planetasFavoritosLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Planetas favoritos"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    private lazy var listaDePlanetasTableView: UITableView = {
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
        self.safeAreaLayoutGuide.owningView?.backgroundColor = .systemMint
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcoes
    public func getListaDePlanetasTableView() -> UITableView {
        return self.listaDePlanetasTableView
    }
    
    // MARK: - Config componentes
    public func configComponentesQuandoNaoHouverPlanetas() -> Void {
        self.planetasFavoritosLabel.removeFromSuperview()
        self.listaDePlanetasTableView.removeFromSuperview()
        self.addSubview(self.semPlanetaLabel)
        
        NSLayoutConstraint.activate([
            self.semPlanetaLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.semPlanetaLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.semPlanetaLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.semPlanetaLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    public func configComponentesComListaDePlanetas() -> Void {
        self.addSubview(self.planetasFavoritosLabel)
        self.addSubview(self.listaDePlanetasTableView)
        
        NSLayoutConstraint.activate([
            self.planetasFavoritosLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.planetasFavoritosLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.planetasFavoritosLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.listaDePlanetasTableView.topAnchor.constraint(equalTo: self.planetasFavoritosLabel.bottomAnchor),
            self.listaDePlanetasTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.listaDePlanetasTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.listaDePlanetasTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
