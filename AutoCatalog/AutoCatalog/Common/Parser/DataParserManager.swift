//
//  DataParserManager.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import Foundation

enum JSONParserError:Error {
    case InvalidJSON
    case Unknown
}

protocol JSONParserProtocol {

    func parseData(data:Data) throws -> [String:AnyObject]
}

class DataParserManager: JSONParserProtocol {
    
    func parseData(data: Data) throws -> [String:AnyObject] {
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? [String:AnyObject]
            if let data = dictionary {
                return data
            }
            else{
                throw JSONParserError.InvalidJSON
            }
        } catch {
            throw JSONParserError.Unknown
        }
    }
}
