//
//  API.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-02.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public enum Response<T> {
    case success(T?)
    case failure(String?)
}

public class API {
    
    public enum Version: String {
        case v2 = "https://api.digitalocean.com/v2/"
    }
    
    public let version:  Version
    public let token:    String
    
    private let apiRoot: URL
    private let session: URLSession
    private let queue:   OperationQueue
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public convenience init(version: Version, token: String) {
        
        let queue   = OperationQueue()
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: queue)
        
        self.init(version: version, token: token, session: session, queue: queue)
    }
    
    internal init(version: Version, token: String, session: URLSession, queue: OperationQueue) {
        self.version = version
        self.token   = token
        self.session = session
        self.queue   = queue
        self.apiRoot = URL(string: self.version.rawValue)!
    }
    
    // ----------------------------------
    //  MARK: - URL Generation -
    //
    private func urlTo(endpoint: Endpoint) -> URL {
        return URL(string: endpoint.rawValue, relativeTo: self.apiRoot)!
    }
    
    // ----------------------------------
    //  MARK: - Request Generation -
    //
    internal func requestTo(endpoint: Endpoint, method: Method) -> URLRequest {
        var request        = URLRequest(url: self.urlTo(endpoint: endpoint))
        request.httpMethod = method.rawValue
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    // ----------------------------------
    //  MARK: - Request Execution -
    //
    internal func taskWith<T: JsonCreatable>(request: URLRequest, keyPath: String, completion: @escaping (Response<T>) -> Void) -> URLSessionDataTask {
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
                let value: T?
                
                if let data = data,
                    var json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    
                    let components = keyPath.components(separatedBy: ".")
                    for component in components {
                        json = json[component] as! [String: Any]
                    }
                    
                    value = T(json: json)
                } else {
                    value = nil
                }
                
                completion(.success(value))
                
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

