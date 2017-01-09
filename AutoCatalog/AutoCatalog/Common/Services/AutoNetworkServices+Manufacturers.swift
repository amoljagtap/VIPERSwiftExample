//
//  ServiceManager+Manufacturers.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit

extension AutoNetworkServices {
    
    func getAutoManufacturerList(page: Int, pageSize: Int, completionHandler: @escaping (Data?, Error?) -> ()) {
        if let url = getManufacturerQueryURL(page: page, pageSize: pageSize) {
            urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
                completionHandler(data, error)
            }).resume()
        }
    }

    func getManufacturerQueryURL(page:Int?, pageSize:Int?) -> URL? {
        if let queryURL = URL(string: baseURL)?.appendingPathComponent(apiVersion).appendingPathComponent(EndPoints.GetManufacturerURL) {
            let urlComp = self.getURLParameters(url: queryURL, page: page, pageSize: pageSize)
            return urlComp?.url
        }
        return nil
    }
    
}


