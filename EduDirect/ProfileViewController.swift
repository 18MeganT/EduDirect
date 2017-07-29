//
//  ProfileViewController.swift
//  EduDirect
//
//  Created by Megan Tjandrasuwita on 7/13/17.
//  Copyright © 2017 MMT. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UITabBarControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var schoolField: UITextField!
    
    @IBOutlet weak var gradeField: UITextField!
    
    @IBOutlet weak var majorField: UITextField!
    
    var student = Student()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.navigationController?.navigationBar.isTranslucent = false
        // self.navigationController?.navigationBar.backgroundColor = UIColor(red: 33.0/255, green: 192.0/255, blue: 100.0/255, alpha: 1)

        // Do any additional setup after loading the view.
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Todo -- when you click off profile, we want to save the input information.
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController is ProfileViewController {
            // do something
        }
        return true
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
