//
//  AutoModelsWireframe.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit

class AutoModelsWireframe: AutoModelsWireFrameProtocol {

    var view:AutoModelsViewProtocol?
    let autoModelsViewController = String(describing:AutoModelsViewController.self)
    
    init() {
        view = autoModelsViewControllerFromStoryboard()
    }
    
    /// Present auto module view
    ///
    /// - Parameters:
    ///   - fromView: source view
    ///   - manufacturerItem: manufacture item with manufacturer info
    func presentAutoModelsModule(fromView: AnyObject, manufacturerItem:AutoManufacturerItem) {
        var presenter:AutoModelsPresenterProtocol & AutoModelsInteractorOutputProtocol = AutoModelsPresenter()
        var interactor:AutoModelsInteractorInputProtocol = AutoModelsInteractor()
        var dataManager:AutoModelsDataManagerProtocol = AutoModelsDataManager()
        dataManager.networkServices = AutoNetworkServices.sharedInstace
        
        view?.presenter = presenter
        presenter.view = view
        presenter.wireFrame = self
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = dataManager
        
        presenter.manufacturerItem = manufacturerItem
        
        guard let sourceView = fromView as? UIViewController else {
            return
        }
        
        if let view = view as? UIViewController {
            sourceView.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    /// Present alert message
    ///
    /// - Parameter message: alert message
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

    /// Get AutoModelViewController from storyboard
    ///
    /// - Returns: AutoModelViewController instance
    func autoModelsViewControllerFromStoryboard() -> AutoModelsViewProtocol? {
        let viewController = UIStoryboard.mainStrotyboard.instantiateViewController(withIdentifier:autoModelsViewController) as? AutoModelsViewProtocol
        return viewController
    }
}
