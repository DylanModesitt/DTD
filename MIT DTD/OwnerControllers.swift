//
//  OwnerControllers.swift
//  MIT DTD
//
//  Created by Dylan Modesitt on 12/31/16.
//  Copyright © 2016 Beta Nu Delta Tau Delta. All rights reserved.
//

import Foundation
import UIKit


/*
 @brief Classes for Tab and Navigation Controllers
 * for reference purposes
 */
class SocialTabController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // change what view is loaded as the front view controller
        // for example, the quick actions from the homescreen
        if UserDefaults.standard.bool(forKey: "loadBlacklist") {
            UserDefaults.standard.set(false, forKey: "loadBlacklist")
            self.revealViewController().pushFrontViewController(storyboard?.instantiateViewController(withIdentifier: "BlackListViewController"), animated: true)
        }
    }
    
}
