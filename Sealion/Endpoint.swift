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
    
    internal var path: String {
        switch self {
        case .account: return "account"
        case .actions: return "actions"
        case .actionWith(let id): return "actions/\(id)"
        }
    }
}
