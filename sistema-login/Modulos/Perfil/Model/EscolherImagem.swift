//
//  EscolherImagem.swift
//  sistema-login
//
//  Created by Leonardo Leite on 02/01/23.
//

import UIKit

class EscolherImagem: NSObject {
    
    // MARK: - Atributos
    private let viewController: UIViewController
    private var selecionador = UIImagePickerController()
    
    private var alerta = UIAlertController(
        title: "Escolha uma opção",
        message: nil,
        preferredStyle: .alert
    )
    
    private var retornoSelecionador : ((UIImage, URL) -> ())?;
    
    // MARK: - Inicializadores
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Funcoes
    func selecionarImagem(
        _ retorno: @escaping ((UIImage, URL) -> ())
    ) -> Void
    {
        self.retornoSelecionador = retorno
        
        //Cria uma acao que chama o metodo "openCamera"
        let camera = UIAlertAction(title: "Câmera", style: .default) { (UIAlertAction) in
            self.abrirCamera()
        }
        
        let galeria = UIAlertAction(title: "Galeria", style: .default) { (UIAlertAction) in
            self.abrirGaleria()
        }

        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel)

        /* Declara que o novo delegate do selecionador são os métodos
        imagePickerControllerDidCancel e o imagePickerController que
        serão criados abaixo */
        self.selecionador.delegate = self

        // Adiciona as ações ao alerta.
        self.alerta.addAction(camera)
        self.alerta.addAction(galeria)
        self.alerta.addAction(cancelar)

        self.alerta.popoverPresentationController?.sourceView = self.viewController.view
        self.viewController.present(alerta, animated: true, completion: nil)
        
    }
    
    func abrirCamera() {
        alerta.dismiss(animated: true, completion: nil)

        //Aqui verificamos se temos a permissão para acessar a câmera
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            
            //Define o tipo que queremos selecionar como a câmera
            self.selecionador.sourceType = .camera
            //Vai para a tela da câmera
            
            self.viewController.present(selecionador, animated: true, completion: nil)
            return
        }
        
        let alerta = UIAlertController(
            title: "Desculpe",
            message: "Não foi possível acessar a câmera!",
            preferredStyle: .actionSheet
        )
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alerta.addAction(cancelar)
        
        self.viewController.present(alerta, animated: true, completion: nil)
        
    }

    func abrirGaleria(){
        
        self.alerta.dismiss(animated: true, completion: nil)

        self.selecionador.sourceType = .photoLibrary
        
        //Vai para a tela da galeria
        self.viewController.present(selecionador, animated: true, completion: nil)
    }
    
}

// MARK: - Extensoes
extension EscolherImagem: UIImagePickerControllerDelegate,
                          UINavigationControllerDelegate
{
    //Método chamado quando a pessoa cancela a escolha
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Desfaz a tela da Galeria que foi gerada
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Metodo chamado quando a pessoa escolhe uma imagem
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Desfaz a tela da Galeria que foi gerada
        picker.dismiss(animated: true, completion: nil)
        
        //Verifica se o arquivo aberto é realmente uma imagem
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Esperava-se uma imagem, mas foi dado o seguinte: \(info)")
        }
        
//        guard let pathImagem = info[.imageURL] as? URL else {
////            fatalError("Esperava-se um path, mas foi dado o seguinte: \(info)")
//        }
        
        let pathImagem = URL(string: "Alo")!
        
        //Retorna o callback da função principal
        self.retornoSelecionador?(image, pathImagem)
    }
}
