//
//  MenuTableViewController.swift
//  MIT DTD
//
//  Created by Dylan Modesitt on 12/31/16.
//  Copyright © 2016 Beta Nu Delta Tau Delta. All rights reserved.
//

import UIKit

class MenuTableViewController:  UITableViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var hierarchyBreadcrumb: UILabel!
    
    func setUI() {
        tableView.contentInset.top = 20
        self.extendedLayoutIncludesOpaqueBars = false;
        self.automaticallyAdjustsScrollViewInsets = false;
        //        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        UIApplication.shared.statusBarStyle = .lightContent 
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.fromHex(rgbValue: 0xB9A6D9)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    

}

