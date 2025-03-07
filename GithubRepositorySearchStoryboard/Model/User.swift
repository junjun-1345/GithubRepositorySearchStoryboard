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
    let description: String?
    let html_url: URL
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case description
        case html_url
    }
    
    init(login: String, avatarURL: URL, description: String, html_url: URL) {
        self.login = login
        self.avatarURL = avatarURL
        self.description = description
        self.html_url = html_url
    }
}
