//
//  HomeViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 11/11/22.
//

import UIKit

class HomeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.setupTabBarController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupTabBarController() -> Void {
        guard let instanciaDoBanco = DBManager().openDatabase(
            DBPath: "dados-usuarios.sqlite"
        ) else
        {
            Alerta(viewController: self).criaAlertaSemAction(
                mensagem: "Ocorreu um problema interno! Tente entrar novamente"
            )
            
            let seconds = 3.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.navigationController?.popViewController(animated: true)
            }
            return
        }
        
        let tela01 = PersonagemViewController(instanciaDoBanco: instanciaDoBanco)
        let tela02 = PlanetaViewController(instanciaDoBanco: instanciaDoBanco)
        let tela03 = NaveViewController(instanciaDoBanco: instanciaDoBanco)
        let tela04 = PerfilViewController(instanciaDoBanco: instanciaDoBanco)
        
        self.setViewControllers([tela01, tela02, tela03, tela04], animated: false)
        
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = false
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "Personagens"
        items[0].image = UIImage(systemName: "person")
        
        items[1].title = "Planetas"
        items[1].image = UIImage(systemName: "circle")
        
        items[2].title = "Naves"
        items[2].image = UIImage(systemName: "airplane")
        
        items[3].title = "Perfil"
        items[3].image = UIImage(systemName: "person.circle")
    }
                                                                                               
}
