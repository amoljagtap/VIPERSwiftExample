//
//  ServiceManager.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit

protocol AutoNetworkServicesProtocol {
    func getAutoManufacturerList(page:Int, pageSize:Int, completionHandler:@escaping (Data?, Error?)->())
    func getAutoModelsList(manufacturer:String, page:Int, pageSize:Int, completionHandler:@escaping (Data?, Error?)->())
}

protocol APIVersionProtocol {
    var baseURL:String { get }
    var apiVersion:String { get }
    var apiKey:String { get }
}

class AutoNetworkServices: APIVersionProtocol, AutoNetworkServicesProtocol {

    static let sharedInstace = AutoNetworkServices()
    let urlSession:URLSession

    var baseURL:String { return "http://api.wkda-test.com" }
    var apiVersion:String { return "v1" }
    var apiKey:String { return "coding-puzzle-client-449cc9d" }
    
   
    init(urlSession:URLSession = URLSession.getDefaultSession()) {
        self.urlSession = urlSession
    }
    
    struct EndPoints {
        static let GetManufacturerURL = "car-types/manufacturer"
        static let GetModelsURL = "car-types/main-types"
    }
    
    
    func getURLParameters(url:URL, page:Int?, pageSize:Int?) -> URLComponents? {
        var urlComp = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "wa_key", value: apiKey))
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: String(describing: page)))
        }
        if let pageSize = pageSize {
            queryItems.append(URLQueryItem(name: "pageSize", value: String(describing: pageSize)))
        }
        urlComp?.queryItems = queryItems
        return urlComp
    }
}
