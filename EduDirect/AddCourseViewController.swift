//
//  AddCourseViewController.swift
//  EduDirect
//
//  Created by Megan Tjandrasuwita on 6/24/17.
//  Copyright © 2017 MMT. All rights reserved.
//

import UIKit

protocol AddCourseControllerDelegate:class {
    func didFinishAddingClass(form: AddCourseViewController, course: Course)
}


class AddCourseViewController: UIViewController {

    
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDonePress(_ sender: Any) {
        let name = courseNameTextField.text
        let workLoad = courseWorkLoad.text
        let grade = Int(courseGrade.text!)
        let semester = Int(courseSemester.text!)
        let description = courseDescription.text
        let newClass = Course(name!, semester: semester!, description: description!, grade: grade!, workload: workLoad!)
        delegate?.didFinishAddingClass(form: self, course: newClass)
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
