//
//  File.swift
//  EduDirect
//
//  Created by Megan Tjandrasuwita on 6/25/17.
//  Copyright © 2017 MMT. All rights reserved.
//

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
    
}
