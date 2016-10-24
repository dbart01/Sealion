//
//  Stub.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-03.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation
import Sealion

// ----------------------------------
//  MARK: - Error Json -
//
struct MockError {
    
    let code:        Int
    let domain:      String
    let description: String
    
    init(domain: String = "MockErrorDomain", code: Int, description: String = "No description") {
        self.code        = code
        self.domain      = domain
        self.description = description
    }
    
    func cocoaError() -> NSError {
        return NSError(domain: self.domain, code: self.code, userInfo: [
            NSLocalizedDescriptionKey : self.description,
        ])
    }
}

// ----------------------------------
//  MARK: - Stub -
//
struct Stub {
    
    let status:  Int?
    let json:    JSON?
    let error:   MockError?
    let headers: [String : String]?
    
    var executionTime = 0.0
    
    var jsonData: Data? {
        if let json = self.json {
            return try? JSONSerialization.data(withJSONObject: json, options: [])
        }
        return nil
    }
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(status: Int? = nil, json: JSON? = nil, error: MockError? = nil, headers: [String : String]? = nil) {
        self.status  = status
        self.json    = json
        self.error   = error
        self.headers = headers
    }
}
