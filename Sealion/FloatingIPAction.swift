//
//  FloatingIPAction.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public enum FloatingIPAction: JsonConvertible {
    
    case assign(droplet: Int)
    case unassign
    
    public var json: JSON {
        var container: JSON = [
            "type" : self.type,
        ]
        
        switch self {
        case .assign(let dropletID):
            container["droplet_id"] = dropletID
        default:
            break
        }
        
        return container
    }
    
    internal var type: String {
        switch self {
        case .assign:   return "assign"
        case .unassign: return "unassign"
        }
    }
}
