//
//  Image.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-04.
//  Copyright © 2016 Dima Bart. All rights reserved.
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
