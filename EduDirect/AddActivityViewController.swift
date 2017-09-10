//
//  AddActivityViewController.swift
//  EduDirect
//
//  Created by Megan Tjandrasuwita on 7/2/17.
//  Copyright © 2017 MMT. All rights reserved.
//

import UIKit
import SCLAlertView
import Eureka

protocol AddActivityControllerDelegate:class {
    func didFinishAddingActivity(form: AddActivityViewController, activity: Extracurricular)
    
}

class AddActivityViewController: FormViewController {
    
    @IBOutlet weak var activityName: UITextField!
    
    @IBOutlet weak var activityCommitment: UITextField!

    @IBOutlet weak var activityGrade: UITextField!
    
    @IBOutlet weak var activityDescription: UITextField!
    
    weak var delegate: AddActivityControllerDelegate?
    
    var gradeDefault: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.form +++ Section("Activity Information")
            <<< TextRow() { row in
                row.tag = "name"
                row.title = "Activity Name"
                row.placeholder = "Soccer"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                
            }
            <<< TextRow() { row in
                row.tag = "grade"
                row.title = "Grade"
                row.value = gradeDefault
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                
            }
            <<< TextRow() { row in
                row.tag = "commitment"
                row.title = "Commitment (Optional)"
                row.placeholder = "hours/week]"
                
            }
        self.form +++ Section("Activity Description")
            <<< TextAreaRow() { row in
                row.tag = "description"
                row.title = "Description (Optional)"
                row.placeholder = "My main priority. [Optional]"
            }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donePressed(_ sender: Any) {
        let values = self.form.values()
        guard let name = values["name"] as? String else {
            SCLAlertView().showError("Required Field", subTitle: "Please fill in the name of the activity")
            return;
        }
        let commitment = (values["commitment"] as? String) ?? ""
        guard let grade_string = values["grade"] as? String else {
            SCLAlertView().showError("Required Field", subTitle: "Please fill in the grade of the activity")
            return;
        }
        guard let grade = Int(grade_string) else {
            SCLAlertView().showError("Incorrect type", subTitle: "Please fill in a number for the grade.")
            return;
        }
        let description = (values["description"] as? String) ?? ""
        if (grade < 9 || grade > 12)
        {
            SCLAlertView().showError("Incorrect Grade Input.", subTitle: "Grade must be between 9 and 12.")
            return;
        }
        let newActivity = Extracurricular(name, commitment: commitment, description: description, grade: grade)
        delegate?.didFinishAddingActivity(form: self, activity: newActivity)
        dismiss(animated: true, completion: nil)

       
        
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
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
