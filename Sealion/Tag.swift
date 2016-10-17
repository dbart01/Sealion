//
//  Tag.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct Tag: JsonCreatable, Equatable {
    
    public let name:         String
    public let dropletCount: Int
    public let lastDroplet:  Droplet?
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: JSON) {
        self.name = json["name"] as! String
        
        let resourcesJSON = json["resources"]         as! JSON
        let dropletsJSON  = resourcesJSON["droplets"] as! JSON
        self.dropletCount = dropletsJSON["count"]     as! Int
        self.lastDroplet  = Droplet(json: dropletsJSON["last_tagged"] as? JSON)
        
    }
}

public func ==(lhs: Tag, rhs: Tag) -> Bool {
    return (lhs.name == rhs.name) &&
        (lhs.dropletCount == rhs.dropletCount) &&
        (lhs.lastDroplet  == rhs.lastDroplet)
}

// ----------------------------------
//  MARK: - Creation -
//
public extension Tag {
    
    public struct CreateRequest: JsonConvertible {
        
        public var name: String
        
        // ----------------------------------
        //  MARK: - Init -
        //
        public init(name: String) {
            self.name = name
        }
        
        // ----------------------------------
        //  MARK: - JsonConvertible -
        //
        public var json: JSON {
            return [
                "name" : self.name,
            ]
        }
    }
}

// ----------------------------------
//  MARK: - Tagging -
//
public extension Tag {
    
    public struct TagRequest: JsonConvertible {
        
        public struct Resource {
            
            public enum `Type`: String {
                case droplet = "droplet"
            }
            
            public let type: Type
            public let id:   Int
            
            // ----------------------------------
            //  MARK: - Init -
            //
            public init(type: Type, id: Int) {
                self.type = type
                self.id   = id
            }
        }
        
        public var resources: [Resource]
        
        // ----------------------------------
        //  MARK: - Init -
        //
        public init(resources: [Resource]) {
            self.resources = resources
        }
        
        // ----------------------------------
        //  MARK: - JsonConvertible -
        //
        public var json: JSON {
            return [
                "resources" : self.resources.map {
                    [
                        "resource_type" : $0.type.rawValue,
                        "resource_id"   : $0.id,
                    ]
                },
            ]
        }
    }
}
