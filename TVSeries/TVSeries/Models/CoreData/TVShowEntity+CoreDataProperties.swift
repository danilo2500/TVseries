//
//  TVShowEntity+CoreDataProperties.swift
//  
//
//  Created by Danilo Henrique on 17/04/22.
//
//

import Foundation
import CoreData


extension TVShowEntity {
    @NSManaged public var id: Int32
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TVShowEntity> {
        return NSFetchRequest<TVShowEntity>(entityName: "TVShowEntity")
    }
}
