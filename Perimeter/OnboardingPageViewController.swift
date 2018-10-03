//
//  OnboardingPageViewController.swift
//  Perimeter
//
//  Created by Joshua Martinez on 9/12/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation
import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var viewControllerList: [UIViewController] = {
        
        let sb = UIStoryboard(name: "Onboarding", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "OneVC")
        let vc2 = sb.instantiateViewController(withIdentifier: "TwoVC")
        let vc3 = sb.instantiateViewController(withIdentifier: "ThreeVC")
        
        return [vc1, vc2, vc3]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        
        guard viewControllerList.count > previousIndex else {return nil}
        
        return viewControllerList[previousIndex]
        
        // create an array of objects that take 3 items, 2 text labels, and 1 image.
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        guard viewControllerList.count != nextIndex else {return nil}
        
        guard viewControllerList.count > nextIndex else {return nil}
        
        return viewControllerList[nextIndex]
    }
    
//    @IBAction func toSignup(_ sender: AnyObject) {
//        let vc = signUpStoryboard.i    }
//
    
}

