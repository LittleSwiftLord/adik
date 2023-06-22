//
//  ReferenceArticle+CoreDataProperties.swift
//  MCHSHandbook
//
//  Created by Aidar Satindiev on 17/4/23.
//
//

import Foundation
import CoreData

extension ReferenceArticle {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReferenceArticle> {
        return NSFetchRequest<ReferenceArticle>(entityName: "ReferenceArticle")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var content: String?
}

extension ReferenceArticle: Identifiable {}
