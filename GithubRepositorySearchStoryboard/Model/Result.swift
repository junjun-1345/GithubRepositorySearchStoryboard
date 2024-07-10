//
//  Result.swift
//  GithubRepositorySearchStoryboard
//
//  Created by 大野純平 on 2024/07/10.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
