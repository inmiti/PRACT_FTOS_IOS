//
//  SceneDelegate.swift
//  Superheroes
//
//  Created by ibautista on 28/8/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
// - Indicamos que el LoginViewController va a ser nuestro entry point
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        let window = UIWindow(windowScene: scene)
        let viewController = LoginViewController() // Creamos viewController
        window.rootViewController = viewController // Presentamos el viewController en nuestra window
        window.makeKeyAndVisible() // Hacemos visible la window
        self.window = window // Agregamos referencia, manteniendo nuestra window a esta window
    }


}

