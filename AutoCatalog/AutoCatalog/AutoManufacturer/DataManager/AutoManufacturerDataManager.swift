//
//  AutoManufacturerDataManager.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit

class AutoManufacturerDataManager: AutoManufacturerDataManagerProtocol {
    
    var networkServices: AutoNetworkServicesProtocol?
    var parseManager:JSONParserProtocol?
    
    init(parseManager:JSONParserProtocol = DataParserManager()) {
        self.parseManager = parseManager
    }
    
    /// Retreives Manufacturers list from the web server
    func getManufacturers(page: Int, pageSize:Int, completionBlock: @escaping (_ result:ListManufacturersDataManagerGetResult) -> Void) {
        networkServices?.getAutoManufacturerList(page: page, pageSize: pageSize, completionHandler: { [weak self] (data, error) in
            if let error = error {
                let errorType = NetworkError.getError(error)
                completionBlock(ListManufacturersDataManagerGetResult.Failure(error: errorType))
            }else{
                guard let data = data else {
                    completionBlock(ListManufacturersDataManagerGetResult.Failure(error: DataManagerError.EmptyData))
                    return
                }
                if let weakSelf = self {
                    let result = weakSelf.parseData(data: data)
                    completionBlock(result)
                }
            }
        })
    }
    
    /// Parse JSON data
    ///
    /// - Parameter data: JSON data
    /// - Returns: Manufacturer items array and parsing error
    func parseData(data:Data) -> ListManufacturersDataManagerGetResult {
        do {
            let jsonDictionary = try parseManager?.parseData(data: data)
            let autoManufacturers = getManufacturesFromDictionary(jsonDictionary)
            return ListManufacturersDataManagerGetResult.Success(manufacturers: autoManufacturers)
        }catch JSONParserError.InvalidJSON {
            return ListManufacturersDataManagerGetResult.Failure(error: JSONParserError.InvalidJSON)
        }catch{
            return ListManufacturersDataManagerGetResult.Failure(error: JSONParserError.InvalidJSON)
        }
    }

    /// Get Manufacturer list from JSON Dictionary
    private func getManufacturesFromDictionary(_ jsonDictionary:[String:Any]?) -> [Manufacturer]? {
        var manufacturerList = [Manufacturer]()
        guard let manufacturers = jsonDictionary?["wkda"] as? [String:String] else {
            return nil
        }
        
        for (id, name) in manufacturers {
            manufacturerList.append(Manufacturer(id: id, name: name))
        }
        
        return manufacturerList
    }
    
}
