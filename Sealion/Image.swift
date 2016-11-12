//
//  Image.swift
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

public struct Image: JsonCreatable, Equatable {
    
    public let id:              Int
    public let external:        Bool
    public let name:            String
    public let type:            String
    public let distribution:    String
    public let slug:            String?
    public let regionSlugs:     [String]
    public let createdAt:       Date
    public let minimumDiskSize: Double
    public let size:            Double
    
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: JSON) {
        self.id              = json["id"]             as! Int
        self.external        = json["public"]         as! Bool
        self.name            = json["name"]           as! String
        self.type            = json["type"]           as! String
        self.distribution    = json["distribution"]   as! String
        self.slug            = json["slug"]           as? String
        self.regionSlugs     = json["regions"]        as! [String]
        self.minimumDiskSize = json["min_disk_size"]  as! Double
        self.size            = json["size_gigabytes"] as! Double
        self.createdAt       = Date(ISOString: json["created_at"] as! String)!
    }
}

public func ==(lhs: Image, rhs: Image) -> Bool {
    return (lhs.id == rhs.id) &&
        (lhs.external        == rhs.external) &&
        (lhs.name            == rhs.name) &&
        (lhs.type            == rhs.type) &&
        (lhs.distribution    == rhs.distribution) &&
        (lhs.slug            == rhs.slug) &&
        (lhs.regionSlugs     == rhs.regionSlugs) &&
        (lhs.minimumDiskSize == rhs.minimumDiskSize) &&
        (lhs.size            == rhs.size) &&
        (lhs.createdAt       == rhs.createdAt)
}

// ----------------------------------
//  MARK: - ImageType -
//
public extension Image {
    
    public enum ImageType: ParameterConvertible {
        case user
        case application
        case distribution
        
        public var parameters: Parameters {
            switch self {
            case .user:         return ["private" : "true"]
            case .application:  return ["type" : "application"]
            case .distribution: return ["type" : "distribution"]
            }
        }
    }
}

// ----------------------------------
//  MARK: - Creation -
//
public extension Image {
    
    public struct UpdateRequest: JsonConvertible {
        
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
