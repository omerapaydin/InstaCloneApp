//
//  SettingsViewController.swift
//  InstaCloneApp
//
//  Created by Ömer on 25.05.2024.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

 
    @IBAction func logoutClicked(_ sender: Any) {
        
        do {
            
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "goToController", sender: nil)
            
        }catch {
            print("error")
            
        }
        
        
        
    }
    

}
