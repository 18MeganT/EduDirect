//
//  GiveSuggestionsViewController.swift
//  EduDirect
//
//  Created by Megan Tjandrasuwita on 8/13/17.
//  Copyright © 2017 MMT. All rights reserved.
//

import UIKit

// Suggestion.
enum CourseType: String {
    case Math = "Math"
    case History = "History"
    case English = "English"
    case Linguistics = "Linguistics"
    case Physics = "Physics"
    case Chemistry = "Chemistry"
    case Biology = "Biology"
    case ComputerScience = "Computer Science"
    case Business = "Business"
    
}

class InternetCourse {
    var name: String!
    var prerequisite: String!
    var type: CourseType!
    
    init(name: String, type: CourseType) {
        self.name = name
        self.type = type
    }
}


func GetDataFromAPI() -> Array<InternetCourse> {
    // Get all the course from the internet...
    
    let course1: InternetCourse! = InternetCourse(name: "Calculus", type: CourseType.Math)
    let course2: InternetCourse! = InternetCourse(name: "AP US History", type: CourseType.History)
    let course3: InternetCourse! = InternetCourse(name: "AP Government", type: CourseType.History)
    let course4: InternetCourse! = InternetCourse(name: "AP Computer Science", type: CourseType.ComputerScience)
    return [course1, course2, course3, course4]
}

class GiveSuggestionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var selectedValues: Array<CourseType>!
    
    // The array of the data gathered from the api.
    var data: [InternetCourse]! = []
    var table_data: [InternetCourse]! = []
    
   
    @IBOutlet weak var text: UILabel!


    
    @IBAction func valueChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            viewDidLoad();
            text.isHidden = true;
        case 1:
            viewDidLoad();
            text.isHidden = true;
        default:
            break; 
        }
    }
    
    

    func didFinishSelectingOptions(form: SuggestionsViewController, interest: Array<String>) {
      // TODO: Remove at some point.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        //data = GetDataFromAPI();
    }
    override func viewDidAppear(_ animated: Bool) {
        table_data = self.filterInterests()
    }
    
    func filterInterests() -> Array<InternetCourse>{
        // Iterate over the main list.
        // Filter out the ones that we dont want to suggest.
        var tempArray: Array<InternetCourse>! = []
        for i in 0..<data.count {
            var b = false;
            var j = 0;
            while (j < selectedValues.count && b == false) {
                if (selectedValues[j] == data[i].type) {
                    tempArray.append(data[i]);
                    b = true;
                }
                j += 1
            }
        }
        return tempArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return table_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath) as! SuggestionsTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = UIColor.clear
        return indexPath
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
