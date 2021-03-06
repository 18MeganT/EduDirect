//
//  AcademicsViewController.swift
//  EduDirect
//
//  Created by Megan Tjandrasuwita on 6/24/17.
//  Copyright © 2017 MMT. All rights reserved.
//

import UIKit
import SCLAlertView

class AcademicsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddCourseControllerDelegate {
    
    struct Grades {
        var grade:Int!
        var classes: [Course]
        
    }
    
    var gradesArray = [Grades(grade: 9, classes: []),
                       Grades(grade: 10, classes: []),
                       Grades(grade: 11, classes: []),
                       Grades(grade: 12, classes: [])] {
        didSet {
            for i in 0...(gradesArray.count - 1) {
                gradesArray[i].classes.sort(by: { (a: Course, b: Course) -> Bool in
                    return a.semester < b.semester
                })
            }
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    func didFinishAddingClass(form: AddCourseViewController, course: Course) {
        let grade = course.grade
        
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDelegate.persistentContainer.viewContext
        let savedCourse = course.saveToCoreData(context: context)
        appDelegate.saveContext()
        let objectID = savedCourse.objectID
        course.setID(objectID: objectID)
        gradesArray[grade!-9].classes.append(course)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Load data from disk and and fill up our "gradesArray"
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDelegate.persistentContainer.viewContext
        var coursesData: [CourseData] = []
        do {
            coursesData = try context.fetch(CourseData.fetchRequest()) as! [CourseData]
        } catch {
            print("Failed to add course.")
        }
        for courseData in coursesData {
            let grade = Int(courseData.grade)
            let course = Course(courseData.name!, semester: Int(courseData.semester), description: courseData.course_description, grade: Int(courseData.grade), workload: courseData.workload!)
            course.setID(objectID: courseData.objectID)
            
            if (grade < 9 || grade > 12)
            {
                gradesArray[0].classes.append(course)
            }
            else
            {
                gradesArray[grade-9].classes.append(course)
            }
        }
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellSection = indexPath.section
        let classes = gradesArray[cellSection].classes
        let cellIndex = indexPath.row
        if cellIndex == classes.count
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddClassCell", for: indexPath) as! AddCourseTableViewCell
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath) as! ClassTableViewCell
        let course = classes[indexPath.row]
        cell.courseName.text = course.name
        cell.courseSemester.text = String(course.semester)
        cell.courseDescription.text = course.description
        cell.courseWorkload.text = course.workload
        cell.contentView.setNeedsLayout()
        cell.contentView.layoutIfNeeded()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellSection = indexPath.section
        let classes = gradesArray[cellSection].classes
        if indexPath.row == classes.count {
            // Present my form view controller.
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "AddCourseNavigationController") as! UINavigationController
            let vc = controller.viewControllers[0] as! AddCourseViewController
            vc.delegate = self
            vc.gradeDefault = String(gradesArray[indexPath.section].grade)
            self.present(controller, animated: true, completion: nil)
            
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gradesArray[section].classes.count + 1
    }
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = UIColor.clear
        return indexPath
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return gradesArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Grade \(section+9)"
    }
    
    @IBAction func pressGradeButton(_ sender: UIButton) {
        let section = sender.tag
        if (section < 0 || section > 3) {
            SCLAlertView().showError("Incorrect Section", subTitle: "Section does not exist. Please try again!")
            return
        }
        var sectionRect = tableView.rect(forSection: section)
        sectionRect.size.height = tableView.frame.size.height
        tableView.scrollRectToVisible(sectionRect, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let cellSection = indexPath.section
        let classes = gradesArray[cellSection].classes
        let cellIndex = indexPath.row
        return cellIndex != classes.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete Course", message: "Are you sure you want to permanently delete this course?", preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action: UIAlertAction) in
                let cellSection = indexPath.section
                guard let courseId = self.gradesArray[cellSection].classes[indexPath.row].courseID else {
                    print("Error!")
                    self.gradesArray[cellSection].classes.remove(at: indexPath.row)
                    tableView.reloadData()
                    return
                }
                
                // Deletes from database.
                let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
                let context = appDelegate.persistentContainer.viewContext
                let courseData = context.object(with: courseId)
                context.delete(courseData)
                appDelegate.saveContext()
                
                self.gradesArray[cellSection].classes.remove(at: indexPath.row)
                tableView.reloadData()
                
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
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
