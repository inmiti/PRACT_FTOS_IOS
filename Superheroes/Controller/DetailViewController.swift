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

    
//   MARK: Variables
    private let heroe: Hero
//    private let name: String
//    private let descripcion: String
//    private let image: URL
    
    init(heroe: Hero) {   //para pasar el modelo de heroe al viewControler, ceamos metodo inicializador
        self.heroe = heroe
        super.init(nibName: nil, bundle: nil)  // el sabe el viewController que es DetailViewController, el paquete tambien lo sabe
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = heroe.name
        HeroName.text = heroe.name
        HeroDescription.text = heroe.description
        imageView.setImage(for: heroe.photo)

    }
    
    //MARK: - Actions
    @IBAction func TransformationsButton(_ sender: Any) {
        DispatchQueue.main.async {
            let transfViewController = TransfViewController(heroe: self.heroe)
            //            let viewControllers:[UIViewController] = [transfViewController]
//            self.navigationController?.setViewControllers([transfViewController], animated: true)
            self.navigationController?.show(transfViewController, sender: nil)

        }
        }
    }
    


