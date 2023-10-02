//
//  TransfViewController.swift
//  Superheroes
//
//  Created by ibautista on 2/10/23.
//

import UIKit

class TransfViewController: UIViewController {

    @IBOutlet weak var TransfTableView: UITableView!
    
    private let model = NetworkModel()
    private let heroe: String
    
//    private let hero: String = ""
    
    init(heroe: String) {   //para pasar el modelo de heroe al viewControler, ceamos metodo inicializador
        self.heroe = heroe
        super.init(nibName: nil, bundle: nil)  // el sabe el viewController que es DetailViewController, el paquete tambien lo sabe
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transformaciones de /(heroe)"  // Titulo de viewController
        tableView.dataSource = self  // ponemos un dataSource que es self
        tableView.delegate = self  // ponemos undelegate que es self
        
        model.getTransformations(for: heroe) { result in
            swtch()
        }
    }
}


// - MARK: - Table View Datasource
extension TransfViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
//    func tableView(
//        _ tableView: UITableView,
//        numberOfRowsInSection section: Int) -> Int {
//            return heroes.count  // cuenta el numero de filas según el listado de héroes
    }
//    func tableView(_ tableView: UITableView,
//                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//// CASO CELDA NO CUSTOM:
//        let cell = UITableViewCell() // Al no hacer una celda custom podemos hacerlo así
//        let heroe = heroes[indexPath.row] // pasamos el index de nuestra fila
//        cell.textLabel?.text = heroe.name //Pasamos el nombre del país al que representamos
//        cell.accessoryType = .disclosureIndicator
////
////        CASO CELDA PERONALIZADA:
//        guard let cell = tableView.dequeueReusableCell(
//            withIdentifier: HeroTableViewCell.identifier,
//            for: indexPath)
//                as? HeroTableViewCell else {
//            return UITableViewCell()
//        }
//        let heroe = heroes[indexPath.row]
//        cell.configure(hero: heroe.name, descripcion: heroe.description, url: heroe.photo)
//        cell.accessoryType = .disclosureIndicator
//        return cell
//    }
//}
