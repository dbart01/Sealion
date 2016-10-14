//
//  VolumeAction.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-14.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public enum VolumeAction: JsonConvertible {
    
    case attachTo(droplet: Int, region: String)
    case detachFrom(droplet: Int, region: String)
    case attach(volume: String, droplet: Int, region: String)
    case detach(volume: String, droplet: Int, region: String)
    case resize(GB: Int, region: String)
    
    public var json: JSON {
        var container: JSON = [
            "type" : self.type,
        ]
        
        switch self {
        case .attachTo(let droplet, let region):
            container["droplet_id"]  = droplet
            container["region"]      = region
        case .detachFrom(let droplet, let region):
            container["droplet_id"]  = droplet
            container["region"]      = region
        case .attach(let volume, let droplet, let region):
            container["volume_name"] = volume
            container["droplet_id"]  = droplet
            container["region"]      = region
        case .detach(let volume, let droplet, let region):
            container["volume_name"] = volume
            container["droplet_id"]  = droplet
            container["region"]      = region
        case .resize(let GB, let region):
            container["size_gigabytes"] = GB
            container["region"]         = region
        }
        
        return container
    }
    
    internal var type: String {
        switch self {
        case .attachTo:   fallthrough
        case .attach:     return "attach"
        case .detachFrom: fallthrough
        case .detach:     return "detach"
        case .resize:     return "resize"
        }
    }
}
