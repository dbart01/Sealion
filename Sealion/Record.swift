//
//  Record.swift
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
