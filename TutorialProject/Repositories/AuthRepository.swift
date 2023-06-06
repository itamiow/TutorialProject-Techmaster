//
//  AuthRepository.swift
//  TutorialProject
//
//  Created by USER on 05/06/2023.
//

import Foundation

protocol AuthRepository {
    
    /**
      username
     password
     success closure dùng để pass data sau khi call API success
     failure closure dùng để pass data khi call API lỗi
      */
    func login(username: String,
               password: String,
               success: ((LoginEntity) -> Void)?,
               failure: ((String?) -> Void?))
}
class AuthRepositoryImpl: AuthRepository {
    var authAPIService: AuthAPIService
    init(authAPIService: AuthAPIService) {
        self.authAPIService = authAPIService
    }
    func login(username: String,
               password: String,
               success: ((LoginEntity) -> Void)?,
               failure: ((String?) -> Void?)){
        authAPIService.login(username: username, password: password, success: success, failure: failure)
    }
}

