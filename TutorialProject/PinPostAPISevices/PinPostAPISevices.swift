//
//  PinPostAPISevices.swift
//  TutorialProject
//
//  Created by USER on 18/06/2023.
//

import Foundation
import Alamofire
protocol PinPostAPIService {
    func index(page: Int,
               pageSize: Int,
               success: ((ArrayResponse<PostGetEntity>) -> Void)?,
               failure: ((APIError?) -> Void)?)
}

class PinPostAPIServiceImpl: PinPostAPIService {
    func index(page: Int,
               pageSize: Int,
               success: ((ArrayResponse<PostGetEntity>) -> Void)?,
               failure: ((APIError?) -> Void)?) {
        let router = PinPostRouther.index(page: page, pageSize: pageSize)
        
        AF.request(router)
            .cURLDescription { description in
                print(description)
            }
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ArrayResponse<PostGetEntity>.self) { response in
            switch response.result {
            case .success(let entity):
                success?(entity)
            case .failure(let afError):
                failure?(APIError.from(afError: afError))
            }
        }
    }
}
