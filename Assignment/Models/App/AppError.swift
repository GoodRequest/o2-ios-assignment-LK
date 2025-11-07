//
//  AppError.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 05/11/2025.
//

import Foundation
import Alamofire

enum AppError: Hashable, LocalizedError {
    
    case afError(AFError)
    case dataDecodingError(DecodingError)
    case activationCardError
    case unknownError(Error)
    case unknownErrorMessage(String)
    
    var message: String {
        switch self {
        case .afError(let error):
            return error.localizedDescription
        case .dataDecodingError(let error):
            return error.localizedDescription
        case .activationCardError:
            return L10n.failedToActivateCoupon
        case .unknownError(let error):
            return error.localizedDescription
        case .unknownErrorMessage(let message):
            return message
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .afError(let error):
            return error.recoverySuggestion
        case .dataDecodingError(let error):
            return error.recoverySuggestion
        case .activationCardError:
            return L10n.yourAppVersionIsLowerThanRequiredForCardActivationPleaseUpdateToTheLatestVersion
        case .unknownError(let error):
            return error.localizedDescription
        case .unknownErrorMessage(let message):
            return message
        }
    }
    
    public var errorDescription: String? {
        message
    }
    
    public static func ==(lhs: AppError, rhs: AppError) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: type(of: self)))

        switch self {
        case let .afError(error):
            hasher.combine(error.localizedDescription)

        case let .dataDecodingError(error):
            hasher.combine(error.localizedDescription)
            
        case .activationCardError:
            break
            
        case let .unknownError(error):
            hasher.combine(error.localizedDescription)

        case let .unknownErrorMessage(message):
            hasher.combine(message)
        }
    }

}
