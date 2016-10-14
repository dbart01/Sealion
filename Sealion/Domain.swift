//
//  Domain.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-14.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct Domain: JsonCreatable, Equatable {
    
    public let name: String
    public let zone: String?
    public let ttl:  Int
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: JSON) {
        self.name = json["name"]      as! String
        self.zone = json["zone_file"] as? String
        self.ttl  = json["ttl"]       as! Int
    }
}

public func ==(lhs: Domain, rhs: Domain) -> Bool {
    return (lhs.name == rhs.name) &&
        (lhs.ttl     == rhs.ttl) &&
        (lhs.zone    == rhs.zone)
}

// ----------------------------------
//  MARK: - Creation -
//
public extension Domain {
    
    public struct CreateRequest: JsonConvertible {
        
        public var ip:   String
        public var name: String
        
        // ----------------------------------
        //  MARK: - Init -
        //
        public init(ip: String, name: String) {
            self.ip   = ip
            self.name = name
        }
        
        // ----------------------------------
        //  MARK: - JsonConvertible -
        //
        public var json: JSON {
            return [
                "ip"   : self.ip,
                "name" : self.name,
            ]
        }
    }
}
