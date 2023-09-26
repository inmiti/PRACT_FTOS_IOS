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
        { token, error in
            print("Token: \(token), error: \(error)")
            
            guard let token else {
                return
            }
            model.getHeroes (token: token) { heroes, error in
                print("Heroes: \(heroes), error: \(error)")
            }
            }
    }
    

}
