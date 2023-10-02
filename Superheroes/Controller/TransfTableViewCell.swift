//
//  TransfTableViewCell.swift
//  Superheroes
//
//  Created by ibautista on 2/10/23.
//

import UIKit

class TransfTableViewCell: UITableViewCell {

    @IBOutlet weak var TransfImageView: UIImageView!
    @IBOutlet weak var TrasfNameLabel: UILabel!
    @IBOutlet weak var TransfDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
