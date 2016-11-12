//
//  Snapshot.swift
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

public struct Snapshot: JsonCreatable, Equatable {
    
    public let id:              Int
    public let resourceID:      Int
    public let name:            String
    public let resourceType:    String
    public let regionSlugs:     [String]
    public let createdAt:       Date
    public let minimumDiskSize: Double
    public let size:            Double
    
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: JSON) {
        self.id              = json["id"]             as! Int
        self.resourceID      = json["resource_id"]    as! Int
        self.name            = json["name"]           as! String
        self.resourceType    = json["resource_type"]  as! String
        self.regionSlugs     = json["regions"]        as! [String]
        self.minimumDiskSize = json["min_disk_size"]  as! Double
        self.size            = json["size_gigabytes"] as! Double
        self.createdAt       = Date(ISOString: json["created_at"] as! String)!
    }
}

public func ==(lhs: Snapshot, rhs: Snapshot) -> Bool {
    return (lhs.id == rhs.id) &&
        (lhs.resourceID      == rhs.resourceID) &&
        (lhs.name            == rhs.name) &&
        (lhs.resourceType    == rhs.resourceType) &&
        (lhs.regionSlugs     == rhs.regionSlugs) &&
        (lhs.minimumDiskSize == rhs.minimumDiskSize) &&
        (lhs.size            == rhs.size) &&
        (lhs.createdAt       == rhs.createdAt)
}

// ----------------------------------
//  MARK: - ImageType -
//
public extension Snapshot {
    
    public enum SnapshotType: ParameterConvertible {
        case droplet
        case volume
        
        public var parameters: Parameters {
            switch self {
            case .droplet: return ["resource_type" : "droplet"]
            case .volume:  return ["resource_type" : "volume"]
            }
        }
    }
}
