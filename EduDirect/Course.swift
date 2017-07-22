//
//  Classes.swift
//  EduDirect
//
//  Created by Megan Tjandrasuwita on 6/24/17.
//  Copyright © 2017 MMT. All rights reserved.
//

import CoreData
import UIKit

class Course {
    var grade: Int!
    var name: String!
    var semester: Int!
    var workload: String!
    var description: String!
    init () {
        self.name = "Calculus"
        self.semester = 1
        self.description = "a difficult class"
        self.grade = 9
    }
    init(_ name: String, semester: Int, description: String?, grade: Int, workload: String?) {
        self.name = name
        self.semester = semester
        self.description = description ?? "No description"
        self.grade = grade
        self.workload = workload ?? "N/A"
    }
    
    func saveToCoreData(context: NSManagedObjectContext) {
        let courseData = CourseData(context: context)
        courseData.course_description = self.description
        courseData.name = self.name
        courseData.grade = Int32(self.grade)
        courseData.semester = Int32(self.semester)
        courseData.workload = self.workload
    }
    
}
