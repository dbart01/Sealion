//
//  Volume.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-04.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct Volume: JsonCreatable, Equatable {
    
    public let id:          String
    public let name:        String
    public let description: String
    public let size:        Int // in GB
    public let createdAt:   Date
    public let dropletIDs:  [Int]
    public let region:      Region
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: JSON) {
        self.id          = json["id"]             as! String
        self.name        = json["name"]           as! String
        self.description = json["description"]    as! String
        self.size        = json["size_gigabytes"] as! Int
        self.dropletIDs  = json["droplet_ids"]    as! [Int]
        self.createdAt   = Date(ISOString: json["created_at"] as! String)
        self.region      = Region(json: json["region"] as! JSON)
    }
}

public func ==(lhs: Volume, rhs: Volume) -> Bool {
    return (lhs.id == rhs.id) &&
        (lhs.name        == rhs.name) &&
        (lhs.description == rhs.description) &&
        (lhs.size        == rhs.size) &&
        (lhs.dropletIDs  == rhs.dropletIDs) &&
        (lhs.createdAt   == rhs.createdAt) &&
        (lhs.region      == rhs.region)
}

// ----------------------------------
//  MARK: - Creation -
//
public extension Volume {
    
    public struct CreateRequest: JsonConvertible {
        
        public let size:        Int
        public let name:        String
        public let regionSlug:  String
        public let description: String
        
        public var json: Any {
            return [
                "size_gigabytes": self.size,
                "name":           self.name,
                "description":    self.description,
                "region":         self.regionSlug,
            ]
        }
    }
}
