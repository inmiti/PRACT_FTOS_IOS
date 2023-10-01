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
    
    @IBOutlet weak var HeroDescription: UITextView!
//    @IBOutlet weak var HeroDescription: UILabel!
    
//   MARK: Variables
    private let heroe: String
    private let descripcion: String
    private let image: URL
    
    init(heroe: String,descripcion: String, image: URL ) {   //para pasar el modelo de heroe al viewControler, ceamos metodo inicializador
        self.heroe = heroe
        self.descripcion = descripcion
        self.image = image
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
        imageView.setImage(for: image)

    }
    @IBAction func TransformationsButton(_ sender: Any) {
//        let tabBarViewController = TabBarViewController()
//        let viewControllers:[UIViewController] = [tabBarViewController]
//        navigationController?.setViewControllers(viewControllers, animated: true)
//    }
    //MARK: - Actions
//    @IBAction func transformationButton(_ sender: Any) {
    }
    
   

}
