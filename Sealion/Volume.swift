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
        self.createdAt   = Date(ISOString: json["created_at"] as! String)!
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
        
        public var size:        Int
        public var name:        String
        public var region:      String
        public var description: String
        
        // ----------------------------------
        //  MARK: - Init -
        //
        public init(size: Int, name: String, region: String, description: String) {
            self.size        = size
            self.name        = name
            self.region      = region
            self.description = description
        }
        
        // ----------------------------------
        //  MARK: - JsonConvertible -
        //
        public var json: JSON {
            return [
                "size_gigabytes": self.size,
                "name":           self.name,
                "description":    self.description,
                "region":         self.region,
            ]
        }
    }
}

// ----------------------------------
//  MARK: - Volume Name -
//
public extension Volume {
    
    public struct Name: ParameterConvertible {
        
        public var name:   String
        public var region: String
        
        // ----------------------------------
        //  MARK: - Init -
        //
        public init(name: String, region: String) {
            self.name   = name
            self.region = region
        }
        
        // ----------------------------------
        //  MARK: - ParameterConvertible -
        //
        public var parameters: Parameters {
            return [
                "name"   : self.name,
                "region" : self.region,
            ]
        }
    }
}
