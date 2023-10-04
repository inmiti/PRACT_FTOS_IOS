//
//  TansDetailViewController.swift
//  Superheroes
//
//  Created by ibautista on 2/10/23.
//

import UIKit

class TansDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var transfImageView: UIImageView!
    @IBOutlet weak var transfNameLabel: UILabel!
    @IBOutlet weak var transfDescriptionLabel: UITextView!
    
    // - MARK: Constantes
    let transformation: Transformation
    
    init(transformation: Transformation) {
        self.transformation = transformation
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Livecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = transformation.name
        transfNameLabel.text = transformation.name
        transfDescriptionLabel.text = transformation.description
        transfImageView.setImage(for: transformation.photo)
    }
}
