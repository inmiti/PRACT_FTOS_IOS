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
        case encodingFailed
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
    private var token: String? {
        get {   // Cuando se obtiene el token...
            if let token = LocalDataModel.getToken() {
                return token
            }
            return nil
        }
        set {  // Cuando obtenemos el valor del token no nil ....
            if let token = newValue {
                LocalDataModel.save(token: token)
            }
        }
    }
    private let session: URLSession  // Creamos esta coonstante y el inicializador para poder inyectar en los test el MockURLProtocol
    init(session:URLSession = .shared) { //De forma predeterminada será URLSession.shared
        self.session = session
    }
    
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
        let task = session.dataTask(with: request) { [weak self] data, response, error in
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
    
    func getHeroes(
                   completion: @escaping (Result<[Hero], NetworkError>) -> Void) {
        
        var components = baseComponents
        components.path = "/api/heros/all"  // construimos url con path
        
        guard let url = components.url else {   //comprobamos que la url está ok, en ese caso da un array vacío
            completion(.failure(.malformedUrl))       // si no está bien formada la url pasamos el error
            return
        }
        guard let token else {  // Comprobación de que hay un token, si no lo hubiera da un error.
            completion(.failure(.noToken))
            return
        }
        
        var urlComponents = URLComponents()   //Me ayuda a construir la url
        urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]  // propiedad queryItems va a ser un array de un tipo urlqueryitem, el cual le damos el body que espera la api: name: "" para poder obtener todos los heroes
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"  //Le damos el tipo de metodo, en nuestra api es un POST
        request.httpBody = urlComponents.query?.data(using: .utf8) // httpBody espera un data, por eso le pasamos .data query hace composicion de todas las query pasadas, en nuestro caso es solo 1
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")// Pasar header a nuestra request para autentificarnos
        createTask(for: request , using: [Hero].self, completion: completion)
    }
    
    func getTransformations(for hero: Hero,
                            completion: @escaping (Result<[Transformation], NetworkError>) -> Void)
    {
        var components = baseComponents
        components.path = "/api/heros/tranformations"

        guard let url = components.url else {
            completion(.failure(.malformedUrl))
            return
        }
        
        guard let token else {
            completion(.failure(.noToken))
            return
        }
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "id", value: hero.id)]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = urlComponents.query?.data(using: .utf8)
        createTask(
            for: request,
            using: [Transformation].self,
            completion: completion)
    }
    
    func createTask<T: Decodable> (
        for request: URLRequest,
        using type: T.Type, // Importante pasar .Type para que nos de el tipo, si no lo indicamos nos da la referencia al objeto.
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let task = session.dataTask(with: request) {data, response, error in
            let result: Result<T, NetworkError>
            
            defer {
                completion(result)   // es lo ultimo, ejecuta el completion  con el .success.
            }
            guard error == nil else {
                result = .failure(.unknown)
                return
            }
            guard let data else {
                result = .failure(.noData)
                return
            }
            guard let resource = try? JSONDecoder().decode(type, from: data) else {
                result = .failure(.deCodingFailed)
                return
            }
            
            result = .success(resource)
        }
        task.resume()
        }
}
