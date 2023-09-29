//
//  HeroesTableViewController.swift
//  Superheroes
//
//  Created by ibautista on 29/9/23.
//

import UIKit

class HeroesTableViewController: UITableViewController {
    
    // MARK: - Model
    private let heroes: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lista de héroes" //  Añadimos titulo al navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true // Personalizar con un título algo mas grande
        
    }
}

    // MARK: - Data Source
extension HeroesTableViewController {
        override func tableView(
            _ tableView: UITableView,
            numberOfRowsInSection section: Int) -> Int {
                heroes.count  //Da el número de filas
            }
        
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(  //Obtenemos la celda que nos toca en la fila
                withIdentifier: "HeroTableViewCell",
                for: indexPath)
            let heroe = heroes [indexPath.row] //Declaramos constante que irá en cada fila, el heroe
            cell.textLabel?.text = heroe.name // Configuramos la celda con el nombre, accedemos al texto
//            let url = heroe.photo
//            guard let url = URL(url)else {
//                return
//            }
//            imageLoginView.setImage(for: url)
//            }
            
//            cell.imageView?.image = heroe.photo //Configuramos la celda con la imagen, accedemos a la imagen
            return cell
    }
        
        
    }



