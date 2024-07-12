//
//  Session.swift
//  GithubRepositorySearchStoryboard
//
//  Created by 大野純平 on 2024/07/10.
//

import Foundation

final class Session {
    private let additionalHeaderFields: () -> [String: String]?
    private let session: URLSession
    
    //     イニシャライザ = { nil }でデフォルトの値を定義
    init(additionalHeaderFields: @escaping () -> [String: String]? = { nil }, session: URLSession = .shared) {
        self.additionalHeaderFields = additionalHeaderFields
        self.session = session
    }
    
    //     @discardableResult: 戻り値を無視しても警告が出ないようにします。
    @discardableResult
    func send<T: Request>(_ request: T, completion: @escaping (Result<T.Response>) -> ()) -> URLSessionTask? {
        let url = request.baseURL.appendingPathComponent(request.path)
        
        //         baseURLとpathを組み合わせて完全なURLを作成します。
        
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(SessionError.failedToCreateComponents(url)))
            return nil
        }
        
        //        URLComponentsを使用してURLを解析し、クエリパラメータを追加
        components.queryItems = request.queryParameters?.compactMap(URLQueryItem.init)
        
        //        URLRequestオブジェクトを作成し、HTTPメソッドを設定
        guard var urlRequest = components.url.map({ URLRequest(url: $0) }) else {
            completion(.failure(SessionError.failedToCreateURL(components)))
            return nil
        }
        
        urlRequest.httpMethod = request.method.rawValue
        
        //        リクエストのヘッダーフィールドに追加のヘッダーをマージ
        let headerFields: [String: String]
        if let additionalHeaderFields = additionalHeaderFields() {
            headerFields = request.headerFields.merging(additionalHeaderFields, uniquingKeysWith: +)
        } else {
            headerFields = request.headerFields
        }
        urlRequest.allHTTPHeaderFields = headerFields
        
        
        //        データタスク（data task）は、iOSおよびmacOSのURLSession APIを使用してHTTPリクエストを非同期に送信し、レスポンスとしてデータを受信するためのタスク
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(SessionError.noResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(SessionError.noData(response)))
                return
            }
            
            guard  200..<300 ~= response.statusCode else {
                let message = try? JSONDecoder().decode(SessionError.Message.self, from: data)
                completion(.failure(SessionError.unacceptableStatusCode(response.statusCode, message)))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.Response.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }
        
        //        データタスクの開始
        task.resume()
        
        return task
    }
}

enum SessionError: Error {
    case noData(HTTPURLResponse)
    case noResponse
    case unacceptableStatusCode(Int, Message?)
    case failedToCreateComponents(URL)
    case failedToCreateURL(URLComponents)
}

extension SessionError {
    struct Message: Decodable {
        let documentationURL: URL
        let message: String
        
        private enum CodingKeys: String, CodingKey {
            case documentationURL = "documentation_url"
            case message
        }
    }
}
