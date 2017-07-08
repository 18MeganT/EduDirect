//
//  ActivitiesViewController.swift
//  EduDirect
//
//  Created by Megan Tjandrasuwita on 6/25/17.
//  Copyright © 2017 MMT. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate , AddActivityControllerDelegate{
    
    struct Grades {
        var grade:Int!
        var activities: [Extracurricular]
        
    }
    
    
    var gradesArray = [Grades]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func didFinishAddingActivity(form: AddActivityViewController, activity: Extracurricular) {
        
        let grade = activity.grade
        if (grade! < 9)
        {
            gradesArray[0].activities.append(activity)
        }
        else
        {
            gradesArray[grade!-9].activities.append(activity)
        }
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        gradesArray = [Grades(grade: 9, activities:     [Extracurricular()]),
                       Grades(grade: 10, activities: [Extracurricular()]),
                       Grades(grade: 11, activities: [Extracurricular()]),
                       Grades(grade: 12, activities: [Extracurricular()])]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gradesArray[section].activities.count + 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return gradesArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellSection = indexPath.section
        let activities = gradesArray[cellSection].activities
        let cellIndex = indexPath.row
        if cellIndex == activities.count
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddActivityCell", for: indexPath) as! AddActivityTableViewCell
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityTableViewCell
        let activity = activities[indexPath.row]
        cell.activityName.text = activity.name
        cell.activityCommitment.text = activity.commitment
        cell.activityDescription.text = activity.description
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellSection = indexPath.section
        let activities = gradesArray[cellSection].activities
        if indexPath.row == activities.count {
            // Present my form view controller.
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "AddActivityNavigationController") as! UINavigationController
            let vc = controller.viewControllers[0] as! AddActivityViewController
            vc.delegate = self
            self.present(controller, animated: true, completion: nil)
            
        }
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
