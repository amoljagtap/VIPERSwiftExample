//
//  URLSessionProtocol.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(with: URL, completionHandler: DataTaskResult) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol{
    
    class func getDefaultSession() -> URLSession{
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: sessionConfiguration)
    }
        
    func dataTask(with: URL, completionHandler: (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return dataTask(with: with, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
    
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }

