//
//  TabBarViewController.swift
//  Superheroes
//
//  Created by ibautista on 30/9/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tableViewController1 = TableViewController()
        tableViewController1.title = "Table 1"
        tableViewController1.tabBarItem.image = UIImage(systemName: "archivebox")
        let tableViewController2 = TableViewController()
        tableViewController2.title = "Table 2"
        tableViewController1.tabBarItem.image = UIImage(systemName: "folder")
        let tableViewController3 = TableViewController()
        tableViewController3.title = "Table 3"
        tableViewController1.tabBarItem.image = UIImage(systemName: "note")
        
        viewControllers = [tableViewController1, tableViewController2, tableViewController3]// Asignamos a nuestro viewControllers un array de estos viewControllers
        
    }

}
