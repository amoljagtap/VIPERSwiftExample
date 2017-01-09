//
//  AutoManufacturerConfigurator.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit

protocol AutoManufacturerViewProtocol:class {
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    var presenter: AutoManufacturerPresenterProtocol? { get set }
    func noContentMessage(message:String)
    func displayManufactures(manufacturer:[AutoManufacturerItem]?)
    func showLoadinView(show:Bool)
}

protocol AutoManufacturerWireFrameProtocol {
    /**
     * Add here your methods for communication PRESENTER -> WireFrame
     */
    
    var autoModelsWireframe:AutoModelsWireFrameProtocol? { get set };
    
    func presentAlertMessage(message:String)
    func navigateToAutoModelsViewController(manufacturer:AutoManufacturerItem)
}


protocol AutoManufacturerPresenterProtocol {
    
    /**
     * Add here your methods for communication VIEW -> PRESENTER
     */
    
    var view: AutoManufacturerViewProtocol? { get set };
    var interactor: AutoManufacturerInteractorInputProtocol? { get set };
    var wireFrame: AutoManufacturerWireFrameProtocol? { get set };

    func fetchManufacturers()
    func navigateToNextScreen(manufacturer:AutoManufacturerItem)
}

protocol AutoManufacturerInteractorInputProtocol {
    /**
     * Add here your methods for communication PRESENTER -> INTERACTOR
     */
    weak var presenter: AutoManufacturerInteractorOutputProtocol? { get set }
    var APIDataManager: AutoManufacturerDataManagerProtocol? { get set }
    func getManufacturers(page:Int, pageSize:Int)
}

protocol AutoManufacturerInteractorOutputProtocol:class {
    /**
     * Add here your methods for communication INTERACTOR -> PRESENTER
     */
    func provideManufacturerList(manufacturer: [Manufacturer]?, error:Error?)
}

protocol AutoManufacturerDataManagerProtocol
{
    /**
     * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
     */
    var networkServices:AutoNetworkServicesProtocol? {get set}
    
    func getManufacturers(page: Int, pageSize:Int, completionBlock: @escaping (ListManufacturersDataManagerGetResult) -> Void)
    func parseData(data:Data) -> ListManufacturersDataManagerGetResult
}

enum ListManufacturersDataManagerGetResult {
    case Success(manufacturers: [Manufacturer]?)
    case Failure(error: Error?)
}




