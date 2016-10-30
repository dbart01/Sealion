//
//  Tag.swift
//  Sealion
//
//  Copyright (c) 2016 Dima Bart
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies,
//  either expressed or implied, of the FreeBSD Project.
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
