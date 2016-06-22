//
//  Employees.swift
//  EmployeeStore
//
//  Created by Kony on 22/06/16.
//  Copyright (c) 2016 Kony. All rights reserved.
//

import Foundation
import CoreData

class Employees: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var contact: String
    @NSManaged var image: NSData
    @NSManaged var project: String

}
