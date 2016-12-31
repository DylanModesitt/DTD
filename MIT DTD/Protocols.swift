//
//  protocols.swift
//  MIT DTD
//
//  Created by Dylan Modesitt on 12/31/16.
//  Copyright © 2016 Beta Nu Delta Tau Delta. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import BusyNavigationBar

/*
 * Protocols for Plato
 *
 */
protocol ErrorPresentable {
    func presentErrorView()
}

protocol PartiesManager: class {
    // var parties: [Party] { get set }
    func manageTexbooks() -> Void
    func itemMeetsAdditionalRequirements(item json: JSON) -> Bool
    func beginBusyAnimation()
    func endBusyAnimation()
}

protocol Refreshable {
    func refresh()
}

@objc protocol Actionable: class {
    func performDesiredAction()
}

protocol BusyNavigationbar {
    
}

extension BusyNavigationbar where Self: UIViewController {
    
    func getBusyNavigationbarAnimationOptions() -> BusyNavigationBarOptions {
        let options = BusyNavigationBarOptions()
        options.animationType = .stripes
        options.color = UIColor.lightGray
        
        /// Flag for enabling the transparent masking layer over the animation layer.
        options.transparentMaskEnabled = true
        return options
    }
    
    func beginBusyAnimation() {
        self.navigationController?.navigationBar.start(getBusyNavigationbarAnimationOptions())
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func endBusyAnimation() {
        self.navigationController?.navigationBar.stop()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

