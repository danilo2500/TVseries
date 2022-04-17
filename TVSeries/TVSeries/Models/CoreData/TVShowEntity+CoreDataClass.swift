//
//  TVShowEntity+CoreDataClass.swift
//  
//
//  Created by Danilo Henrique on 17/04/22.
//
//

import Foundation
import CoreData
import UIKit.UIApplication

@objc(TVShowEntity)
public class TVShowEntity: NSManagedObject {
    convenience init() {
        let appDelegate = UIApplication.shared.appDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        self.init(context: managedContext)
    }
}
