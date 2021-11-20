//
//  CDUserActivitys+CoreDataProperties.swift
//  ДВФУПример
//
//  Created by Фам Тхань Хай on 19/11/2021.
//

import Foundation
import CoreData


extension CDUserActivitys {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUserActivitys> {
        return NSFetchRequest<CDUserActivitys>(entityName: "CDUserActivitys")
    }

    @NSManaged public var locationData: String?

}

extension CDUserActivitys : Identifiable {

}
