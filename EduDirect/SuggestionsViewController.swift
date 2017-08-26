//
//  SuggestionsViewController.swift
//  EduDirect
//
//  Created by Megan Tjandrasuwita on 8/11/17.
//  Copyright © 2017 MMT. All rights reserved.
//

import UIKit
import Eureka

protocol SuggestionsControllerDelegate:class {
    func didFinishSelectingOptions(form: SuggestionsViewController, interests: Array<String>)
}

class SuggestionsViewController: FormViewController {
    
    var interest: Array<CourseType>!
    
    weak var delegate: SuggestionsControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        interest = []
        self.form +++ SelectableSection<ListCheckRow<String>>("What subjects are you interested in?", selectionType: .multipleSelection)
           var subjects = ["Math", "English", "Linguistics", "History", "Physics", "Chemistry", "Biology", "Computer Science", "Business"]
        for index in 0 ..< subjects.count {
                let option = subjects[index]
                form.last! <<<
                    ListCheckRow<String>(option){ listRow in
                    listRow.tag = subjects[index];
                    listRow.title = option
                    listRow.selectableValue = option
                    listRow.value = nil
                
            }
        }

    }
    
    // values [String: Course?]
    // ["Math": nil]
    // values[key] -> (Course?)?
    // if (values[key] == nil) => that key is NOT in values.
    @IBAction func onDonePress(_ sender: Any) {
        let values = self.form.values()
        var array = Array(values.keys)
        for i in 0 ..< values.count {
            if let value = values[array[i]] {
                if (value != nil) {
                    interest.append(CourseType(rawValue: array[i])!)
                }
            }
        }
        let tvc = storyboard?.instantiateViewController(withIdentifier: "GiveSuggestionsViewController") as! GiveSuggestionsViewController
        tvc.selectedValues = interest
        self.navigationController?.pushViewController(tvc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
