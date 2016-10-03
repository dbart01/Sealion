//
//  API.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-02.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public enum ResponseError: Error {
    case Default(String)
    case NotAuthenticated
}

public enum Response<T> {
    case Success(T)
    case Failure(ResponseError)
}

public class API {
    
    public enum Version: String {
        case v2 = "https://api.digitalocean.com/v2"
    }
    
    public let version:  Version
    public let token:    String
    
    private let session: URLSession
    private let queue:   OperationQueue
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public init(version: Version, token: String) {
        self.version = version
        self.token   = token
        
        let config                   = URLSessionConfiguration()
        config.httpAdditionalHeaders = [
            "Authorization" : "Bearer \(token)",
        ]
        
        self.queue   = OperationQueue()
        self.session = URLSession(configuration: config, delegate: nil, delegateQueue: self.queue)
    }
}
