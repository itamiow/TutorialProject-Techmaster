//
//  AuthRouter.swift
//  TutorialProject
//
//  Created by USER on 07/06/2023.
//

import Foundation
import Alamofire

enum AuthRouter: URLRequestConvertible {
    case login(body: Parameters)
    case register(body: Parameters)
    case logout
    
    var baseURL: URL {
        return URL(string: NetWorkConstant.domain)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .register:
            return .post
        case .logout:
            return .delete
        }
    }
    var path: String {
        switch self {
        case .login:
            return "login"
        case .register:
            return "register"
        case .logout:
            return "logout"
        }
    }
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathExtension(path)
        var request = URLRequest(url: url)
        request.method = method
        
        switch self {
        case .login(let parameters):
            request = try JSONEncoding.default.encode(request, with: parameters)
        case .register(let parameters):
            request = try JSONEncoding.default.encode(request, with: parameters)
        case .logout:
            request = try JSONEncoding.default.encode(request, with: nil)
        }
        request.timeoutInterval = 30 // 30s
        return request
        
    }
    
}
