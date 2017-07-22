//
//  AddCourseViewController.swift
//  EduDirect
//
//  Created by Megan Tjandrasuwita on 6/24/17.
//  Copyright © 2017 MMT. All rights reserved.
//

import UIKit
import SCLAlertView
import Eureka

protocol AddCourseControllerDelegate:class {
    func didFinishAddingClass(form: AddCourseViewController, course: Course)
}


class AddCourseViewController: FormViewController {

    
    @IBOutlet weak var courseNameTextField: UITextField!
    
    @IBOutlet weak var courseWorkLoad: UITextField!
    
    @IBOutlet weak var courseGrade: UITextField!
    
    @IBOutlet weak var courseSemester: UITextField!
    
    
    @IBOutlet weak var courseDescription: UITextField!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    weak var delegate: AddCourseControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.form +++ Section("Course Information")
            <<< TextRow() { row in
                row.tag = "name"
                row.title = "Course Name"
                row.placeholder = "Calculus"
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
                row.tag = "semester"
                row.title = "Semester"
                row.placeholder = "1"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                
        }
            <<< TextRow() { row in
                row.tag = "workload"
                row.title = "Workload"
                row.placeholder = "45 min"
                
        }
            <<< TextAreaRow() { row in
                row.tag = "description"
                row.title = "Description"
                row.placeholder = "A very difficult class."
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDonePress(_ sender: Any) {
        
        let values = self.form.values()
        guard let name = values["name"] as? String else {
            SCLAlertView().showError("Required Field", subTitle: "Please fill in the name of the course")
            return;
        }
        let workLoad = (values["workload"] as? String) ?? ""
        guard let grade_string = values["grade"] as? String else {
            SCLAlertView().showError("Required Field", subTitle: "Please fill in the grade of the course")
            return;
        }
        guard let grade = Int(grade_string) else {
            SCLAlertView().showError("Incorrect type", subTitle: "Please fill in a number for the grade.")
            return;
        }
        guard let semester_text = values["semester"] as? String else {
            SCLAlertView().showError("Required Field", subTitle: "Please fill in the semester of the course")
            return;
        }
        guard let semester = Int(semester_text) else {
            SCLAlertView().showError("Invalid type!", subTitle: "Please gives a number for semester.")
            return;
        }
        let description = (values["description"] as? String) ?? ""
        if (grade < 9 || grade > 12)
        {
            SCLAlertView().showError("Incorrect Grade Input.", subTitle: "Grade must be between 9 and 12.")
            return;
        }
        let newClass = Course(name, semester: semester, description: description, grade: grade, workload: workLoad)
        delegate?.didFinishAddingClass(form: self, course: newClass)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onCancelButtonPress(_ sender: Any) {
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
