//
//  RequestError.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-04.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct RequestError: JsonCreatable, Equatable {
    
    public let code:        Int
    public let id:          String?
    public let name:        String
    public let description: String
    
    // ----------------------------------
    //  MARK: - Init -
    //
    internal init(code: Int, id: String, name: String, description: String) {
        self.code        = code
        self.id          = id
        self.name        = name
        self.description = description
    }
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: JSON) {
        self.code        = json["code"]       as! Int
        self.id          = json["request_id"] as? String
        self.name        = json["id"]         as! String
        self.description = json["message"]    as! String
    }
}

public func ==(lhs: RequestError, rhs: RequestError) -> Bool {
    return (lhs.code     == rhs.code) &&
        (lhs.id          == rhs.id) &&
        (lhs.name        == rhs.name) &&
        (lhs.description == rhs.description)
}
