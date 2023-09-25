//
//  NetworkModel.swift
//  Superheroes
//
//  Created by ibautista on 25/9/23.
//

import Foundation

final class NetworkModel {
    enum NetworkError: Error {
        case unknown
        case malformedUrl
        case deCodingFailed
        case noData
        case statusCode(code: Int?)
    }
    
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    
    func login(
        user:String,
        password: String,
        completion: @escaping(String?, NetworkError?) -> Void
    ){
        var components = baseComponents
        components.path = "/api/auth/login"
        guard let url = components.url else {
            completion(nil, .malformedUrl)
            return
        }
        
        let loginString = String(format: "%@:%@", user, password) // user:password
        guard let loginData = loginString.data(using: .utf8) else {
            completion(nil, .deCodingFailed)
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(nil, .unknown)
                return
            }
            guard let data else {
                completion(nil, .noData)
                return
            }
            let urlResponse = (response as? HTTPURLResponse)
            let statusCode = urlResponse?.statusCode
            
            guard statusCode == 200 else {
                completion(nil, .statusCode(code: statusCode))
                return
            }
            guard let token = String(data: data, encoding: .utf8) else {
                completion(nil, .deCodingFailed)
                return
            }
            completion(token, nil)
        }
        task.resume()
    }
    
    func getHeroes(completion: ([Hero], NetworkError) -> Void) {
        var components = baseComponents
        components.path = "/api/heros/all"  // construimos url con path
        
        guard let url = components.url else {   //comprobamos que la url está ok, en ese caso da un array vacío
            completion([], .malformedUrl)       // si no está bien formada la url pasamos el error
            return
        }
        
        // para crear el body que espera la api: name: "" para poder obtener todos los heroes
        var urlComponents = URLComponents()   //Me ayuda a construir la url
        urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]  // propiedad queryItems va a ser un array de un tipo urlqueryitem, el cual le damos el body que espera la api
        
        var request = URLRequest(url: URL(string:"")!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
        }
    }
    
}
