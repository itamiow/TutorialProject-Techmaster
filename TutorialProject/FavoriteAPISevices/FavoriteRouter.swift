//
//  FavoriteRouter.swift
//  TutorialProject
//
//  Created by USER on 18/06/2023.
//

import Foundation
import Alamofire
import KeychainSwift
enum FavoriteRouther: URLRequestConvertible {
    case index(page: Int, pageSize: Int)
    var baseURL: URL {
        return URL(string: NetWorkConstant.domain)!
    }
    var method: HTTPMethod {
        return.get
    }
    var paramester: Parameters? {
        switch self {
        case .index(let page, let pageSize):
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
        request = try URLEncoding.default.encode(request, with: paramester)
        return request
    }
}
