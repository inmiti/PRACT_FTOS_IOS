//
//  TransfTableViewCell.swift
//  Superheroes
//
//  Created by ibautista on 2/10/23.
//

import UIKit

class TransfTableViewCell: UITableViewCell {

    @IBOutlet weak var transfImageView: UIImageView!
    @IBOutlet weak var transfNameLabel: UILabel!
    @IBOutlet weak var transfDescriptionLabel: UILabel!

    
    static let identifier = "TransfTableViewCell"
    
    func configure( transformation: String, descripcion: String, url: URL) {
        transfNameLabel.text = transformation
        transfDescriptionLabel.text = descripcion
        transfImageView.setImage(for: url)
    }
    

}
