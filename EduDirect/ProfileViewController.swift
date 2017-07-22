//
//  ProfileViewController.swift
//  EduDirect
//
//  Created by Megan Tjandrasuwita on 7/13/17.
//  Copyright © 2017 MMT. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITabBarControllerDelegate {
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var schoolField: UITextField!
    
    @IBOutlet weak var gradeField: UITextField!
    
    @IBOutlet weak var majorField: UITextField!
    
    var student = Student()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
        func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
            
            if let myController = viewController as? ProfileViewController {
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
