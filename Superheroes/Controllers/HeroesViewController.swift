//
//  HeroesViewController.swift
//  Superheroes
//
//  Created by ibautista on 27/9/23.
//

import UIKit

class HeroesViewController: UIViewController {

    // - MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // - MARK: Variables
    private let model = NetworkModel()
    private var heroes: [Hero] = []
    
    // - MARK: Livecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Listado de héroes"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HeroTableViewCell", bundle: nil), forCellReuseIdentifier: HeroTableViewCell.identifier)
       
 
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
    }


// - MARK: - Table View Datasource
extension HeroesViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return heroes.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HeroTableViewCell.identifier,
            for: indexPath)
                as? HeroTableViewCell else {
            return UITableViewCell()
        }
        let heroe = heroes[indexPath.row]
        cell.configure(hero: heroe.name, descripcion: heroe.description, url: heroe.photo)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - Table View Delegate
extension HeroesViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            let heroe = heroes[indexPath.row]
            let detailViewController = DetailViewController(heroe: heroe)
            
            DispatchQueue.main.async {
                self.navigationController?.show(detailViewController, sender: nil)
            }
            tableView.deselectRow(at: indexPath, animated: true)
            
    }
}
