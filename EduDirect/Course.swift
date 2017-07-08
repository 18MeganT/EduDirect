//
//  Classes.swift
//  EduDirect
//
//  Created by Megan Tjandrasuwita on 6/24/17.
//  Copyright © 2017 MMT. All rights reserved.
//

import Foundation
class Course {
    var grade: Int!
    var name: String!
    var semester: Int!
    var description: String!
    init () {
        self.name = "Calculus"
        self.semester = 1
        self.description = "a difficult class"
        self.grade = 9
    }
    init(_ name: String, semester: Int, description: String, grade: Int) {
        self.name = name
        self.semester = semester
        self.description = description
        self.grade = grade
    }
    
}
