//
//  JsonCreatable.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-02.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public protocol JsonCreatable {
    init(json: [String: Any])
}
