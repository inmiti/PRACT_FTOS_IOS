//
//  TransfTableViewCell.swift
//  Superheroes
//
//  Created by ibautista on 2/10/23.
//

import UIKit

class TransfTableViewCell: UITableViewCell {

    // - MARK: Outlets
    @IBOutlet weak var transfImageView: UIImageView!
    @IBOutlet weak var transfNameLabel: UILabel!
    @IBOutlet weak var transfDescriptionLabel: UILabel!

    // - MARK: Constante
    static let identifier = "TransfTableViewCell"
    
    // - MARK: Método configure
    func configure( transformation: String, descripcion: String, url: URL) {
        transfNameLabel.text = transformation
        transfDescriptionLabel.text = descripcion
        transfImageView.setImage(for: url)
    }
    

}
