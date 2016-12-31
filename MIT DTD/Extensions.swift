//
//  Extensions.swift
//  MIT DTD
//
//  Created by Dylan Modesitt on 12/31/16.
//  Copyright © 2016 Beta Nu Delta Tau Delta. All rights reserved.
//


import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import MapKit
import SwiftyJSON
import BusyNavigationBar



/*
 * Extensions for DTD 
 *
 */

extension FIRDataSnapshot {
    var json: JSON {
        // probably should check for value
        return JSON(self.value!)
    }
}

extension PartiesManager where Self: UIViewController {
    
    func retrieveData() {
        let eventsRef = FIRDatabase.database().reference().child("Texbooks")
        self.beginBusyAnimation()
        // self.texbooks.removeAll()
        eventsRef.observe(.value, with: { (snapshot) in
            
            let textbooksGiven = snapshot.json
            guard textbooksGiven != JSON.null else { return }
            
            
            for (_,texbookGiven) in textbooksGiven {
                if self.itemMeetsAdditionalRequirements(item: texbookGiven) {
                    /* if let textbook = Textbook(json: texbookGiven) {
                        self.texbooks.append(textbook)
                    } */
                }
            }
            
            DispatchQueue.main.async {
                self.manageTexbooks()
                self.endBusyAnimation()
            }
        })
        
        
    }
    
}

extension UITableViewController {
    func createPlatoHeader(view: UIView) {
        view.tintColor = UIColor.fromHex(rgbValue: 0xce2e27)
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headerView.textLabel!.textColor = UIColor.fromHex(rgbValue: 0xFFFFFF)
    }
}

extension UIColor {
    // Create a color for iOS from a hexCode
    static func fromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
}

extension UIAlertView {
    static func simpleAlert(withTitle title: String, andMessage message: String) -> UIAlertView {
        let alert = self.init()
        alert.title = title
        alert.message = message
        alert.addButton(withTitle: "Ok")
        return alert
    }
}

extension String {
    
    func toDate() -> NSDate? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.date(from: self) as NSDate?
    }
    
}

extension String {
    func toTime() -> NSDate? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.date(from: self) as NSDate?
    }
}


extension NSDate {
    
    func toDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: self as Date)
    }
    
    
    func toTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: self as Date)
    }
    
    func toDateTraditionallyFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: self as Date)
    }
    
}


extension MKMapView {
    
    func fitMapViewToAnnotaion(list annotations: [MKAnnotation]) {
        let padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        var zoomRect:MKMapRect = MKMapRectNull
        
        for index in 0..<annotations.count {
            let annotation = annotations[index]
            let aPoint:MKMapPoint = MKMapPointForCoordinate(annotation.coordinate)
            let rect:MKMapRect = MKMapRectMake(aPoint.x, aPoint.y, 0.1, 0.1)
            
            if MKMapRectIsNull(zoomRect) {
                zoomRect = rect
            } else {
                zoomRect = MKMapRectUnion(zoomRect, rect)
            }
        }
        self.setVisibleMapRect(zoomRect, edgePadding: padding, animated: true)
    }
    
    func fitMapViewToAnnotaionList() {
        self.fitMapViewToAnnotaion(list: self.annotations)
    }
    
    func setSatellite() {
        self.mapType = .satellite
    }
    
    func setHybrid() {
        self.mapType = .hybrid
    }
    
    func setStandard() {
        self.mapType = .standard
    }
}

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}


extension UITableViewController {
    
    
    // show the Plato no items view if a tableview has no content
    func showNoItemsView(text: String, sublabelText: String?, actionTitle: String, vc: Actionable, searchController: UISearchController?, additionalButton: UIButton? = nil) {
        
        // if this view was triggored by an unsucessfull search, just display an empty table
        guard searchController?.searchBar.text == nil ||  searchController?.searchBar.text == "" else { return }
        
        searchController?.searchBar.isHidden = true
        
        tableView.separatorStyle = .none
        
        let startingY: CGFloat = 178
        
        // let viewToAdd = UIView(frame: CGRect(0, 0, view.bounds.size.width, view.bounds.size.height))
        let viewToAdd = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        
        viewToAdd.backgroundColor = UIColor.fromHex(rgbValue: 0xf4ead7)
        tableView.backgroundView = viewToAdd
        
        // label
        let label = UILabel(frame: CGRect(x: viewToAdd.bounds.size.width/8, y: startingY, width: viewToAdd.bounds.size.width - viewToAdd.bounds.size.width/4, height: 30))
        label.text = text
        label.font = UIFont.systemFont(ofSize: 24)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.fromHex(rgbValue: 0x222222)
        label.textAlignment = NSTextAlignment.center
        label.isUserInteractionEnabled = false
        
        // button requires label positioning, so load the label first
        viewToAdd.addSubview(label)
        
        // sub label
        var subLabel = UILabel()
        if let _ = sublabelText {
            subLabel = UILabel(frame: CGRect(x: 0, y: startingY + label.bounds.size.height, width: viewToAdd.bounds.size.width, height: 20))
            subLabel.text = sublabelText
            subLabel.font = UIFont.systemFont(ofSize: 16)
            subLabel.textColor = UIColor.fromHex(rgbValue: 0x222222)
            subLabel.textAlignment = NSTextAlignment.center
            subLabel.adjustsFontSizeToFitWidth = true
            subLabel.isUserInteractionEnabled = false
            viewToAdd.addSubview(subLabel)
        }
        
        //button
        let button: UIButton
        if let secondaryButton = additionalButton {
            button = UIButton(frame: CGRect(x: viewToAdd.bounds.size.width/2.0, y: startingY + label.bounds.size.height + subLabel.bounds.size.height, width: 100, height: 50))
            secondaryButton.frame = CGRect(x: viewToAdd.bounds.size.width/2.0 - 100, y: startingY + label.bounds.size.height + subLabel.bounds.size.height, width: 100, height: 50)
            viewToAdd.addSubview(secondaryButton)
        } else {
            button = UIButton(frame: CGRect(x: viewToAdd.bounds.size.width/2.0 - 100, y: startingY + label.bounds.size.height + subLabel.bounds.size.height, width: 200, height: 50))
        }
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        button.setTitle(actionTitle, for: .normal)
        button.setTitleColor(UIColor.fromHex(rgbValue: 0x507090), for: .normal)
        button.addTarget(vc, action: #selector(vc.performDesiredAction), for: .touchUpInside)
        
        viewToAdd.addSubview(button)
        
    }
    
    func removeNoItemsView(searchController: UISearchController?) {
        searchController?.searchBar.isHidden = false
        tableView.backgroundView = nil
        tableView.separatorStyle = .singleLine
    }
    
}





