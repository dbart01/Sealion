//
//  Region.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-04.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct Region: JsonCreatable, Equatable {
    
    public let available: Bool
    public let name:      String
    public let slug:      String
    public let sizes:     [String]
    public let features:  [String]
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: JSON) {
        self.available = json["available"] as! Bool
        self.name      = json["name"]      as! String
        self.slug      = json["slug"]      as! String
        self.sizes     = json["sizes"]     as! [String]
        self.features  = json["features"]  as! [String]
    }
}

public func ==(lhs: Region, rhs: Region) -> Bool {
    return (lhs.available == rhs.available) &&
        (lhs.name   == rhs.name) &&
        (lhs.slug       == rhs.slug) &&
        (lhs.sizes         == rhs.sizes) &&
        (lhs.features    == rhs.features)
}
