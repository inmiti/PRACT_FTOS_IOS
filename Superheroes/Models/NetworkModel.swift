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
        case noToken
    }
    
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    private var token: String?
    
    func login(
        user:String,
        password: String,
        completion: @escaping(Result<String, NetworkError>) -> Void
    ){
        var components = baseComponents
        components.path = "/api/auth/login"
        guard let url = components.url else {
            completion(.failure(.malformedUrl))
            return
        }
        let loginString = String(format: "%@:%@", user, password) // user:password
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(.deCodingFailed))
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil else {
                completion(.failure(.unknown))
                return
            }
            guard let data else {
                completion(.failure(.noData) )
                return
            }
            let urlResponse = (response as? HTTPURLResponse)
            let statusCode = urlResponse?.statusCode
            
            guard statusCode == 200 else {
                completion(.failure(.statusCode(code: statusCode)))
                return
            }
            guard let token = String(data: data, encoding: .utf8) else {
                completion(.failure(.deCodingFailed))
                return
            }
            completion(.success(token))
            self?.token = token
        }
        task.resume()
    }
    
    func getHeroes(token: String,
                   completion: @escaping (Result<[Hero], NetworkError>) -> Void) {
        
        var components = baseComponents
        components.path = "/api/heros/all"  // construimos url con path
        
        guard let url = components.url else {   //comprobamos que la url está ok, en ese caso da un array vacío
            completion(.failure(.malformedUrl))       // si no está bien formada la url pasamos el error
            return
        }
        /*guard let token else {  // Comprobación de que hay un token, si no lo hubiera da un error.
            completion([],.noToken)
            return
        }*/
        
        var urlComponents = URLComponents()   //Me ayuda a construir la url
        urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]  // propiedad queryItems va a ser un array de un tipo urlqueryitem, el cual le damos el body que espera la api: name: "" para poder obtener todos los heroes
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"  //Le damos el tipo de metodo, en nuestra api es un POST
        request.httpBody = urlComponents.query?.data(using: .utf8) // httpBody espera un data, por eso le pasamos .data query hace composicion de todas las query pasadas, en nuestro caso es solo 1
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")// Pasar header a nuestra request para autentificarnos
        let task = URLSession.shared.dataTask(with: request) { data, response, error in  //Obtener datos de la api
            guard error == nil else {  //Comprobamos que no hay errores
                completion(.failure(.unknown) )
                return
            }
            guard let data else {  //Comprobamos que hay data
                completion(.failure(.noData))
                return
            }
            guard let heroes = try? JSONDecoder().decode([Hero].self, from: data) else {   // vamos a decodificar nuestro array de heroes desde el objeto data
                completion(.failure(.deCodingFailed))
                return
            }
            completion(.success(heroes))
        }
        task.resume()
    }
    
    func getTransformations(for hero: Hero, completion: (Result<[Transformation], NetworkError>) -> Void){
        
    }
    
    
}
