//
//  TransfViewController.swift
//  Superheroes
//
//  Created by ibautista on 2/10/23.
//

import UIKit

class TransfViewController: UIViewController {
    
    // - MARK: Outlets
    @IBOutlet weak var TransfTableView: UITableView!
    
    // - MARK: Variables
    private let model = NetworkModel()
    private let heroe: Hero
    private var transformations: [Transformation] = []
    
    
    init(heroe: Hero) {
        self.heroe = heroe
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    MARK: - LiveCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transformaciones"
        TransfTableView.dataSource = self
        TransfTableView.delegate = self
        TransfTableView.register(UINib(nibName: "TransfTableViewCell", bundle: nil), forCellReuseIdentifier: TransfTableViewCell.identifier)
        
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
            let transformation = transformations[indexPath.row]
            let detailTransViewController = TansDetailViewController(transformation: transformation)
            navigationController?.show(detailTransViewController, sender: nil)
                    tableView.deselectRow(at: indexPath, animated: true)
    }
}
