//
//  Record.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-14.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct Record: JsonCreatable, Equatable {
    
    public enum Kind: String {
        case a     = "A"
        case aaaa  = "AAAA"
        case cname = "CNAME"
        case mx    = "MX"
        case txt   = "TXT"
        case srv   = "SRV"
        case ns    = "NS"
    }
    
    public let id:       Int
    public let kind:     Kind
    public let name:     String
    public let value:    String
    public let priority: Int?
    public let port:     Int?
    public let weight:   Int?
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: JSON) {
        self.id       = json["id"]       as! Int
        self.name     = json["name"]     as! String
        self.value    = json["data"]     as! String
        self.priority = json["priority"] as? Int
        self.port     = json["port"]     as? Int
        self.weight   = json["weight"]   as? Int
        self.kind     = Kind(rawValue: json["type"] as! String)!
    }
}

public func ==(lhs: Record, rhs: Record) -> Bool {
    return (lhs.id    == rhs.id) &&
        (lhs.kind     == rhs.kind) &&
        (lhs.name     == rhs.name) &&
        (lhs.value    == rhs.value) &&
        (lhs.priority == rhs.priority) &&
        (lhs.port     == rhs.port) &&
        (lhs.weight   == rhs.weight)
}
