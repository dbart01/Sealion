//
//  JsonConvertible.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-04.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

protocol JsonConvertible {
    var json: Any { get }
}

extension Dictionary: JsonConvertible {
    var json: Any {
        return self
    }
}
