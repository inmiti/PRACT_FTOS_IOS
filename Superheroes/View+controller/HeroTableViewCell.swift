//
//  HeroTableViewCell.swift
//  Superheroes
//
//  Created by ibautista on 30/9/23.
//

import UIKit

class HeroTableViewCell: UITableViewCell {
    static let identifier = "HeroTableViewCell"
    
    @IBOutlet weak var heroImage: UIImageView!
    
    @IBOutlet weak var heroNameLabel: UILabel!
    
    @IBOutlet weak var heroDescriptionLabel: UILabel!
    
    func configure(with hero: String ) {
        heroNameLabel.text = hero
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
