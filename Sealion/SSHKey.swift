//
//  SSHKey.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-09.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct SSHKey: JsonCreatable, Equatable {
    
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

public func ==(lhs: SSHKey, rhs: SSHKey) -> Bool {
    return (lhs.id == rhs.id) &&
        (lhs.name        == rhs.name) &&
        (lhs.publicKey   == rhs.publicKey) &&
        (lhs.fingerprint == rhs.fingerprint)
}

// ----------------------------------
//  MARK: - Creation -
//
public extension SSHKey {
    
    public struct CreateRequest: JsonConvertible {
        
        public var name:        String
        public var publicKey:   String
        
        // ----------------------------------
        //  MARK: - Init -
        //
        public init(name: String, publicKey: String) {
            self.name      = name
            self.publicKey = publicKey
        }
        
        // ----------------------------------
        //  MARK: - JsonConvertible -
        //
        public var json: JSON {
            return [
                "name"       : self.name,
                "public_key" : self.publicKey,
            ]
        }
    }
}
