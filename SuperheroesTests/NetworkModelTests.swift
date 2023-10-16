//
//  NetworkModelTests.swift
//  SuperheroesTests
//
//  Created by ibautista on 28/9/23.
//

import XCTest
@testable import Superheroes

final class NetworkModelTests: XCTestCase {
    private var sut: NetworkModel!  //Instancia a testear
    
    override func setUp() {   //método para inicializar sut, se ejecuta una vez por cada test que incluyamos
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral //Creamos un URLSession y hay que pasar una configuracion. ephemeral es un singelton
        configuration.protocolClasses = [MockURLProtocol.self] //pasamos el tipo del urlProtocol, con una array, en vez de la sessión real.
        let session = URLSession(configuration: configuration)
        sut = NetworkModel(session: session) //incluimos la session para poder meter el mock, y por defecto se pone 
    }
    
    
    override func tearDown() {  //Cuando usemos setup, para borrar el estado de nuestras variables despues de cada test method en nuestro test case
        super.tearDown()
        sut = nil
    }
    
    func testLogin(){
        let expectedToken = "SomeToken"
        let someUser = "SomeUser"
        let somePassword = "SomePassword"
        
        MockURLProtocol.requestHandler = { request in
            let loginString = String(format: "%@:%@", someUser, somePassword)
            let loginData = loginString.data(using: .utf8)!
            let base64LoginString = loginData.base64EncodedString()
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"),
                           "Basic \(base64LoginString)")
            
            let data = try XCTUnwrap(expectedToken.data(using: .utf8))
            let response = try XCTUnwrap(
                HTTPURLResponse(url: URL(string: "https://dragonball.keepcoding.education")!,
                                statusCode: 200,
                                httpVersion: nil,
                                headerFields: ["Content-Type": "application/json"])
            )
            return (response, data)
        }
        
        let expectation = expectation(description: "Login success") // como hay codigo asíncrono usamos expectation
        
        sut.login(user: someUser, password: somePassword) { result in
            guard case let .success(token) = result else {
                XCTFail("Expected success but received \(result)")
                return
            }
            
            XCTAssertEqual(token, expectedToken)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetHerores() {
        let expectedHeroes = """
    [
    {
        "photo": "https://cdn.alfabetajuega.com/alfabetajuega/2020/06/Roshi.jpg?width=300",
        "name": "Maestro Roshi",
        "id": "14BB8E98-6586-4EA7-B4D7-35D6A63F5AA3",
        "description": "Es un maestro de artes marciales que tiene una escuela, donde entrenará a Goku y Krilin para los Torneos de Artes Marciales. Aún en los primeros episodios había un toque de tradición y disciplina, muy bien representada por el maestro. Pero Muten Roshi es un anciano extremadamente pervertido con las chicas jóvenes, una actitud que se utilizaba en escenas divertidas en los años 80. En su faceta de experto en artes marciales, fue quien le enseñó a Goku técnicas como el Kame Hame Ha",
        "favorite": false
    },
    {
        "photo": "https://cdn.alfabetajuega.com/alfabetajuega/2020/06/dragon-ball-satan.jpg?width=300",
        "name": "Mr. Satán",
        "id": "1985A353-157F-4C0B-A789-FD5B4F8DABDB",
        "description": "Mr. Satán es un charlatán fanfarrón, capaz de manipular a las masas. Pero en realidad es cobarde cuando se da cuenta que no puede contra su adversario como ocurrió con Androide 18 o Célula. Siempre habla más de la cuenta, pero en algún momento del combate empieza a suplicar. Androide 18 le ayuda a fingir su victoria a cambio de mucho dinero. Él acepta el trato porque no podría soportar que todo el mundo le diera la espalda por ser un fraude.",
        "favorite": false
    },
    {
        "photo": "https://cdn.alfabetajuega.com/alfabetajuega/2020/08/Krilin.jpg?width=300",
        "name": "Krilin",
        "id": "D88BE50B-913D-4EA8-AC42-04D3AF1434E3",
        "description": "Krilin lo tiene todo. Cuando aún no existían los 'memes', Krilin ya los protagonizaba. Junto a Yamcha ha sido objeto de burla por sus desafortunadas batallas en Dragon Ball Z. Inicialmente, Krilin era el mejor amigo de Goku siendo sólo dos niños que querían aprender artes marciales. El Maestro Roshi les entrena para ser dos grandes luchadores, pero la diferencia entre ambos cada vez es más evidente. Krilin era ambicioso y se ablanda con el tiempo. Es un personaje que acepta un papel secundario para apoyar el éxito de su mejor amigo Goku de una forma totalmente altruista.",
        "favorite": false
    },
    {
        "name": "Goku",
        "description": "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.",
        "photo": "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
        "favorite": false,
        "id": "D13A40E5-4418-4223-9CE6-D2F9A28EBE94"
    }
]
"""

        let token = "SomeToken"
        var heroes = [Hero]()

        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertEqual(
                request.value(forHTTPHeaderField: "Authorization"),
                "Bearer \(token)"
            )
            let data = try XCTUnwrap(expectedHeroes.data(using: .utf8))
            let response = try XCTUnwrap(HTTPURLResponse(
                url: URL(string: "https://dragonball.keepcoding.education")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type":"application/json"]))
            return (response, data)
        }
        let expectation = expectation(description: "Heroes have been successfully get")

        sut.getHeroes { result in
            guard case let .success(heroesGet) = result else {
                XCTFail("Expected success but received \(result)")
                return
            }
            heroes =  heroesGet

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1 )
        XCTAssertEqual(heroes[3].name, "Goku")
    }
}

// OHHTTPStubs
final class MockURLProtocol: URLProtocol {   //Sustituimos la request por este mock
    static var error: NetworkModel.NetworkError?
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))? //request hander
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        guard let handler = MockURLProtocol.requestHandler else {
            assertionFailure("Received unexpected request with no handler")
            return
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    override func stopLoading() {
        
    }
}
