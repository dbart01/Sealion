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
    case sshKeys
    case sshKeyWithID(Int)
    case sshKeyWithFingerprint(String)
    
    public var path: String {
        switch self {
        case .account:                      return "account"
        case .actions:                      return "actions"
        case .actionWithID(let id):         return "actions/\(id)"
        case .volumes:                      return "volumes"
        case .volumeWithID(let id):         return "volume/\(id)"
        case .droplets:                     return "droplets"
        case .dropletWithID(let id):        return "droplets/\(id)"
        case .sshKeys:                      return "account/keys"
        case .sshKeyWithID(let id):         return "account/keys/\(id)"
        case .sshKeyWithFingerprint(let f): return "account/keys/\(f)"
        }
    }
}
