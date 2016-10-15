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
    public let size:        DropletSize
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
        self.size        = DropletSize(json:  json["size"]       as! JSON)
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

// ----------------------------------
//  MARK: - Creation -
//
public extension Droplet {
    
    public struct CreateRequest: JsonConvertible {
        
        public var names:                [String]
        public var region:               String
        public var size:                 String
        public var image:                Identifier
        public var sshKeys:              [Identifier]?
        public var useBackups:           Bool      = false
        public var useIpv6:              Bool      = false
        public var usePrivateNetworking: Bool      = false
        public var userData:             String?   = nil
        public var volumes:              [String]? = nil
        
        // ----------------------------------
        //  MARK: - Init -
        //
        public init(name: String, region: String, size: String, image: Identifier) {
            self.init(names: [name], region: region, size: size, image: image)
        }
        
        public init(names: [String], region: String, size: String, image: Identifier) {
            self.names       = names
            self.region      = region
            self.size        = size
            self.image       = image
        }
        
        // ----------------------------------
        //  MARK: - JsonConvertible -
        //
        public var json: JSON {
            var container: JSON = [
                "region" : self.region,
                "size"   : self.size,
                "image"  : self.image,
            ]
            
            if self.names.count == 1 {
                container["name"] = self.names[0]
            } else {
                container["name"] = self.names
            }
            
            if let sshKeys = self.sshKeys {
                container["ssh_keys"] = sshKeys
            }
            
            if self.useBackups {
                container["backups"] = true
            }
            
            if self.useIpv6 {
                container["ipv6"] = true
            }
            
            if self.usePrivateNetworking {
                container["private_networking"] = true
            }
            
            if let userData = self.userData {
                container["user_data"] = userData
            }
            
            if let volumes = self.volumes, !volumes.isEmpty {
                container["volumes"] = volumes
            }
            
            return container
        }
    }
}
