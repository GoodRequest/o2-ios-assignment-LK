//
//  Endpoint.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import Alamofire

enum ApiServer: Equatable {
    
    case production
    
    public var domain: String {
        switch self {
        case .production:
            return "https://api.o2.sk"
        }
    }
    
}

enum Endpoint {
    
    case cardActivation
    
    var path: String {
        switch self {
        case .cardActivation:
            return "/version"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .cardActivation:
            return .get
        }
    }
    
}

