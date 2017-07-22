//
//  Student.swift
//  EduDirect
//
//  Created by Megan Tjandrasuwita on 7/20/17.
//  Copyright © 2017 MMT. All rights reserved.
//

import CoreData
import Foundation

class Student {
    var grade: Int!
    var name: String!
    var school: String!
    var major:String!
    init() {
        
    }
    init(_ name: String, grade: Int, school: String, major: String) {
        self.name = name
        self.grade = grade
        self.school = school
        self.major = major
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func setGrade(grade: Int) {
        self.grade = grade
    }
    
    func setSchool(school: String) {
        self.school = school
    }
    func setMajor(major: String) {
        self.major = major
    }
    
    func saveToCoreData(context: NSManagedObjectContext) {
        let studentData = StudentData(context: context)
        studentData.school = self.school
        studentData.name = self.name
        studentData.grade = Int32(self.grade)
        studentData.major = self.major
    }

}
