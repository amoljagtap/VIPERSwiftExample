//
//  AutoModelsPresenter.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit


class AutoModelsPresenter: AutoModelsPresenterProtocol, AutoModelsInteractorOutputProtocol {
    
    enum ModelsViewError {
        case noContent
        case unknown
        case invalidData
        case noInternet
        case hostUnreachable
        
        var description:String {
            switch self {
            case .noContent:
                return "No Content"
            case .unknown:
                return "Unknown Error"
            case .invalidData:
                return "Bad data received. Please try again later!"
            case .noInternet:
                return "No internet connection. Please connect to internet and try again later!"
            case .hostUnreachable:
                return "Could not connect to server. Please try again later!"
            }
        }
    }
    
    var manufacturerItem: AutoManufacturerItem?
    var model: AutoModelsItem?
    
    var wireFrame: AutoModelsWireFrameProtocol?
    weak var view:AutoModelsViewProtocol?
    var interactor:AutoModelsInteractorInputProtocol?
    
    private let pageSize = 10
    private var page = 0
    
    //MARK: - Presenter Delegate
    func getAutoModels() {
        if let item = manufacturerItem {
            view?.showLoadinView(show: true)
            view?.setTitle(title: item.name)
            interactor?.getAutoModels(viewModel: item, page: page, pageSize: pageSize)
            page += 1
        }else{
            view?.setTitle(title: "")
        }
    }
    
    /// Display auto models list in view
    ///
    /// - Parameters:
    ///   - autoModels: automodels lsi array
    ///   - error: error if any
    func provideAutoModelsList(autoModels: [AutoModel]?, error: Error?) {
        DispatchQueue.main.async { [weak self] in
            if let weakSelf = self {
                weakSelf.view?.showLoadinView(show: false)
                if let error = error {
                    weakSelf.showError(error)
                    return
                }
                guard let models = autoModels else {
                    return
                }
                if models.count > 0 {
                    var viewModels = [AutoModelsItem]()
                    for item in models {
                        viewModels.append(AutoModelsItem(id: item.id, name: item.name))
                    }
                    weakSelf.view?.displayAutoModels(models: viewModels)
                }else{
                    weakSelf.view?.noContentMessage(message: ModelsViewError.noInternet.description)
                }
            }
        }
    }
    
    /// Present alert message - Model info with Manufacturer name
    func presentModelInfo() {
        if let manufacturerName = manufacturerItem?.name, let modelName = model?.name {
            let info = "Manufacturer: \(manufacturerName)" + "\n" + "Model: \(modelName)"
            wireFrame?.presentAlertMessage(message: info)
        }
    }
    
    //MARK: - Private mehtods
    /// Display error message
    ///
    /// - Parameter error: error
    private func showError(_ error:Error) {
        var message:String = ModelsViewError.unknown.description
        if error is AppError {
            switch error {
            case AppError.EmptyData:
                message = ModelsViewError.noContent.description
                break
            case AppError.InvalidData:
                message = ModelsViewError.invalidData.description
                break
            case AppError.NoInternet:
                message = ModelsViewError.noInternet.description
                break
            case AppError.HostUnreachable:
                message = ModelsViewError.hostUnreachable.description
                break
            default:
                message = ModelsViewError.unknown.description
                break
            }
        }
        wireFrame?.presentAlertMessage(message:message)
    }

}
