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
    private let heroe: Hero
    private var transformations: [Transformation] = []
    
    
    init(heroe: Hero) {   //para pasar el modelo de heroe al viewControler, ceamos metodo inicializador
        self.heroe = heroe
        super.init(nibName: nil, bundle: nil)  // el sabe el viewController que es DetailViewController, el paquete tambien lo sabe
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    MARK: - LiveCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transformaciones"  // Titulo de viewController
        TransfTableView.dataSource = self  // ponemos un dataSource que es self
        TransfTableView.delegate = self  // ponemos undelegate que es self
        TransfTableView.register(UINib(nibName: "TransfTableViewCell", bundle: nil), forCellReuseIdentifier: TransfTableViewCell.identifier) // registramos la celda personalizada
        
        model.getTransformations(for: heroe) { [weak self] result in
            switch result {
            case .success(let transformationsList):
                self?.transformations = transformationsList
                DispatchQueue.main.async {
                    self?.TransfTableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}



// - MARK: - Table View Datasource
extension TransfViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return transformations.count
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                   withIdentifier: TransfTableViewCell.identifier,
                   for: indexPath)
                       as? TransfTableViewCell else {
                   return UITableViewCell()
               }
               let transformation = transformations[indexPath.row]
        cell.configure(transformation: transformation.name, descripcion: transformation.description, url: transformation.photo)
               cell.accessoryType = .disclosureIndicator
               return cell
        
    }
}


// MARK: - Table View Delegate
extension TransfViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            let transformation = transformations[indexPath.row] // parametro del que queremos el detalle, seleccionamos cual es
            //            let detailTransViewController = DetailViewController(heroe: heroe) // inicializar la vista de detalle, la subclase, inyectando el parametro en cuestion
            
            //            DispatchQueue.main.async {
            //                self.navigationController?.show(detailViewController, sender: nil)//para presentarlo
            //            }
            //            tableView.deselectRow(at: indexPath, animated: true)
            //
            //    }
        }
    
}
