//
//  LocalDataModel.swift
//  Superheroes
//
//  Created by ibautista on 28/9/23.
//

import Foundation

struct LocalDataModel {
    
    private static let key = "SuperHeroesToken"
    
    private static let userDefaults = UserDefaults.standard  // userDefaults con singlelton
    
    static func getToken() -> String? {
        userDefaults.string(forKey: key) // Obtiene un string de la key dada
    }
    
    static func save(token: String) {
        userDefaults.set(token, forKey: key)  // Establece el valor de la key
        
    }
    
    static func deleteToken() {
        userDefaults.removeObject(forKey: key)
        
        
    }
    
}
