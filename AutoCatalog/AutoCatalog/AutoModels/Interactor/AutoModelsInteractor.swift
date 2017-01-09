//
//  AutoModelsInteractor.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit

class AutoModelsInteractor: AutoModelsInteractorInputProtocol {

    var presenter: AutoModelsInteractorOutputProtocol?
    var APIDataManager: AutoModelsDataManagerProtocol?
    
    func getAutoModels(viewModel: AutoManufacturerItem, page: Int, pageSize: Int) {
        APIDataManager?.getAutoModels(manufacturer: viewModel.manufacturerId, page: page, pageSize: pageSize, completionHandler: { [weak self] (result:ListModelsDataManagerGetResult) in
            if let weakSelf = self {
                switch result {
                case .Failure(let error):
                    weakSelf.presenter?.provideAutoModelsList(autoModels: nil, error: error)
                    break
                case .Success(let models):
                    weakSelf.presenter?.provideAutoModelsList(autoModels: models, error: nil)
                    break
                }
            }
        })
    }
}
