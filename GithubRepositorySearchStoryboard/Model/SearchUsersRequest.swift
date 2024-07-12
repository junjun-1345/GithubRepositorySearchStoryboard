//
//  SearchUsersRequest.swift
//  GithubRepositorySearchStoryboard
//
//  Created by 大野純平 on 2024/07/10.
//

import Foundation

struct SearchRepositoriesRequest: Request {
    typealias Response = ItemsResponse<Repository>
    
    let method: HttpMethod = .get
    let path = "/search/repositories"
    
    var queryParameters: [String: String]? {
        let params: [String: String] = ["q": query]
        return params
    }
    
    let query: String
    
    init(query: String) {
        self.query = query
    }
}
