//
//  ImageAction.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-15.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public enum ImageAction: JsonConvertible {
    
    case transferTo(region: String)
    case convert
    
    public var json: JSON {
        var container: JSON = [
            "type" : self.type,
        ]
        
        switch self {
        case .transferTo(let region):
            container["region"] = region
        default:
            break
        }
        
        return container
    }
    
    internal var type: String {
        switch self {
        case .transferTo: return "transfer"
        case .convert:    return "convert"
        }
    }
}
