//
//  NetWorkConstant.swift
//  TutorialProject
//
//  Created by USER on 07/06/2023.
//

import Foundation
import Alamofire

struct NetWorkConstant {
    static var domain = "https://learn-api-3t7z.onrender.com"
}



struct APIError {
    var errorCode: String?
    var errorMsg: String?
    var errorKey: String?

    static func from(afError: AFError) -> APIError {
        return APIError(errorMsg: afError.errorDescription)
    }
}
