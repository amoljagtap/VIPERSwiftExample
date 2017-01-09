//
//  ServiceManager+Models.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit

extension AutoNetworkServices {

    func getModelsQueryURL(manufacturer:String, page:Int?, pageSize:Int?) -> URL? {
        if let queryURL = URL(string: baseURL)?.appendingPathComponent(apiVersion).appendingPathComponent(EndPoints.GetModelsURL) {
            var urlComp = self.getURLParameters(url: queryURL, page: page, pageSize: pageSize)
            urlComp?.queryItems?.append(URLQueryItem(name: "manufacturer", value: manufacturer))
            return urlComp?.url
        }
        return nil
    }

    func getAutoModelsList(manufacturer: String, page: Int, pageSize: Int, completionHandler: @escaping (Data?, Error?) -> ()) {
        if let url = getModelsQueryURL(manufacturer:manufacturer, page: page, pageSize: pageSize) {
            urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
                completionHandler(data, error)
            }).resume()
        }
    }
}
