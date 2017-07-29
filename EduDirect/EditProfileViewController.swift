//
//  EditProfileViewController.swift
//  EduDirect
//
//  Created by Megan Tjandrasuwita on 7/25/17.
//  Copyright © 2017 MMT. All rights reserved.
//

import UIKit
import CoreData
import Eureka
import SCLAlertView

protocol EditProfileControllerDelegate:class {
    func didFinishEditingProfile(form: ProfileViewController, student: Student)
}

class EditProfileViewController: FormViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.form +++ Section("Profile Information")
            <<< TextRow() { row in
                row.tag = "name"
                row.title = "Name"
                row.placeholder = "John Doe"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                
            }
            <<< TextRow() { row in
                row.tag = "grade"
                row.title = "Grade"
                row.placeholder = "9"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                
            }
            <<< TextRow() { row in
                row.tag = "school"
                row.title = "School"
                row.placeholder = "XYZ High School"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                
            }
            <<< TextRow() { row in
                row.tag = "major"
                row.title = "Prospective Major"
                row.placeholder = "Biology"
                
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelPress(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onDonePress(_ sender: Any) {
        let values = self.form.values()
        guard let name = values["name"] as? String else {
            SCLAlertView().showError("Required Field", subTitle: "Please fill in your name")
            return;
        }
        guard let grade_string = values["grade"] as? String else {
            SCLAlertView().showError("Required Field", subTitle: "Please fill in the grade that you're currently in.")
            return;
        }
        guard let grade = Int(grade_string) else {
            SCLAlertView().showError("Incorrect type", subTitle: "Please fill in a number for the grade.")
            return;
        }
        let school = (values["school"] as? String) ?? ""
        let major = (values["major"] as? String) ?? ""
        
        let student = Student(name, grade: grade, school: school, major: major)
        delegate?.didFinishEditingProfile(form: self, student: student)
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
