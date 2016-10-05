//
//  Kernel.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-04.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct Kernel: JsonCreatable, Equatable {
    
    public let id:      Int
    public let name:    String
    public let version: String
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: JSON) {
        self.id      = json["id"]      as! Int
        self.name    = json["name"]    as! String
        self.version = json["version"] as! String
    }
}

public func ==(lhs: Kernel, rhs: Kernel) -> Bool {
    return (lhs.id == rhs.id) &&
        (lhs.name    == rhs.name) &&
        (lhs.version == rhs.version)
}
