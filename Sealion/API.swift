//
//  API.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-02.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public class API {
    
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
        self.init(version: version, token: token, session: nil)
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
    internal func urlTo(endpoint: Endpoint, page: Page? = nil, parameters: ParameterConvertible? = nil) -> URL {
        let url        = URL(string: endpoint.path, relativeTo: self.apiRoot)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        var p: ParameterConvertible = [:]
        p = p.combineWith(convertible: page)
        p = p.combineWith(convertible: parameters)
        
        let finalParameters = p.parameters
        if !finalParameters.isEmpty {
            var items = [URLQueryItem]()
            for (name, value) in finalParameters {
                items.append(URLQueryItem(name: name, value: value))
            }
            components.queryItems = items
        }
        
        return components.url!
    }
    
    // ----------------------------------
    //  MARK: - Request Generation -
    //
    internal func requestTo(endpoint: Endpoint, method: Method, page: Page? = nil, parameters: ParameterConvertible? = nil, payload: JsonConvertible? = nil) -> URLRequest {
        
        var request        = URLRequest(url: self.urlTo(endpoint: endpoint, page: page, parameters: parameters))
        request.httpMethod = method.rawValue
        
        if let payload = payload {
            request.httpBody = try! JSONSerialization.data(withJSONObject: payload.json, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    // ----------------------------------
    //  MARK: - Result Mapping -
    //
    internal func mapModelFrom<T: JsonCreatable>(_ json: Any?) -> T? {
        var object: T?
        if let json = json {
            object = T(json: json as! JSON)
        }
        return object
    }
    
    internal func mapModelCollectionFrom<T: JsonCreatable>(_ json: Any?) -> [T]? {
        var collection: [T]?
        if let json = json as? [JSON] {
            collection = json.map {
                T(json: $0)
            }
        }
        return collection
    }
    
    // ----------------------------------
    //  MARK: - Request Execution -
    //
    internal func taskWith<T: JsonCreatable>(
        request:     URLRequest,
        keyPath:     String? = nil,
        pollHandler: ((Result<T>) -> Bool)? = nil,
        completion:  @escaping (Result<T>) -> Void
        ) -> Handle<T> {
        
        return self.taskWith(request: request, keyPath: keyPath, transformer: API.mapModelFrom(self), pollHandler: pollHandler, completion: completion)
    }
    
    internal func taskWith<T: JsonCreatable>(
        request:     URLRequest,
        keyPath:     String? = nil,
        pollHandler: ((Result<[T]>) -> Bool)? = nil,
        completion:  @escaping (Result<[T]>) -> Void
        ) -> Handle<[T]> {
        
        return self.taskWith(request: request, keyPath: keyPath, transformer: API.mapModelCollectionFrom(self), pollHandler: pollHandler, completion: completion)
    }
    
    internal func taskWith<T>(
        request:     URLRequest,
        keyPath:     String? = nil,
        transformer: @escaping ((Any) -> T?),
        pollHandler: ((Result<T>) -> Bool)? = nil,
        completion:  @escaping (Result<T>) -> Void
        ) -> Handle<T> {
        
        var requestHandle: Handle<T>?
        let task = self.session.dataTask(with: request) { (data, response, networkError) in
            
            let reason = FailureReason(code: (networkError as? NSError)?.code)
            
            /* ---------------------------------
             ** Ensure that we have a network
             ** reponse going forward, otherwise
             ** bail early.
             */
            guard let response = response as? HTTPURLResponse else {
                completion(Result<T>.failure(error: nil, reason: reason))
                return
            }
            
            let (json, error) = self.parseData(data, for: keyPath, with: response)
            
            /* ------------------------------------
             ** Use the response codes to determine
             ** whether the request succeeded or not.
             */
            let result: Result<T>
            
            if response.successful {
                result = .success(object: transformer(json))
            } else {
                result = .failure(error: error, reason: reason)
            }
            
            /* ---------------------------------
             ** Check the polling to see if we 
             ** have to continue polling or jump
             ** straight to completion.
             */
            if pollHandler?(result) ?? false {
                
                let handle: Handle<T> = self.taskWith(request: request, keyPath: keyPath, transformer: transformer, pollHandler: pollHandler, completion: completion)
                requestHandle!.setTask(task: handle.task)
                requestHandle!.resume()
                
            } else {
                completion(result)
            }
        }
        
        requestHandle = Handle(task: task, keyPath: keyPath)
        return requestHandle!
    }
    
    // ----------------------------------
    //  MARK: - Data Parsing -
    //
    private func parseData(_ data: Data?, for keyPath: String?, with response: HTTPURLResponse) -> (json: Any?, error: RequestError?) {
        
        var error: RequestError?
        var json:  Any?
        
        if let data = data,
            data.count > 2, // Empty json is '{}'
            var parsedJson = try? JSONSerialization.jsonObject(with: data, options: []) {
            
            /* ---------------------------------
             ** If a keyPath was provided, and
             ** the response was success, we'll
             ** unwrap the json object. Otherwise
             ** we assume the root is the error.
             */
            if response.successful {
                
                if let keyPath = keyPath {
                    let components = keyPath.components(separatedBy: ".")
                    for component in components {
                        parsedJson = (parsedJson as! JSON)[component]
                    }
                }
                json = parsedJson
                
            } else {
                var errorJSON     = parsedJson as! JSON
                errorJSON["code"] = response.statusCode
                error             = RequestError(json: errorJSON)
            }
        }
        
        return (json, error)
    }
}

// ----------------------------------
//  MARK: - HTTPURLResponse -
//
private extension HTTPURLResponse {
    var successful: Bool {
        return (self.statusCode / 100) == 2
    }
}
