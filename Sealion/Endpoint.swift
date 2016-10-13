//
//  Endpoint.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-02.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public enum Endpoint {
    case account
    case actions
    case actionWithID(Int)
    case volumes
    case volumeWithID(String)
    case droplets
    case dropletWithID(Int)
    case dropletActionsWithID(Int)
    case images
    case imageWithID(Int)
    case imageWithSlug(String)
    case imageActionsWithID(Int)
    case snapshots
    case snapshotWithID(Int)
    case sshKeys
    case sshKeyWithID(Int)
    case sshKeyWithFingerprint(String)
    case regions
    case sizes
    case floatingIPs
    case floatingIPWithIP(String)
    case floatingIPActionsWithIP(String)
    
    public var path: String {
        switch self {
        case .account:                         return "account"
        case .actions:                         return "actions"
        case .actionWithID(let id):            return "actions/\(id)"
        case .volumes:                         return "volumes"
        case .volumeWithID(let id):            return "volumes/\(id)"
        case .droplets:                        return "droplets"
        case .dropletWithID(let id):           return "droplets/\(id)"
        case .dropletActionsWithID(let id):    return "droplets/\(id)/actions"
        case .images:                          return "images"
        case .imageWithID(let id):             return "images/\(id)"
        case .imageWithSlug(let slug):         return "images/\(slug)"
        case .imageActionsWithID(let id):      return "images/\(id)/actions"
        case .snapshots:                       return "snapshots"
        case .snapshotWithID(let id):          return "snapshots/\(id)"
        case .sshKeys:                         return "account/keys"
        case .sshKeyWithID(let id):            return "account/keys/\(id)"
        case .sshKeyWithFingerprint(let f):    return "account/keys/\(f)"
        case .regions:                         return "regions"
        case .sizes:                           return "sizes"
        case .floatingIPs:                     return "floating_ips"
        case .floatingIPWithIP(let ip):        return "floating_ips/\(ip)"
        case .floatingIPActionsWithIP(let ip): return "floating_ips/\(ip)/actions"
        }
    }
}
