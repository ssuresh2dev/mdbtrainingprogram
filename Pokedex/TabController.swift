//
//  TabController.swift
//  Pokedex
//
//  Created by Kevin Jiang on 9/30/16.
//  Copyright © 2016 trainingprogram. All rights reserved.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TabController: UITabBarControllerDelegate {
    
}
