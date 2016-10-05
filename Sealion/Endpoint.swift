//
//  Endpoint.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-02.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

internal enum Endpoint {
    case account
    case actions
    case actionWith(Int)
    case volumes
    case volumeWith(String)
    case droplets
    
    internal var path: String {
        switch self {
        case .account:            return "account"
        case .actions:            return "actions"
        case .actionWith(let id): return "actions/\(id)"
        case .volumes:            return "volumes"
        case .volumeWith(let id): return "volume/\(id)"
        case .droplets:           return "droplets"
        }
    }
}
