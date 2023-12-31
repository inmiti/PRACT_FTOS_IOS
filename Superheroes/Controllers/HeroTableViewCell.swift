//
//  HeroTableViewCell.swift
//  Superheroes
//
//  Created by ibautista on 30/9/23.
//

import UIKit

class HeroTableViewCell: UITableViewCell {
    
    static let identifier = "HeroTableViewCell"
    
    // - MARK: Outlets
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroDescriptionLabel: UILabel!
    
    // - MARK: Método configure
    func configure( hero: String, descripcion: String, url: URL) {
        heroNameLabel.text = hero
        heroDescriptionLabel.text = descripcion
        heroImage.setImage(for: url)
    }
        
    }
    

