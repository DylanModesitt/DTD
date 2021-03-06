//
//  Errors.swift
//  MIT DTD
//
//  Created by Dylan Modesitt on 12/31/16.
//  Copyright © 2016 Beta Nu Delta Tau Delta. All rights reserved.
//

import Foundation

import Foundation
import UIKit

enum ErrorTypes {
    case SignInFailedError
}

struct Errors {
    
    static func presentErrorView(errorMessage: String) {
        let view = UIAlertView.simpleAlert(withTitle: "Error", andMessage: errorMessage)
        view.show()
    }
    
}
