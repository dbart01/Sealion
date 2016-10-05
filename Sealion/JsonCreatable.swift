//
//  JsonCreatable.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-02.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public typealias JSON = [String : Any]

public protocol JsonCreatable {
    init(json: JSON)
}

public extension JsonCreatable {
    static func collection(json: [JSON]) -> [Self] {
        return json.map {
            Self(json: $0)
        }
    }
}
