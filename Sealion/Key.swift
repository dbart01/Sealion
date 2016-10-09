//
//  Key.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-09.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension Droplet {
    public struct Key: JsonCreatable, Equatable {
        
        public let id:          Int
        public let name:        String
        public let publicKey:   String
        public let fingerprint: String
        
        // ----------------------------------
        //  MARK: - JsonCreatable -
        //
        public init(json: JSON) {
            self.id          = json["id"]          as! Int
            self.name        = json["name"]        as! String
            self.publicKey   = json["public_key"]  as! String
            self.fingerprint = json["fingerprint"] as! String
        }
    }
}

public func ==(lhs: Droplet.Key, rhs: Droplet.Key) -> Bool {
    return (lhs.id == rhs.id) &&
        (lhs.name        == rhs.name) &&
        (lhs.publicKey   == rhs.publicKey) &&
        (lhs.fingerprint == rhs.fingerprint)
}

// ----------------------------------
//  MARK: - Creation -
//
public extension Droplet.Key {
    
    public struct CreateRequest: JsonConvertible {
        
        public var name:        String
        public var publicKey:   String
        
        public var json: JSON {
            return [
                "name":       self.name,
                "public_key": self.publicKey,
            ]
        }
    }
}
