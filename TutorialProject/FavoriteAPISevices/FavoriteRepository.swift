//
//  FavoriteRepository.swift
//  TutorialProject
//
//  Created by USER on 18/06/2023.
//

import Foundation
import Alamofire

protocol FavoritePostRepository {
    func index(page: Int,
               pageSize: Int,
               success: ((ArrayResponse<PostGetEntity>) -> Void)?,
               failure: ((APIError?) -> Void)?)
}

class FavoritePostRepositoryImpl: FavoritePostRepository {
    var apiService: FavoritePostAPIService
    
    init(apiService: FavoritePostAPIService) {
        self.apiService = apiService
    }
    
    func index(page: Int,
               pageSize: Int,
               success: ((ArrayResponse<PostGetEntity>) -> Void)?, failure: ((APIError?) -> Void)?) {
        apiService.index(page: page, pageSize: pageSize, success: success, failure: failure)
    }
    
}
