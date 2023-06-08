//
//  AuthRepository.swift
//  TutorialProject
//
//  Created by USER on 05/06/2023.
//

import Foundation
import Alamofire

/**
 AuthAPISerivce.swift
 */
protocol AuthAPISerivce {
    func login(username: String,
               password: String,
               success: ((LoginEntity) -> Void)?,
               failure: ((String?) -> Void)?)
    
    func register(username: String,
                  nickname: String,
                  password: String,
                
                  success: ((RegisterEntity) -> Void)?,
                  failure: ((String?) -> Void)?)
}

class AuthAPISerivceImpl: AuthAPISerivce {
    func login(username: String,
               password: String,
               success: ((LoginEntity) -> Void)?,
               failure: ((String?) -> Void)?) {
        /// Nhiệm vụ call API lên server.
        AF.request("https://learn-api-3t7z.onrender.com/login",
                   method: .post,
                   parameters: [
                    "username": username,
                    "password": password
                   ],
                   encoder: JSONParameterEncoder.default)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: LoginEntity.self) { response in
            switch response.result {
            case .success(let entity):
                /// Case API successs
                success?(entity)
            case .failure(let error):
                /// Case API failure
                failure?(error.failureReason) // Tạm. Chưa xử lý lỗi
            }
        }
    }
    
    func register(username: String,
                  nickname: String,
                  password: String,
                  success: ((RegisterEntity) -> Void)?,
                  failure: ((String?) -> Void)?) {
        AF.request("https://learn-api-3t7z.onrender.com/register",
                   method: .post,
                   parameters: [
                    "username": username,
                    "nickname": nickname,
                    "password": password,
                   ],
                   encoder: JSONParameterEncoder.default)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: RegisterEntity.self) { response in
            switch response.result {
            case .success(let entity): success?(entity)
            case .failure(let error): failure?(error.failureReason)
            }
        }
    }
}

/**
 AuthRepository.swift
 */
protocol AuthRepository {
    /**
     username:
     password
     success closure dùng để pass data sau khi call API success
     failure closure dùng để pass data khi call API lỗi
     */
    func login(username: String,
               password: String,
               success: ((LoginEntity) -> Void)?,
               failure: ((String?) -> Void)?)
    
    
    func register(username: String,
                  nickname: String,
                  password: String,
                  success: ((RegisterEntity) -> Void)?,
                  failure: ((String?) -> Void)?) 
}



class AuthRepositoryImpl: AuthRepository {

    
    var authApiService: AuthAPISerivce
    
    init(authApiService: AuthAPISerivce) {
        self.authApiService = authApiService
    }
    func login(username: String,
               password: String,
               success: ((LoginEntity) -> Void)?,
               failure: ((String?) -> Void)?) {
        authApiService.login(username: username, password: password, success: success, failure: failure)
    }
    func register(username: String,
                  nickname: String,
                  password: String,
                  success: ((RegisterEntity) -> Void)?,
                  failure: ((String?) -> Void)?) {
        authApiService.register(username: username, nickname: nickname, password: password, success: success, failure: failure)
    }
    
}

