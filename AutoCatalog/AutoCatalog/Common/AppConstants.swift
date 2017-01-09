//
//  AppConstants.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/9/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import Foundation

enum DataManagerError:Error {
    case EmptyData
}

enum NetworkError:Error {
    case NoInternet
    case HostUnReachable
    case Unknown
    
    static func getError(_ error:Error) -> NetworkError {
        let code = (error as NSError).code
        if code == URLError.notConnectedToInternet.rawValue {
            return NetworkError.NoInternet
        }
        else if code == URLError.cannotConnectToHost.rawValue {
            return NetworkError.HostUnReachable
        }else {
            return NetworkError.Unknown
        }
    }
}

enum AppError: Error {
    case EmptyData
    case InvalidData
    case NoInternet
    case HostUnreachable
    case Unknown

    static func getErrorType(_ error:Error?) -> AppError {
        guard let error = error else {
            return AppError.Unknown
        }
        if error is NetworkError {
            switch error {
            case NetworkError.NoInternet:
                return AppError.NoInternet
            case NetworkError.HostUnReachable:
                return AppError.HostUnreachable
            case NetworkError.Unknown:
                return AppError.Unknown
            default:
                break
            }
        }else if (error is DataManagerError){
            return AppError.EmptyData
        }else if (error is JSONParserError){
            switch error {
            case JSONParserError.InvalidJSON:
                return AppError.InvalidData
            case JSONParserError.Unknown:
                return AppError.InvalidData
            default:
                break
            }
        }
        return AppError.Unknown
    }
}
