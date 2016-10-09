//
//  JsonConvertible.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-04.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public protocol JsonConvertible {
    var json: JSON { get }
}

extension Dictionary: JsonConvertible {
    public var json: JSON {
        return self as Any as! JSON
    }
}
