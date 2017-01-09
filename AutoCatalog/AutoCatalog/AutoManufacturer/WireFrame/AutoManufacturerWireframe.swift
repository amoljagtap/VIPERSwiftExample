//
//  AutoManufacturerWireframe.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit


class AutoManufacturerWireframe: AutoManufacturerWireFrameProtocol {
    
    var autoModelsWireframe:AutoModelsWireFrameProtocol?
    let autoManufacturerViewController = String(describing:AutoManufacturerViewController.self)
    var view:AutoManufacturerViewProtocol?
    var rootWireFrame:RootWireFrame?

    init() {
        view = autoManufacturerViewControllerFromStoryboard()
        
    }
    
    ///install root view controller in window
    func presentAutoManufacturerInterfaceFromWindow(_ window: UIWindow) {
        guard let sourceView = view as? UIViewController else {
            return
        }
        
        var presenter:AutoManufacturerPresenterProtocol&AutoManufacturerInteractorOutputProtocol = AutoManufacturerPresenter()
        var interactor:AutoManufacturerInteractorInputProtocol = AutoManufacturerInteractor()
        var dataManager:AutoManufacturerDataManagerProtocol = AutoManufacturerDataManager()
        dataManager.networkServices = AutoNetworkServices.sharedInstace
        
        view?.presenter = presenter
        presenter.view = view
        presenter.wireFrame = self
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = dataManager
        
        rootWireFrame?.showRootViewController(sourceView, inWindow: window)
    }
    
    func presentAutoModelsModule(fromView: AnyObject, manufacturerItem:AutoManufacturerItem) {
        autoModelsWireframe = AutoModelsWireframe()
        autoModelsWireframe?.presentAutoModelsModule(fromView: fromView, manufacturerItem: manufacturerItem)
    }
    
    func navigateToAutoModelsViewController(manufacturer: AutoManufacturerItem) {
        guard let sourceView = view else {
            return
        }
        presentAutoModelsModule(fromView: sourceView, manufacturerItem:manufacturer)
    }
    
    func presentAlertMessage(message: String) {
        guard let sourceView = view as? UIViewController else {
            return
        }
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        sourceView.present(alert, animated: true, completion: nil)
    }
    
    func autoManufacturerViewControllerFromStoryboard() -> AutoManufacturerViewProtocol? {
        let viewController = UIStoryboard.mainStrotyboard.instantiateViewController(withIdentifier:autoManufacturerViewController) as? AutoManufacturerViewProtocol
        return viewController
    }
    
    //    func navigateToAutoModelsViewController(_ segue: UIStoryboardSegue, manufacturerViewModel: AutoManufacturerItem) {
    //
    //    }

}
