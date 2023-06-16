//
//  PostEntity.swift
//  TutorialProject
//
//  Created by USER on 14/06/2023.
//

import Foundation


struct PostGetEntity: Decodable {
    let title: String?
    let content: String?
    let address: String?
    let author: AuthorEntity?
    let createdat: String?
    let updatedat: String
    let id: String?
    enum CodingKeys: String, CodingKey {
        case title
        case content
        case address
        case id
        case author
        case createdat = "created_at"
        case updatedat = "updated_at"
    }
}

struct AuthorEntity: Decodable {
    let username: String?
    let createdat: String?
    let updatedat: String?
    let profile: ProfileEntity
    let id: String?
    let isadmin: Bool
    enum CodingKeys: String, CodingKey {
        case username, profile, id
        case createdat = "created_at"
        case updatedat = "updated_at"
        case isadmin = "is_admin"
    }
}
struct ProfileEntity: Decodable {
    let bio: String?
    let gender: String?
    let avatar: String?
    let createdat: String?
    let updatedat: String?
    enum CodingKeys: String, CodingKey {
        case bio, gender, avatar
        case createdat = "created_at"
        case updatedat = "updated_at"
    }
}
