//
//  HeroesViewController.swift
//  Superheroes
//
//  Created by ibautista on 27/9/23.
//

import UIKit

class HeroesViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    private let model = NetworkModel()
//    private let heroes: [String] = ["goku"]
    private var heroes: [Hero] = []
    
     //Aquí iría el listado con los heróes
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Listado de héroes"  // Titulo de viewController
        tableView.dataSource = self  // ponemos un dataSource que es self
        tableView.delegate = self  // ponemos undelegate que es self
        tableView.isScrollEnabled = true

//        tableView.alwaysBounceVertical = true // desactiva el efecto de hacer scroll cuando no hay mas filas
        
        model.getHeroes { [weak self] result in
            switch result {
            case .success(let heros):
                self?.heroes = heros
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        
        }
    
        
//        guard let url = URL(string: "https://assets-prd.ignimgs.com/2022/01/14/gameofthrones-allseasons-sq-1642120207458.jpg")else {
//            return
//        }
//        imageView.setImage(for: url)

        
    }


// - MARK: - Table View Datasource
extension HeroesViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return heroes.count  // cuenta el numero de filas según el listado de héroes
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell() // Al no hacer una celda custom podemos hacerlo así
        let heroe = heroes[indexPath.row] // pasamos el index de nuestra fila
        cell.textLabel?.text = heroe.name //Pasamos el nombre del país al que representamos
        return cell
    }
}

// MARK: - Table View Delegate
extension HeroesViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            let heroe = heroes[indexPath.row] // parametro del que queremos el detalle, seleccionamos cual es
            let detailViewController = DetailViewController(heroe: heroe.name) // inicializar la vista de detalle, la subclase, inyectando el parametro en cuestion
            
            DispatchQueue.main.async {
                self.navigationController?.show(detailViewController, sender: nil)//para presentarlo
            }
            tableView.deselectRow(at: indexPath, animated: true)
            
    }
}
