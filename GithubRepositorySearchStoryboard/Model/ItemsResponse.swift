//
//  ItemsResponse.swift
//  GithubRepositorySearchStoryboard
//
//  Created by 大野純平 on 2024/07/10.
//

import Foundation

struct ItemsResponse<Item: Decodable>: Decodable {
    let items: [Item]
    
    init(items: [Item]) {
        self.items = items
    }
}
