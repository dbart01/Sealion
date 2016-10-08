//
//  BackupWindow.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-04.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct BackupWindow: JsonCreatable, Equatable {
    
    public let start: Date
    public let end:   Date
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: JSON) {
        self.start = Date(ISOString: json["start"] as! String)
        self.end   = Date(ISOString: json["end"]   as! String)
    }
}

public func ==(lhs: BackupWindow, rhs: BackupWindow) -> Bool {
    return (lhs.start == rhs.start) &&
        (lhs.end == rhs.end)
}
