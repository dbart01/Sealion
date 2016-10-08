//
//  Droplet.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-04.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct Droplet: JsonCreatable, Equatable {
    
    public let id:          Int
    public let name:        String
    public let locked:      Bool
    public let status:      String
    public let features:    [String]
    public let tags:        [String]
    public let backupIDs:   [Int]
    public let snapshotIDs: [Int]
    public let volumeIDs:   [Int]
    public let kernel:      Kernel
    public let nextWindow:  BackupWindow
    public let image:       Image
    public let size:        Size
    public let region:      Region
    public let v4Networks:  [Network]
    public let v6Networks:  [Network]
    public let createdAt:   Date
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: JSON) {
        self.id          = json["id"]          as! Int
        self.name        = json["name"]        as! String
        self.locked      = json["locked"]      as! Bool
        self.status      = json["status"]      as! String
        self.features    = json["features"]    as! [String]
        self.tags        = json["tags"]        as! [String]
        self.backupIDs   = json["backup_ids"]   as! [Int]
        self.snapshotIDs = json["snapshot_ids"] as! [Int]
        self.volumeIDs   = json["volume_ids"]   as! [Int]
        self.kernel      = Kernel(json:       json["kernel"]     as! JSON)
        self.nextWindow  = BackupWindow(json: json["next_backup_window"] as! JSON)
        self.image       = Image(json:        json["image"]      as! JSON)
        self.size        = Size(json:         json["size"]       as! JSON)
        self.region      = Region(json:       json["region"]     as! JSON)
        
        let networksJSON = json["networks"] as! JSON
        self.v4Networks  = Network.collection(json: networksJSON["v4"] as! [JSON])
        self.v6Networks  = Network.collection(json: networksJSON["v6"] as! [JSON])
        self.createdAt   = Date(ISOString: json["created_at"] as! String)!
    }
}

public func ==(lhs: Droplet, rhs: Droplet) -> Bool {
    return (lhs.id == rhs.id) &&
        (lhs.name        == rhs.name) &&
        (lhs.locked      == rhs.locked) &&
        (lhs.status      == rhs.status) &&
        (lhs.features    == rhs.features) &&
        (lhs.tags        == rhs.tags) &&
        (lhs.backupIDs   == rhs.backupIDs) &&
        (lhs.snapshotIDs == rhs.snapshotIDs) &&
        (lhs.volumeIDs   == rhs.volumeIDs) &&
        (lhs.kernel      == rhs.kernel) &&
        (lhs.nextWindow  == rhs.nextWindow) &&
        (lhs.image       == rhs.image) &&
        (lhs.size        == rhs.size) &&
        (lhs.region      == rhs.region) &&
        (lhs.v4Networks  == rhs.v4Networks) &&
        (lhs.v6Networks  == rhs.v6Networks) &&
        (lhs.createdAt   == rhs.createdAt)
}
