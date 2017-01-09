//
//  AutoManufacturerPresenter.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit

class AutoManufacturerPresenter: AutoManufacturerPresenterProtocol, AutoManufacturerInteractorOutputProtocol {

    enum ManufacturerViewError {
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
    
    var wireFrame: AutoManufacturerWireFrameProtocol?
    var interactor: AutoManufacturerInteractorInputProtocol?
    weak var view:AutoManufacturerViewProtocol?
    
    var manufacturerItem:AutoManufacturerItem?
    
    private let pageSize = 10
    private var page = 0
    
    func fetchManufacturers(){
        view?.showLoadinView(show: true)
        interactor?.getManufacturers(page: page, pageSize: pageSize)
        page += 1
    }
    
    func provideManufacturerList(manufacturer: [Manufacturer]?, error: Error?) {
        DispatchQueue.main.async { [weak self] in
            if let weakSelf = self {
                weakSelf.view?.showLoadinView(show: false)
                if let error = error {
                    weakSelf.showError(error)
                    return
                }
                guard let list = manufacturer else {
                    return
                }
                
                if list.count > 0 {
                    var viewModels = [AutoManufacturerItem]()
                    for item in list {
                        viewModels.append(AutoManufacturerItem(manufacturerId: item.id, name: item.name))
                    }
                    weakSelf.view?.displayManufactures(manufacturer: viewModels)
                }else{
                    weakSelf.view?.noContentMessage(message: ManufacturerViewError.noContent.description)
                }
            }
        }
    }
    
    func navigateToNextScreen(manufacturer: AutoManufacturerItem) {
        manufacturerItem = manufacturer
        wireFrame?.navigateToAutoModelsViewController(manufacturer: manufacturer)
    }
    
    func showError(_ error:Error) {
        var message:String = ManufacturerViewError.unknown.description
        if error is AppError {
            switch error {
            case AppError.EmptyData:
                message = ManufacturerViewError.noContent.description
                break
            case AppError.InvalidData:
                message = ManufacturerViewError.invalidData.description
                break
            case AppError.NoInternet:
                message = ManufacturerViewError.noInternet.description
                break
            case AppError.HostUnreachable:
                message = ManufacturerViewError.hostUnreachable.description
                break
            default:
                message = ManufacturerViewError.unknown.description
                break
            }
        }
        wireFrame?.presentAlertMessage(message:message)
    }

}
