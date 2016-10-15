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

// ----------------------------------
//  MARK: - Creation -
//
public extension Record {
    
    public struct CreateRequest: JsonConvertible {
        
        public var kind:     Kind
        public var name:     String
        public var value:    String
        public var priority: Int?
        public var port:     Int?
        public var weight:   Int?
        
        // ----------------------------------
        //  MARK: - Init -
        //
        public init(kind: Kind, name: String, value: String, priority: Int? = nil, port: Int? = nil, weight: Int? = nil) {
            self.kind     = kind
            self.name     = name
            self.value    = value
            self.priority = priority
            self.port     = port
            self.weight   = weight
        }
        
        // ----------------------------------
        //  MARK: - JsonConvertible -
        //
        public var json: JSON {
            var c: JSON = [
                "type" : self.kind.rawValue,
                "name" : self.name,
                "data" : self.value,
            ]
            
            if let priority = self.priority { c["priority"] = priority }
            if let port     = self.port     { c["port"]     = port     }
            if let weight   = self.weight   { c["weight"]   = weight   }
            
            return c
        }
    }
}

// ----------------------------------
//  MARK: - Update -
//
public extension Record {
    
    public struct UpdateRequest: JsonConvertible {
        
        public var kind:     Kind?
        public var name:     String?
        public var value:    String?
        public var priority: Int?
        public var port:     Int?
        public var weight:   Int?
        
        // ----------------------------------
        //  MARK: - Init -
        //
        public init(kind: Kind? = nil, name: String? = nil, value: String? = nil, priority: Int? = nil, port: Int? = nil, weight: Int? = nil) {
            self.kind     = kind
            self.name     = name
            self.value    = value
            self.priority = priority
            self.port     = port
            self.weight   = weight
        }
        
        // ----------------------------------
        //  MARK: - JsonConvertible -
        //
        public var json: JSON {
            var c = JSON()
            
            if let kind     = self.kind     { c["type"]     = kind.rawValue }
            if let name     = self.name     { c["name"]     = name          }
            if let value    = self.value    { c["data"]     = value         }
            if let priority = self.priority { c["priority"] = priority      }
            if let port     = self.port     { c["port"]     = port          }
            if let weight   = self.weight   { c["weight"]   = weight        }
            
            return c
        }
    }
}
