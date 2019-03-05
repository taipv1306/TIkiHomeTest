//
//  BaseNavigationCtr.swift
//  HomeTestTiki
//
//  Created by ZickOne on 3/4/19.
//  Copyright © 2019 TaiPham. All rights reserved.
//

import UIKit

class BaseNavigationCtr: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }

}

extension BaseNavigationCtr : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if (navigationController.viewControllers.count > 1)
        {
            navigationController.interactivePopGestureRecognizer?.isEnabled = true;
        }
        else
        {
            navigationController.interactivePopGestureRecognizer?.isEnabled = false;
        }
        
    }
}
