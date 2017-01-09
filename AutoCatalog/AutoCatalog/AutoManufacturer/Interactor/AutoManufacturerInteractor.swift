//
//  AutoManufacturerInteractor.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import Foundation

class AutoManufacturerInteractor: AutoManufacturerInteractorInputProtocol {

    var APIDataManager:AutoManufacturerDataManagerProtocol?
    weak var presenter:AutoManufacturerInteractorOutputProtocol?
    
    func getManufacturers(page: Int, pageSize:Int) {
        APIDataManager?.getManufacturers(page: page, pageSize: pageSize, completionBlock: { [weak self] (result:ListManufacturersDataManagerGetResult) in
            if let weakSelf = self {
                switch result {
                case .Failure(let error):
                    let errorType = AppError.getErrorType(error)
                    weakSelf.presenter?.provideManufacturerList(manufacturer: nil, error: errorType)
                    break
                case .Success(let manufacturers):
                    weakSelf.presenter?.provideManufacturerList(manufacturer: manufacturers, error: nil)
                    break
                }
            }
        })
    }

}
