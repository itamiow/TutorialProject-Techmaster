//
//  AuthAPIService.swift
//  TutorialProject
//
//  Created by USER on 05/06/2023.
//

import Foundation
//import Alamofire
//protocol AuthAPIService {
//    func login(username: String,
//               password: String,
//               success: ((LoginEntity) -> Void)?,
//               failure: ((String?) -> Void?))
//}
//class AuthAPIServiceImpl: AuthAPIService {
//    func login(username: String,
//               password: String,
//               success: ((LoginEntity) -> Void)?,
//               failure: ((String?) -> Void?)){
//        // nhiệm vụ call API len server
//        AF.request("https://learn-api-3t7z.onrender.com/login", method: .post, parameters: [
//            "username": username,
//            "password": password], encoder: JSONParameterEncoder.default).validate(statusCode: 200..<300).responseDecodable(of: LoginEntity.self) {response in
//            switch response.result {
//            case.success(let entity):
//                // case API success
//                success?(entity)
//            case.failure(let error):
//                 case API failure
//                failure?(error.failureReason) // tạm . chưa xử lý lỗi
//            }
//        }
//    }
//}
