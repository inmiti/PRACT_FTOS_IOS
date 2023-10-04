//
//  LoginViewController.swift
//  Superheroes
//
//  Created by ibautista on 24/9/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    // - MARK: Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var imageLoginView: UIImageView!
    
    // - MARK: Private let
    private let model = NetworkModel()  // inicializamos la clase
    
    // - MARK: LiveCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // - MARK: Actions
    @IBAction func continueTapped(_ sender: Any) {
        model.login(
            user: usernameTextField.text ?? "",
            password: passwordTextField.text ?? ""
        ) { [weak self ] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    let heroesviewController = HeroesViewController() // inicializamos nuestro viewController
                    self?.navigationController?.setViewControllers([heroesviewController], animated: true)   //metodo show para navegar al listado de Heroes
                }
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
