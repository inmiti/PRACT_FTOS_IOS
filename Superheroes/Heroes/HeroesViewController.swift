//
//  HeroesViewController.swift
//  Superheroes
//
//  Created by ibautista on 27/9/23.
//

import UIKit

class HeroesViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let countries: [String] = ["España", "Francia", "Portugal"] //Aquí iría el listado con los heróes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Table"  // Titulo de viewController
        tableView.dataSource = self  // ponemos un dataSource que es self
        tableView.delegate = self  // ponemos undelegate que es self
        tableView.alwaysBounceVertical = true // desactiva el efecto de hacer scroll cuando no hay mas filas
    
        
//        guard let url = URL(string: "https://assets-prd.ignimgs.com/2022/01/14/gameofthrones-allseasons-sq-1642120207458.jpg")else {
//            return
//        }
//        imageView.setImage(for: url)

        
    }

}

// - MARK: - Table View Datasource
extension HeroesViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return countries.count  // cuenta el numero de filas según el listado de héroes
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell() // Al no hacer una celda custom podemos hacerlo así
        let country = countries[indexPath.row] // pasamos el index de nuestra fila
        cell.textLabel?.text = country //Pasamos el nombre del país al que representamos
        return cell
    }
}

// MARK: - Table View Delegate
extension HeroesViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            
            tableView.deselectRow(at: indexPath, animated: true)
    }
}
