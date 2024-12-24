//
//  NetworkRouter.swift
//  UserList
//
//  Created by mohamed hassan on 24/12/2024.
//

import Alamofire
import SwiftUI
enum NetworkRouter: URLRequestConvertible {
    // MARK: - Endpoints
    case getUsersList
 
    // MARK: - Properties
    var method: HTTPMethod {
        switch self {
        case .getUsersList:
            return .get
     
        }
    }
    var path: String {
        switch self {
        case .getUsersList:
            return Config.EndpointPath.getUsers
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
 
        default:
            return nil
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getUsersList:
            return NetworkDefaults.defaults.headersWithJsonEncode
        }
    }
    
    // MARK: - Methods
    func asURLRequest() throws -> URLRequest {
        let baseURL = Config.baseURL
        let url = try baseURL.asURL().appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        // Set headers from the headers variable
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Encode parameters
        if let parameters = parameters {
            switch self {
            case .getUsersList:
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            }
        }
        
        return urlRequest
    }
}
