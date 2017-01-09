//
//  AutoModelsDataManager.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit

class AutoModelsDataManager:AutoModelsDataManagerProtocol {
    
    var networkServices: AutoNetworkServicesProtocol?
    var parseManager:JSONParserProtocol?
    
    init(parseManager:JSONParserProtocol = DataParserManager()) {
        self.parseManager = parseManager
    }
    
    func getAutoModels(manufacturer: String, page: Int, pageSize: Int, completionHandler: @escaping (_ result:ListModelsDataManagerGetResult) -> Void) {
        networkServices?.getAutoModelsList(manufacturer: manufacturer, page: page, pageSize: pageSize, completionHandler: { [weak self] (data, error) in
            if let error = error {
                let errorType = NetworkError.getError(error)
                completionHandler(ListModelsDataManagerGetResult.Failure(error: errorType))
            }else{
                guard let data = data else {
                    completionHandler(ListModelsDataManagerGetResult.Failure(error: DataManagerError.EmptyData))
                    return
                }
                if let weakSelf = self {
                    let result = weakSelf.parseData(data: data)
                    completionHandler(result)
                }
            }
        })
    }

    /// Parse JSON data
    ///
    /// - Parameter data: JSON data
    /// - Returns: Auto models items array and parsing error
    func parseData(data:Data) -> ListModelsDataManagerGetResult {
        do {
            let jsonDictionary = try parseManager?.parseData(data: data)
            let models = getModelsFromDictionary(jsonDictionary)
            return ListModelsDataManagerGetResult.Success(models: models)
        }catch JSONParserError.InvalidJSON {
            return ListModelsDataManagerGetResult.Failure(error: JSONParserError.InvalidJSON)
        }catch{
            return ListModelsDataManagerGetResult.Failure(error: JSONParserError.InvalidJSON)
        }
    }
    
    func getModelsFromDictionary(_ jsonDictionary:[String:Any]?) -> [AutoModel]? {
        var autoModelsList = [AutoModel]()
        guard let autoModels = jsonDictionary?["wkda"] as? [String:String] else {
            return nil
        }
        
        for (id, name) in autoModels {
            autoModelsList.append(AutoModel(id: id, name: name))
        }
        return autoModelsList
    }

}
