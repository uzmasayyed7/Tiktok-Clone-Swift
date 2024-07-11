//
//  BaseNavigationController.swift
//  Tiktok-Clone-Swift
//
//  Created by Uzma Sayyed on 9/25/20.
//  Copyright © 2020 Uzma Sayyed. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = .Background
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        setNavigationBarHidden(true, animated: false)
    }
    
    

}
