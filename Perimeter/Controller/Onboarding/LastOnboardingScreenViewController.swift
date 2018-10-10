//
//  LastOnboardingScreenViewController.swift
//  Perimeter
//
//  Created by Davone Barrett on 10/10/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation
import UIKit

class LastOnboardingScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getStartedPressed(_ sender: Any) {
        let signupSB = UIStoryboard(name: "Signup", bundle: nil)
        
        let signupVC = signupSB.instantiateViewController(withIdentifier: "SignupVC")
        show(signupVC, sender: self)
    }
    
}
