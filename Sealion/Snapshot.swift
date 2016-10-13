//
//  Snapshot.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-12.
//  Copyright © 2016 Dima Bart. All rights reserved.
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
