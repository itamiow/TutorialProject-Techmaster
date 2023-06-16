//
//  PostRouter.swift
//  TutorialProject
//
//  Created by USER on 14/06/2023.
//

import Foundation
import Alamofire
import KeychainSwift

enum PostRouter: URLRequestConvertible {
    
    case getPost(page: Int, pageSize: Int)
    
    var baseURL: URL {
        let homeURLString = NetWorkConstant.domain + "/posts"
        return URL(string: homeURLString)!
    }
    var method: HTTPMethod {
        return .get
    }
    var parameters: Parameters? {
        switch self {
        case .getPost(let page, let pageSize):
            return ["page": page, "pageSize": pageSize]
        }
    }
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.method = method
        if AuthService.share.isLoggedIn {
            let accessToken = AuthService.share.accessToken
            request.setValue(String(format: "Bearer %@", accessToken), forHTTPHeaderField: "Authorization")
        }
        request = try URLEncoding.default.encode(request, with: parameters)
        return request
    }
}
