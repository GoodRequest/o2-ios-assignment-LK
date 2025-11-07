//
//  RequestBuilder.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 05/11/2025.
//

import Alamofire
import Foundation

struct RequestBuilder<ResultType: Decodable> {
    
    let url: String
    private var method: HTTPMethod
    private var headers: HTTPHeaders?
    private var params: Parameters?
    private var paramsEncoding: ParameterEncoding?
    private var session: Session
    private var emptyResponseCodes: Set<Int>?
    private var emptyRequestMethods: Set<HTTPMethod>?
    
    init(url: String, session: Session, method: HTTPMethod) {
        self.url = url
        self.session = session
        self.method = method
    }
    
    func headers(_ headers: HTTPHeaders) -> RequestBuilder {
        var request = self
        request.headers = headers
        return request
    }
    
    func params(_ params: Parameters, encoding: ParameterEncoding = URLEncoding.default) -> RequestBuilder {
        var request = self
        request.params = params
        request.paramsEncoding = encoding
        return request
    }
    
    func emptyResponseCodes(_ codes: Set<Int>) -> RequestBuilder {
        var request = self
        request.emptyResponseCodes = codes
        return request
    }
    
    func emptyRequestMethods(_ methods: Set<HTTPMethod>) -> RequestBuilder {
        var request = self
        request.emptyRequestMethods = methods
        return request
    }
    
    func build() async throws(AppError) -> ResultType {
        let base = session.request(
            url,
            method: method,
            parameters: params,
            encoding: paramsEncoding ?? JSONEncoding.default,
            headers: headers
        )
     
        do {
            let data = try await base.validate()
                .serializingData()
                .value
            
            let value = try JSONDecoder().decode(ResultType.self, from: data)
            return value
        } catch let error as AFError {
            throw .afError(error)
        } catch let error as DecodingError {
            throw .dataDecodingError(error)
        } catch {
            throw .unknownError(error)
        }
    }
    
}
