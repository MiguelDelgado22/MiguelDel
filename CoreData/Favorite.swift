//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by Miguel Angel Delgado Alcantara on 26/03/22.
//
//

import Foundation
import CoreData


class Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }
    @NSManaged public var isFavorite: Bool?
    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var date: String?
    @NSManaged public var descriptionaImage: String?
    @NSManaged public var favorite: Double

}
