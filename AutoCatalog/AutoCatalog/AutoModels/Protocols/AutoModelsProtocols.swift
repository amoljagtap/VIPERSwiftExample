//
//  AutoModelsConfigurator.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit

protocol AutoModelsViewProtocol:class {
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    var presenter:AutoModelsPresenterProtocol? { get set }
    func displayAutoModels(models:[AutoModelsItem]?)
    func setTitle(title:String)
    func showLoadinView(show: Bool)
    func noContentMessage(message:String)
}

protocol AutoModelsWireFrameProtocol {
    /**
     * Add here your methods for communication PRESENTER -> WireFrame
     */
    
    func presentAutoModelsModule(fromView: AnyObject, manufacturerItem:AutoManufacturerItem)
    func presentAlertMessage(message: String)
}


protocol AutoModelsPresenterProtocol {
    
    /**
     * Add here your methods for communication VIEW -> PRESENTER
     */
    
    weak var view: AutoModelsViewProtocol? { get set }
    var interactor: AutoModelsInteractorInputProtocol? { get set }
    var wireFrame: AutoModelsWireFrameProtocol? { get set }
    
    var manufacturerItem:AutoManufacturerItem? {get set}
    var model:AutoModelsItem? {get set}
    
    func getAutoModels()
    func presentModelInfo()
}

protocol AutoModelsInteractorInputProtocol {
    /**
     * Add here your methods for communication PRESENTER -> INTERACTOR
     */
    weak var presenter: AutoModelsInteractorOutputProtocol? { get set }
    var APIDataManager: AutoModelsDataManagerProtocol? { get set }
    
    func getAutoModels(viewModel:AutoManufacturerItem, page:Int, pageSize:Int)
}

protocol AutoModelsInteractorOutputProtocol:class {
    /**
     * Add here your methods for communication INTERACTOR -> PRESENTER
     */
    func provideAutoModelsList(autoModels: [AutoModel]?, error: Error?)
}

protocol AutoModelsDataManagerProtocol: class
{
    /**
     * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
     */
    
    var networkServices:AutoNetworkServicesProtocol? {get set}
    
    func getAutoModels(manufacturer: String, page: Int, pageSize: Int, completionHandler: @escaping (_ result:ListModelsDataManagerGetResult) -> Void)
    func parseData(data:Data) -> ListModelsDataManagerGetResult
}


enum ListModelsDataManagerGetResult {
    case Success(models: [AutoModel]?);
    case Failure(error: Error?)
}

