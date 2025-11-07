//
//  RequestManager.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 04/11/2025.
//

import Foundation
import Alamofire

final class RequestManager: RequestManagerType {
        
    private let session: Session
    private let server: ApiServer
    
    init(server: ApiServer) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        
        self.session = Session(configuration: configuration)
        self.server = server
    }
            
    func activateCard(code: String) async throws(AppError) -> Version? {
        let response: VersionResponse = try await requestBuilder(endpoint: .cardActivation)
            .params(["code": code])
            .build()
        
        return Version(response: response)
    }
    
}


// Mark: - Request Builder

extension RequestManager {
    
    func requestBuilder<ResultType: Decodable>(endpoint: Endpoint) -> RequestBuilder<ResultType> {
        RequestBuilder(
            url: server.domain.appending(endpoint.path),
            session: session,
            method: endpoint.method
        )
    }
    
}


