//
//  User.swift
//  GithubRepositorySearchStoryboard
//
//  Created by 大野純平 on 2024/07/10.
//

import Foundation

struct Repository: Codable {
    let name: String
    let description: String?
    let html_url: URL
    
    private enum CodingKeys: String, CodingKey {
        case name
        case description
        case html_url
    }
    
    init(name: String, description: String, html_url: URL) {
        self.name = name
        self.description = description
        self.html_url = html_url
    }
}
