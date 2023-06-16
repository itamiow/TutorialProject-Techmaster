//
//  PostAPISever.swift
//  TutorialProject
//
//  Created by USER on 14/06/2023.
//

import Foundation
import Alamofire

protocol PostgetAPISerivce {
    func postget(page: Int,
               pageSize: Int,
               success: ((ArrayResponse<PostGetEntity>) -> Void)?,
               failure: ((APIError?) -> Void)?)
}
class PostGetAPISerivceImpl: PostgetAPISerivce {
    func postget(page: Int,
                 pageSize: Int,
                 success: ((ArrayResponse<PostGetEntity>) -> Void)?,
                 failure: ((APIError?) -> Void)?) {
        let router = PostRouter.getPost(page: page, pageSize: pageSize)
        /// Nhiệm vụ call API lên server.
        AF.request(router)
            .cURLDescription() {
                description in
                print(description)
            }
        .validate(statusCode: 200..<300)
        .responseDecodable(of: ArrayResponse<PostGetEntity>.self) { response in
            switch response.result {
            case .success(let entity):
                /// Case API successs
                success?(entity)
            case .failure(let afError):
                /// Case API failure
                failure?(APIError.from(afError: afError)) 
            }
        }
    }
}
