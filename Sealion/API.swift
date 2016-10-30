//
//  API.swift
//  Sealion
//
//  Copyright (c) 2016 Dima Bart
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies,
//  either expressed or implied, of the FreeBSD Project.
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
        if let json = json as? JSON {
            object = T(json: json)
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
        request:      URLRequest,
        keyPath:      String? = nil,
        pollHandler:  ((Result<T>) -> Bool)? = nil,
        pollInterval: Double = 2.0,
        completion:   @escaping (Result<T>) -> Void
        ) -> Handle<T> {
        
        return self.taskWith(request: request, keyPath: keyPath, transformer: API.mapModelFrom(self), pollHandler: pollHandler, pollInterval: pollInterval, completion: completion)
    }
    
    internal func taskWith<T: JsonCreatable>(
        request:      URLRequest,
        keyPath:      String? = nil,
        pollHandler:  ((Result<[T]>) -> Bool)? = nil,
        pollInterval: Double = 2.0,
        completion:   @escaping (Result<[T]>) -> Void
        ) -> Handle<[T]> {
        
        return self.taskWith(request: request, keyPath: keyPath, transformer: API.mapModelCollectionFrom(self), pollHandler: pollHandler, pollInterval: pollInterval, completion: completion)
    }
    
    internal func taskWith<T>(
        request:      URLRequest,
        keyPath:      String? = nil,
        transformer:  @escaping ((Any?) -> T?),
        pollHandler:  ((Result<T>) -> Bool)? = nil,
        pollInterval: Double = 2.0,
        completion:   @escaping (Result<T>) -> Void
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
                result = .success(object: transformer(json ?? nil))
            } else {
                result = .failure(error: error, reason: reason)
            }
            
            /* ---------------------------------
             ** Check the polling to see if we 
             ** have to continue polling or jump
             ** straight to completion.
             */
            if pollHandler?(result) ?? false {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + pollInterval) {
                    guard let requestHandle = requestHandle, requestHandle.state != .cancelling else {
                        completion(result)
                        return
                    }
                    
                    let handle: Handle<T> = self.taskWith(request: request, keyPath: keyPath, transformer: transformer, pollHandler: pollHandler, completion: completion)
                    requestHandle.setTask(task: handle.task)
                    requestHandle.resume()
                }
                
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
                        parsedJson = (parsedJson as! JSON)[component]!
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
