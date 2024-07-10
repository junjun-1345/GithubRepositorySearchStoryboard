//
//  User.swift
//  GithubRepositorySearchStoryboard
//
//  Created by 大野純平 on 2024/07/10.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarURL: URL
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
    
    init(login: String, avatarURL: URL) {
        self.login = login
        self.avatarURL = avatarURL
    }
}
