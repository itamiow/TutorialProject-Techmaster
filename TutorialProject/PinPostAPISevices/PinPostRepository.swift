//
//  PinPostRepository.swift
//  TutorialProject
//
//  Created by USER on 18/06/2023.
//

import Foundation
import Alamofire


protocol PinPostRepository {
    func index(page: Int,
               pageSize: Int,
               success: ((ArrayResponse<PostGetEntity>) -> Void)?,
               failure: ((APIError?) -> Void)?)
}

class PinPostRepositoryImpl: PinPostRepository {
    var apiService: PinPostAPIService
    
    init(apiService: PinPostAPIService) {
        self.apiService = apiService
    }
    
    func index(page: Int,
               pageSize: Int,
               success: ((ArrayResponse<PostGetEntity>) -> Void)?, failure: ((APIError?) -> Void)?) {
        apiService.index(page: page, pageSize: pageSize, success: success, failure: failure)
    }
}
