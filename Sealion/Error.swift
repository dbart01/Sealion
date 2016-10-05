//
//  Error.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-04.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct RequestError: JsonCreatable, Equatable {
    
    public let id:          String
    public let name:        String
    public let description: String
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    internal init(id: String, name: String, description: String) {
        self.id          = id
        self.name        = name
        self.description = description
    }
    
    public init(json: JSON) {
        self.id          = json["id"]             as! String
        self.name        = json["name"]           as! String
        self.description = json["description"]    as! String
    }
}

public func ==(lhs: RequestError, rhs: RequestError) -> Bool {
    return (lhs.id == rhs.id) &&
        (lhs.name        == rhs.name) &&
        (lhs.description == rhs.description)
}
