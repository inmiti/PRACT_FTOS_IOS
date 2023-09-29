//
//  DetailViewController.swift
//  Superheroes
//
//  Created by ibautista on 28/9/23.
//

import UIKit

class DetailViewController: UIViewController {

//    MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var HeroName: UILabel!
    
    @IBOutlet weak var HeroDescription: UILabel!
    
//   MARK: Variables
    private let heroe: String
    private let descripcion: String = "Este es el mejor de todos"
    
    init(heroe: String) {   //para pasar el modelo de heroe al viewControler, ceamos metodo inicializador
        self.heroe = heroe
//        self.description = description
        super.init(nibName: nil, bundle: nil)  // el sabe el viewController que es DetailViewController, el paquete tambien lo sabe
        
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = heroe
        HeroName.text = heroe
        HeroDescription.text = descripcion
        
        guard let url = URL(string: "https://assets-prd.ignimgs.com/2022/01/14/gameofthrones-allseasons-sq-1642120207458.jpg")else {
            return
        }
        imageView.setImage(for: url)

    }
//MARK: - Actions
//    @IBAction func transformationButton(_ sender: Any) {
//    }
    
   

}
