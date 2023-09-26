//
//  LoginViewController.swift
//  Superheroes
//
//  Created by ibautista on 24/9/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    @IBAction func continueTapped(_ sender: Any) {
        let model = NetworkModel()  // inicializamos la clase
        model.login(   // inicializamos metodo login
            user: usernameTextField.text ?? "",  //por si fuese nulo damos valor por defecto ""
            password: passwordTextField.text ?? "")
        { result in
            switch result {
            case let .success(token):
                print("Token: \(token)")
//                model.getHeroes (token: token) { result in      // No hacer esto en la práctica revisar lo que puedo quitar
//                    switch result {
//                    case let .success(heroes):
//                        print("Heroes: \(heroes)")
//
//                    case let .failure(error):
//                        print("Error: \(error)")
//
//                    }
//                }
            case let .failure(error):
                print("Error: \(error)")
            }
            
        }
    }
    

}
