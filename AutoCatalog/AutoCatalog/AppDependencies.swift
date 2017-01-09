//
//  AppDependencies.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit

class AppDependencies {
    
    var autoManufacturerWireFrame:AutoManufacturerWireframe!

    init() {
        configureDependencies()
    }
    
    func configureDependencies(){
        let rootWireFrame = RootWireFrame()
        autoManufacturerWireFrame = AutoManufacturerWireframe()
        autoManufacturerWireFrame?.rootWireFrame = rootWireFrame
    }
    
    func presentRootViewController(_ window:UIWindow){
        autoManufacturerWireFrame.presentAutoManufacturerInterfaceFromWindow(window)
    }
    
}

extension UIStoryboard {
    
    static var mainStrotyboard:UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
    
}
