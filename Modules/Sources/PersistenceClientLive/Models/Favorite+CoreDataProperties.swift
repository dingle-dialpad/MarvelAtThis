//
//  Favorite+CoreDataProperties.swift
//  Modules
//
//  Created by David Ingle on 2022-12-14.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var characterID: Int

}
