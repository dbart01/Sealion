//
//  Volume.swift
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
                "size_gigabytes" : self.size,
                "name"           : self.name,
                "description"    : self.description,
                "region"         : self.region,
            ]
        }
    }
}

// ----------------------------------
//  MARK: - Snapshot Request -
//
public extension Volume {
    
    public struct SnapshotRequest: JsonConvertible {
        
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
