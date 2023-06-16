//
//  AuthRepository.swift
//  TutorialProject
//
//  Created by USER on 05/06/2023.
//

import Foundation
import Alamofire


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
    func logout(success: ((LogoutEntity) -> Void)?,
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
    func logout(success: ((LogoutEntity) -> Void)?, failure: ((String?) -> Void)?) {
        
    }
    
}

