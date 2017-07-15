//
//  File.swift
//  EduDirect
//
//  Created by Megan Tjandrasuwita on 6/25/17.
//  Copyright © 2017 MMT. All rights reserved.
//

import CoreData
import Foundation
class Extracurricular {
    var name: String!
    var grade: Int!
    var commitment: String!
    var description: String!
    init () {
        self.name = "Figure Skating"
        self.commitment = "8 hours/week"
        self.description = "my main priority right now"
        self.grade = 9
    }
    init(_ name: String, commitment: String, description: String, grade: Int) {
        self.name = name
        self.commitment = commitment
        self.description = description
        self.grade = grade
    }
    func saveToCoreData(context: NSManagedObjectContext) {
        let activityData = ActivityData(context: context)
        activityData.activity_description = self.description
        activityData.name = self.name
        activityData.grade = Int32(self.grade)
        activityData.commitment = self.commitment
    }
    
}
