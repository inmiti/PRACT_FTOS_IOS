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
    @IBOutlet weak var transformationButton: UIButton!
    
//   MARK: Variables
    private let heroe: Hero
    private let model = NetworkModel()
    private var transformations: [Transformation] = []
    
    init(heroe: Hero) {
        self.heroe = heroe
        super.init(nibName: nil, bundle: nil)
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
    
    // Mostrar o esconder transformationsButton:
    model.getTransformations(for: heroe) { [weak self] result in
        switch result {
        case .success(let transformationsList):
            self?.transformations = transformationsList
            DispatchQueue.main.async {
                if self?.transformations != [] {
                    self?.transformationButton.isHidden = false
                } else {
                    self?.transformationButton.isHidden = true
                }
            }
        case .failure(let error):
            print("Error: \(error)")
        }
    }
}
    //MARK: - Actions
    @IBAction func TransformationsButton(_ sender: Any) {
            let transfViewController = TransfViewController(heroe: self.heroe)
            navigationController?.show(transfViewController, sender: nil)
        }
    }
    

    


