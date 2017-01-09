//
//  RootWireFrame.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit

class RootWireFrame {

    func showRootViewController(_ viewController:UIViewController, inWindow window: UIWindow){
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.viewControllers = [viewController]
    }
}
