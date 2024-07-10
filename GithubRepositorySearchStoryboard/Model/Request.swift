//
//  Request.swift
//  GithubRepositorySearchStoryboard
//
//  Created by 大野純平 on 2024/07/10.
//

import Foundation

protocol Request {
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    var method: HttpMethod { get }
    var path: String { get }
    var headerFields: [String: String] { get }
    var queryParameters: [String: String]? { get }
}

extension Request {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var headerFields: [String: String] {
        return ["Accept": "application/json"]
    }
    
    var queryParameters: [String: String]? {
        return nil
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}
