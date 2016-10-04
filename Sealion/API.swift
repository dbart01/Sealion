//
//  API.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-02.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public class API {
    
    typealias Parameters = [String : String]
    
    public enum Version: String {
        case v2 = "https://api.digitalocean.com/v2/"
    }
    
    public let version:  Version
    public let token:    String
    
    private let apiRoot: URL
    private let session: URLSession
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public convenience init(version: Version, token: String) {
        self.init(version: version, token: token)
    }
    
    internal init(version: Version, token: String, session: URLSession? = nil) {
        self.version = version
        self.token   = token
        self.apiRoot = URL(string: self.version.rawValue)!
        
        if let session = session {
            self.session = session
        } else {
            self.session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue())
        }
    }
    
    // ----------------------------------
    //  MARK: - URL Generation -
    //
    private func urlTo(endpoint: Endpoint, parameters: Parameters? = nil) -> URL {
        let url        = URL(string: endpoint.path, relativeTo: self.apiRoot)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        if let parameters = parameters {
            var items = [URLQueryItem]()
            for (name, value) in parameters {
                items.append(URLQueryItem(name: name, value: value))
            }
            components.queryItems = items
        }
        
        return components.url!
    }
    
    // ----------------------------------
    //  MARK: - Request Generation -
    //
    internal func requestTo(endpoint: Endpoint, method: Method, parameters: Parameters? = nil, payload: JsonConvertible? = nil) -> URLRequest {
        var request        = URLRequest(url: self.urlTo(endpoint: endpoint, parameters: parameters))
        request.httpMethod = method.rawValue
        
        if let payload = payload {
            request.httpBody = try! JSONSerialization.data(withJSONObject: payload.json, options: [])
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    // ----------------------------------
    //  MARK: - Request Execution -
    //
    internal func taskWith<T: JsonCreatable>(request: URLRequest, keyPath: String, completion: @escaping (Result<T>) -> Void) -> URLSessionDataTask {
        
        return self.taskWith(request: request, keyPath: keyPath) { result in
            switch result {
            case .success(let json):
                
                var object: T?
                if let json = json {
                    object = T(json: json as! JSON)
                }
                completion(.success(object))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    internal func taskWith<T: JsonCreatable>(request: URLRequest, keyPath: String, completion: @escaping (Result<[T]>) -> Void) -> URLSessionDataTask {
        
        return self.taskWith(request: request, keyPath: keyPath) { result in
            switch result {
            case .success(let json):
                
                var collection: [T]?
                if let json = json as? [JSON] {
                    collection = json.map {
                        T(json: $0)
                    }
                }
                completion(.success(collection))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    internal func taskWith(request: URLRequest, keyPath: String, completion: @escaping (Result<Any>) -> Void) -> URLSessionDataTask {
        return self.session.dataTask(with: request) { (data, response, error) in
            
            /* ---------------------------------
             ** We always expect to get back an
             ** HTTPURLResponse since we can be
             ** relying on the statusCode of the
             ** response.
             */
            guard let response = response as? HTTPURLResponse else {
                fatalError("Failed to parse API response. Response is not of class HTTPURLResponse.")
            }
            
            /* ------------------------------------
             ** Use the response codes to determine
             ** whether the request succeeded or not.
             */
            if response.successful {
                
                /* -----------------------------
                 ** Parse the body JSON if it is
                 ** not nil.
                 */
                if let data = data,
                    var json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    
                    let components = keyPath.components(separatedBy: ".")
                    for component in components {
                        json = (json as! JSON)[component]
                    }
                    
                    completion(.success(json))
                } else {
                    completion(.success(nil))
                }
                
            } else {
                completion(.failure(error?.localizedDescription))
            }
        }
    }
}

// ----------------------------------
//  MARK: - HTTPURLResponse -
//
extension HTTPURLResponse {
    var successful: Bool {
        return (self.statusCode / 100) == 2
    }
}

