//
//  PostGetPepository.swift
//  TutorialProject
//
//  Created by USER on 14/06/2023.
//

import Foundation
import Alamofire

protocol PostgetRepository {
    func postgetReposi(page: Int,
                       pageSize: Int,
                       success: ((ArrayResponse<PostGetEntity>) -> Void)?,
                       failure: ((APIError?) -> Void)?)
}


class PostRepositoryImpl: PostgetRepository {
    
    var postAPISevece: PostgetAPISerivce
    init(postAPISevece: PostgetAPISerivce) {
        self.postAPISevece = postAPISevece
    }
    func postgetReposi(page: Int,
                       pageSize: Int,
                       success: ((ArrayResponse<PostGetEntity>) -> Void)?,
                       failure: ((APIError?) -> Void)?) {
        postAPISevece.postget(page: page, pageSize: pageSize, success: success, failure: failure)
    }
}
